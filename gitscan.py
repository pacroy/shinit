#!/usr/bin/env python
# Scan each directory for Git status
# References:
# - [shell - How to execute a program or call a system command from Python - Stack Overflow](https://stackoverflow.com/questions/89228/how-to-execute-a-program-or-call-a-system-command-from-python)
# - [python - Convert bytes to a string - Stack Overflow](https://stackoverflow.com/questions/606191/convert-bytes-to-a-string)
# - [python - How to check if the string is empty? - Stack Overflow](https://stackoverflow.com/questions/9573244/how-to-check-if-the-string-is-empty)
# - [python - How do I read the first line of a string? - Stack Overflow](https://stackoverflow.com/questions/11833266/how-do-i-read-the-first-line-of-a-string)
# - [python - Printing Lists as Tabular Data - Stack Overflow](https://stackoverflow.com/questions/9535954/printing-lists-as-tabular-data)
import os, sys, getopt, subprocess, re

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKCYAN = '\033[96m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def print_usage():
    print("Usage:")
    print("  python gitscan.py [-d directory] [-b branch] [--show-all]")
    print()
    print("Arguments:")
    print("  -d, --directory directory  : Specify a directory to scan. Omit to scan the current directory.")
    print("  -b, --default-branch branch: Specify the default branch. Default is 'main'.")
    print("  -h, --help                 : Print this usage string.")
    print("      --show-all             : Print all directories. Omit to print only unclean ones.")

def main(argv):
    try:
        opts, args = getopt.getopt(argv, "hd:b:", ["help", "directory=", "show-all", "default-branch="])
    except getopt.GetoptError as err:
        print(f"{bcolors.FAIL}Error: {err}{bcolors.ENDC}")
        print_usage()
        sys.exit(90)

    directory = ""
    show_all = False
    default_branch = "main"

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print_usage()
            sys.exit()
        elif opt in ("-d", "--directory"):
            directory = os.path.abspath(arg)
        elif opt == "--show-all":
            show_all = True
        elif opt in ("-b", "--default-branch"):
            default_branch = arg
    
    if not directory:
        directory = os.getcwd()
    if not directory:
        print(f"{bcolors.FAIL}Error: directory is not specified.{bcolors.ENDC}")
        print_usage()
        sys.exit(91)
    if not os.path.exists(directory):
        print(f"{bcolors.FAIL}Error: '{directory}' does not exist.{bcolors.ENDC}")
        sys.exit(92)

    branchRegex = re.compile(r"On branch (.+)\n")
    cleanRegex = re.compile(r"nothing to commit")
    for item in os.listdir(directory):
        abspath = os.path.join(directory, item)
        if os.path.isdir(abspath):
            print(item, end="")
            os.chdir(abspath)
            result = subprocess.run(["git", "status"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout = result.stdout.decode("utf-8")
            stderr = result.stderr.decode("utf-8")
            stderr_1stline = stderr.partition('\n')[0]
            if stderr:
                print(f"\t{bcolors.FAIL}{stderr_1stline}{bcolors.ENDC}")
            else:
                branch = branchRegex.findall(stdout)[0]
                if branch == default_branch:
                    print(f"\t{bcolors.OKGREEN}{branch}{bcolors.ENDC}", end='')
                else:
                    print(f"\t{bcolors.WARNING}{branch}{bcolors.ENDC}", end='')

                cleanMatchObject = cleanRegex.search(stdout)
                if cleanMatchObject is None:
                    print(f"\t{bcolors.WARNING}dirty{bcolors.ENDC}")
                else:
                    print(f"\t{bcolors.OKGREEN}clean{bcolors.ENDC}")

if __name__ == "__main__":
    main(sys.argv[1:])
