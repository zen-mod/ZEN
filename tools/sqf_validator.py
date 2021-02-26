#!/usr/bin/env python3

import fnmatch
import os
import re
import sys


def valid_keyword_after_code(content, index):
    for word in ["for", "do", "count", "each", "forEach", "else", "and", "not", "isEqualTo", "isNotEqualTo", "in", "call", "spawn", "execVM", "catch", "param", "select", "apply", "findIf", "remoteExec"]:
        if content.find(word, index, index + len(word)) != -1:
            return True

    return False


def check_sqf(filepath):
    errors = []

    with open(filepath, "r", encoding = "utf-8", errors = "ignore") as file:
        content = file.read()

        # Store all brackets we find in this file, so we can validate everything on the end
        brackets = []

        # Used in case we are in a line comment (//)
        ignore_till_eol = False

        # To check if we are in a comment block
        in_comment_block = False
        check_if_comment = False

        # Used in case we are in a comment block (/* */)
        # This is true if we detect a * inside a comment block
        # If the next character is a /, it means we end our comment block
        check_if_closing = False

        # We ignore everything inside a string
        in_string = False

        # Used to store the starting type of a string, so we can match that to the end of a string
        string_type = ""

        # Used to check for semicolon after code blocks
        last_is_curly_brace = False
        check_for_semicolon = False

        # Extra information so we know what line we find errors at
        line_number = 1

        char_index = 0

        for c in content:
            if last_is_curly_brace:
                last_is_curly_brace = False

                # Test generates false positives with binary commands that take CODE as 2nd arg (e.g. findIf)
                check_for_semicolon = not re.search("findIf", content, re.IGNORECASE)

            # Keep track of current line number
            if c == "\n":
                line_number += 1

            # While we are in a string, we can ignore everything else, except the end of the string
            if in_string:
                if c == string_type:
                    in_string = False

            # Look for the end of this comment block
            elif in_comment_block:
                if c == "*":
                    check_if_closing = True
                elif check_if_closing:
                    if c == "/":
                        in_comment_block = False
                    elif c != "*":
                        check_if_closing = False

            # If we are not in a comment block, we will check if we are at the start of one or count the () {} and []
            else:
                # This means we have encountered a /, so we are now checking if this is an inline comment or a comment block
                if check_if_comment:
                    check_if_comment = False

                    # If the next character after / is a *, we are at the start of a comment block
                    if c == "*":
                        in_comment_block = True

                    # Otherwise, check if we are in an line comment, / followed by another / (//)
                    elif c == "/":
                        ignore_till_eol = True

                if not in_comment_block:
                    if ignore_till_eol:
                        # We are in a line comment, just continue going through the characters until we find an end of line
                        if c == "\n":
                            ignore_till_eol = False
                    else:
                        if c == '"' or c == "'":
                            in_string = True
                            string_type = c
                        elif c == "/":
                            check_if_comment = True
                        elif c == "\t":
                            errors.append("  ERROR: Found a tab on line {}.".format(line_number))
                        elif c in ["(", "[", "{"]:
                            brackets.append(c)
                        elif c == ")":
                            if not brackets or brackets[-1] in ["[", "{"]:
                                errors.append("  ERROR: Missing parenthesis '(' on line {}.".format(line_number))
                            brackets.append(c)
                        elif c == "]":
                            if not brackets or brackets[-1] in ["(", "{"]:
                                errors.append("  ERROR: Missing square bracket '[' on line {}.".format(line_number))
                            brackets.append(c)
                        elif c == "}":
                            last_is_curly_brace = True

                            if not brackets or brackets[-1] in ["(", "["]:
                                errors.append("  ERROR: Missing curly brace '{{' on line {}.".format(line_number))
                            brackets.append(c)

                        if check_for_semicolon:
                            # Keep reading until no white space or comments
                            if c not in [" ", "\t", "\n", "/"]:
                                check_for_semicolon = False
                                if c not in ["]", ")", "}", ";", ",", "&", "!", "|", "="] and not valid_keyword_after_code(content, char_index):
                                    errors.append("  ERROR: Possible missing semicolon ';' on line {}.".format(line_number))

            char_index += 1

        # Compare opening and closing bracket counts
        if brackets.count("(") != brackets.count(")"):
            errors.append("  ERROR: Unequal number of parentheses, '(' = {}, ')' = {}.".format(brackets.count("("), brackets.count(")")))

        if brackets.count("[") != brackets.count("]"):
            errors.append("  ERROR: Unequal number of square brackets, '[' = {}, ']' = {}.".format(brackets.count("["), brackets.count("]")))

        if brackets.count("{") != brackets.count("}"):
            errors.append("  ERROR: Unequal number of curly braces, '{{' = {}, '}}' = {}.".format(brackets.count("{"), brackets.count("}")))

        # Ensure includes are before block comments
        if re.compile('\s*(/\*[\s\S]+?\*/)\s*#include').match(content):
            errors.append("  ERROR: Found an #include after a block comment.")

    return errors


def main():
    print("Validating SQF")
    print("--------------")

    # Allow running from root directory and tools directory
    root_dir = ".."
    if os.path.exists("addons"):
        root_dir = "."

    # Check all SQF files in the project directory
    sqf_files = []

    for root, _, files in os.walk(root_dir):
        for file in fnmatch.filter(files, "*.sqf"):
            sqf_files.append(os.path.join(root, file))

    sqf_files.sort()

    bad_count = 0

    for filepath in sqf_files:
        errors = check_sqf(filepath)

        if errors:
            print("\nFound {} error(s) in {}:".format(len(errors), os.path.relpath(filepath, root_dir)))

            for error in errors:
                print(error)

            bad_count += 1

    print("\nChecked {} files, found errors in {}.".format(len(sqf_files), bad_count))

    if bad_count == 0:
        print("SQF Validation PASSED")
    else:
        print("SQF Validation FAILED")

    return bad_count


if __name__ == "__main__":
    sys.exit(main())
