#!/usr/bin/env python3

# COMMENT VALIDATOR
# Author: CreepPork
# ---------------------
# Verifies all *.cpp, *.hpp and *.sqf files in the project.
# Checks if there are comments that start with a lowercase letter (all other symbols are ignored).

import fnmatch
import os
import re
import sys


def get_files():
    # Allow running from root directory and tools directory
    root_dir = '..'
    if os.path.exists('addons'):
        root_dir = '.'

    code_files = []

    for root, _, files in os.walk(root_dir):
        for file in files:
            if file.lower().endswith(('.cpp', '.hpp', '.sqf')):
                code_files.append(os.path.join(root, file))

    code_files.sort()

    return code_files


def lint_file_for_comments(filepath: str):
    invalid_comments = []

    with open(filepath, 'r') as file_contents:
        for (line_number, line) in enumerate(file_contents):
            contents = line.strip()

            # If regex matched a comment
            if re.search('^((?!http).)*//(\s|)*((?!http.*))[a-z]', contents):
                # Lines start with 1, but as indexes start with 0, so we have to increment
                invalid_comments.append((line_number + 1, contents))

    return invalid_comments


def main():
    print('Validating code comments')
    print('------------------------')

    exit_code = 0
    validated_files = 0
    errors_found = 0

    files = get_files()

    for filepath in files:
        comments = lint_file_for_comments(filepath)

        validated_files += 1

        # Skip files without errors
        if len(comments) == 0:
            continue

        errors_found += 1

        for (line_number, comment) in comments:
            if exit_code == 0:
                exit_code = 1

            print(f'ERROR: Comment must start with an uppercase letter.')
            print(f'       {filepath}:{line_number}')
            print(f'       {comment}')
            print()

    print(f'Checked {validated_files} files, found errors in {errors_found}.')
    print((
        'Comment validation PASSED' if exit_code == 0
        else 'Comment validation FAILED'
    ))

    return exit_code


if __name__ == '__main__':
    sys.exit(main())
