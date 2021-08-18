#!/usr/bin/env python3

from pathlib import Path
import json
import urllib.request

tools_path = Path(__file__).parent

core_team = set()
contributors = set()

# Get contributors from GitHub
result = urllib.request.urlopen('http://api.github.com/repos/zen-mod/ZEN/contributors')
body = result.read()
for entry in json.loads(body.decode("utf-8")):
    contributors.add(entry['login'])

# Get core_team and other contributors
with open(tools_path / '../AUTHORS.txt', 'r') as stream:
    for line in stream:
        if line.startswith('# CORE TEAM'):
            break
    for line in stream:
        try:
            core_team.add(line.split()[0])
        except IndexError:
            break
    for line in stream:
        if line.startswith('# CONTRIBUTORS'):
            break
    for line in stream:
        contributors.add(line.strip())

contributors -= core_team

print('\n'.join(sorted(contributors, key=lambda name: name.lower())))
