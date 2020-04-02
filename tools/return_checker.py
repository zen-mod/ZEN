#!/usr/bin/env python3

import fnmatch
import os
import re
import sys


def get_files():
    # Allow running from root directory and tools directory
    root_dir = ".."
    if os.path.exists("addons"):
        root_dir = "."

    sqf_files = []

    for root, _, files in os.walk(root_dir):
        for file in fnmatch.filter(files, "*.sqf"):
            sqf_files.append(os.path.join(root, file))

    sqf_files.sort()

    return sqf_files


def filter_files(filepaths):
    filtered_files = []

    # Return only files that have a docblock
    for filepath in filepaths:
        with open(filepath, 'r') as file_contents:
            for line in file_contents:
                contents = line.strip()

                # A possible docblock starts
                if contents.startswith('/*'):
                    # Find the `* Return Value:` comment
                    lines = list(map(
                        # Remove \n from all the lines
                        (lambda s: s.strip()), file_contents.readlines()
                    ))

                    return_value_comment_index = lines.index('* Return Value:')
                    return_value_index = return_value_comment_index + 1

                    # Drop the first two characters (e.g. `* `) so it returns the return type
                    return_value = lines[return_value_index][2:]

                    filtered_files.append([filepath, return_value])

                    break

    return filtered_files


def get_last_line(filepath):
    with open(filepath, 'r') as file_contents:
        lines = file_contents.readlines()
        last_line = lines[-1].strip()

        # Handle multiple blank lines at the end of the file
        if last_line == "":
            i = -2

            while lines[i].strip() == "":
                i -= 1

            return lines[i].strip()
        return last_line


def check_last_character(filepath, return_value):
    last_line = get_last_line(filepath)
    last_line_character = last_line[-1]

    # If return type is None and the last line has a semicolon OR the last thing is just the nil keyword OR last thing is a closing bracket
    if return_value == 'None' and (last_line_character == ';' or last_line == 'nil' or last_line == '};'):
        return True
    elif return_value != 'None' and (last_line_character != ';' or last_line == '};'):
        return True
    else:
        return False


def get_expected_last_line(last_line, return_value):
    last_line_character = last_line[-1]

    if return_value == 'None':
        # If last character is a letter or a number
        if re.search(r'[A-Za-z0-9]', last_line_character):
            return '{};'.format(last_line)
        else:
            return 'nil'
    else:
        if last_line_character == ';':
            return last_line[:-1]

    return 'Unknown'


def main():
    print('Validating Return Types')
    print('-----------------------')

    bad_files = []

    files = get_files()
    filtered_files = filter_files(files)

    for file_details in filtered_files:
        filepath, return_value = file_details

        status = check_last_character(filepath, return_value)

        if not status:
            bad_files.append(
                [filepath, return_value, get_last_line(filepath)])

    error_count = len(bad_files)
    print('Found {} error(s)'.format(error_count))

    for bad_file in bad_files:
        filepath, return_value, last_line = bad_file

        expected_last_line = get_expected_last_line(last_line, return_value)

        print('\nERROR: In file {}'.format(filepath))
        print('Incorrect return type, expected `{}`'.format(return_value))
        print('Found line    `{}`'.format(last_line))
        print('Expected line `{}`'.format(expected_last_line))

    if error_count:
        print('\nReturn Validation FAILED')
    else:
        print('\nReturn Validation PASSED')

    return error_count


if __name__ == "__main__":
    sys.exit(main())
