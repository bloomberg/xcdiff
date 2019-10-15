#!/usr/bin/env python3

import hashlib
import json
import subprocess
import sys
import os

#
# Manually Specified Commands
#
# The following commands will be used as tests.
#
# format: tuple `(alias_string, [command])`
#
# - note: aliases need to be unique, otherwise the generated tests may overwrite one another!
#
COMMANDS = [
    # list
    ("list", ["-l"]),

    # unknown option
    ("unknown", ["-unknown"]),

    # non existing tags
    ("non_existing_tag", ["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "targets, unsupported, unsupported_too"]),

    # non existing target
    ("non_existing_target", ["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-t", "NON_EXISTING"]),

    # differences only
    ("differences_only", ["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-d"]),

    # non existing projects
    ("p1_does_not_exist", ["-p1", "/not/existing/project1.xcodeproj", "-p2", "{ios_project_2}"]),
    ("p2_does_not_exist", ["-p1", "{ios_project_1}", "-p2", "/not/existing/project2.xcodeproj"]),
    ("p1_p2_do_not_exist", ["-p1", "/not/existing/project1.xcodeproj", "-p2", "/not/existing/project2.xcodeproj"]),

    # target only in second project (targets tag)
    ("target_only_in_second_g_targets", ["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "targets", "-t", "NewFramework", "-v"]),

    # target only in second project (headers tag)
    ("target_only_in_second_g_headers", ["-p1", "{ios_project_1}", "-p2", "{ios_project_2}", "-g", "headers", "-t", "NewFramework", "-v"]),
]

# 
# Auto generated command parameters
#
# The following parameters are used to auto generate command combinations
# to use as tests.
#
TAGS = [
    "",
    "file_references",
    "targets",
    "headers",
    "resources",
    "configurations",
    "settings",
    "sources",
    "source_trees",
    "dependencies"
]
TARGETS = ["", "Project", "NewFramework"]
FORMATS = ["", "console", "json", "markdown"]
VERBOSE = ["", "-v"]

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

def run_command(arguments):
    dirname = os.path.dirname(sys.argv[0])
    fixtures_path = os.path.join(dirname, "../Fixtures")
    project_1_path = os.path.join(fixtures_path, "ios_project_1/Project.xcodeproj")
    project_2_path = os.path.join(fixtures_path, "ios_project_2/Project.xcodeproj")
    arguments = [project_1_path if element == "{ios_project_1}" else element for element in arguments]
    arguments = [project_2_path if element == "{ios_project_2}" else element for element in arguments]
    print(arguments)
    return subprocess.Popen(arguments, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

def generate_command_tests_files():
    dirname = os.path.dirname(sys.argv[0])
    command_tests_path = os.path.join(dirname, "../CommandTests/Generated")
    commands = generate_commands() + COMMANDS
    command_run = ["swift", "run", "xcdiff"]

    remove_all_command_tests_files(command_tests_path)
    for command_tuple in commands:
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
