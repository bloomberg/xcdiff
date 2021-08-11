#!/usr/bin/env python3

import hashlib
import json
import subprocess
import sys
import os
import pathlib
import re

with open(pathlib.Path(__file__).parent / "../CommandTests/manual_test_commands.json", "r") as manual_test_commands_file:
    manual_test_commands = json.load(manual_test_commands_file)

with open(pathlib.Path(__file__).parent /  "../CommandTests/generated_test_commands.json", "r") as generated_test_commands_file:
    generated_test_commands = json.load(generated_test_commands_file)

#
# Manually Specified Commands
#
# The following commands will be used as tests.
#
# format: tuple `(alias_string, [command])`
#
# - note: aliases need to be unique, otherwise the generated tests may overwrite one another!
#
COMMANDS = [(manual_command["alias"], manual_command["command"]) for manual_command in manual_test_commands]

#
# Auto generated command parameters
#
# The following parameters are used to auto generate command combinations
# to use as tests.
#
TAGS = generated_test_commands["tags"]
TARGETS = generated_test_commands["targets"]
FORMATS = generated_test_commands["formats"]
VERBOSE = generated_test_commands["verbose"]

def generate_command(tag, target, format, verbose):
    command = [
        "-p1", "{ios_project_1}",
        "-p2", "{ios_project_2}"
    ]
    alias = "p1_p2"

    if is_not_blank(tag):
        command += ["-g", tag]
        alias += "_" + tag + "_tag"

    if is_not_blank(target):
        command += ["-t", target]
        alias += "_" + target + "_target"

    if is_not_blank(format):
        command += ["-f", format]
        alias += "_" + format + "_format"

    if is_not_blank(verbose):
        command += ["-v"]
        alias += "_verbose"

    return (alias, command)

def generate_commands():
    commands = []
    for tag in TAGS:
        for target in TARGETS:
            for format in FORMATS:
                for verbose in VERBOSE:
                    commands += [generate_command(tag, target, format, verbose)]
    return commands

def is_not_blank(string):
    return bool(string and string.strip())

def build_project():
    subprocess.check_call(["swift", "build"])

def xcdiff_binary_path():
    bin_path = subprocess.check_output(["swift", "build", "--show-bin-path"]).strip().decode()
    return os.path.join(bin_path, "xcdiff")

def run_command(arguments):
    arguments = [substitute_project_paths(element) for element in arguments]
    print(arguments)
    return subprocess.Popen(arguments, stdout=subprocess.PIPE, stderr=subprocess.PIPE,  shell=False)

def substitute_project_paths(arg):
    dirname = os.path.dirname(sys.argv[0])
    fixtures_path = os.path.join(dirname, "../Fixtures")
    return re.sub("{(.*)}", "{}/\\1/Project.xcodeproj".format(fixtures_path), arg)

def generate_command_tests_files():
    dirname = os.path.dirname(sys.argv[0])
    command_tests_path = os.path.join(dirname, "../CommandTests/Generated")
    commands = generate_commands() + COMMANDS
    command_run = [xcdiff_binary_path()]
    remove_all_command_tests_files(command_tests_path)

    for command in commands:
        write_test_file(command_run, command, command_tests_path)

def write_test_file(command_run, command_tuple, command_tests_path):
    alias = command_tuple[0]
    command = command_tuple[1]
    out = run_command(command_run + command)
    output, _ = out.communicate()
    output_string = output.decode(sys.stdout.encoding)
    exit_code_string = str(out.returncode)
    hash_string = hashlib.sha256(alias.encode("utf-8")).hexdigest()[:8]
    filename = alias + "." + exit_code_string + "." + hash_string + ".md"
    file_path = os.path.join(command_tests_path, filename)
    f = open(file_path, "w")
    f.write("# Command\n")
    f.write("```json\n")
    f.write(json.dumps(command))
    f.write("\n")
    f.write("```\n")
    f.write("\n")
    f.write("# Expected exit code\n")
    f.write(exit_code_string)
    f.write("\n\n")
    f.write("# Expected output\n")
    f.write("```\n")
    f.write(output_string)
    f.write("\n```\n")
    f.close()

def remove_all_command_tests_files(command_tests_directory):
    for file in os.listdir(command_tests_directory):
        file_path = os.path.join(command_tests_directory, file)
        if os.path.isfile(file_path):
            os.unlink(file_path)

def main():
    build_project()
    generate_command_tests_files()

if __name__== "__main__":
    main()