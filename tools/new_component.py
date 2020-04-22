#!/usr/bin/env python3

import os
import sys
import shutil
import re


def main():
    root_dir = ".."
    if os.path.exists("addons"):
        root_dir = "."

    os.chdir(root_dir)

    if len(sys.argv) == 1:
        print('The component name argument is required.')
        return 1

    component_name = sys.argv[1].lower()
    component_path = './addons/{}'.format(component_name)

    shutil.copytree('./extras/blank', component_path)

    for root, _, files in os.walk(component_path):
        for filename in files:
            path = os.path.join(root, filename)
            update = False

            f = open(path, 'r')
            lines = f.readlines()

            for i, line in enumerate(lines):
                if 'blank' in line:
                    new_line = re.sub(r"blank", component_name, line)

                    lines[i] = new_line
                    update = True

                if 'Blank' in line:
                    new_line = re.sub(
                        r"Blank", component_name.capitalize(), line)

                    lines[i] = new_line
                    update = True

                if 'BLANK' in line:
                    new_line = re.sub(r"BLANK", component_name.upper(), line)

                    lines[i] = new_line
                    update = True

            f.close()

            if update:
                f = open(path, 'w')
                f.writelines(lines)
                f.close()


if __name__ == "__main__":
    sys.exit(main())
