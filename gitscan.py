#!/usr/bin/env python
# Scan each directory for Git status
# References:
# - [shell - How to execute a program or call a system command from Python - Stack Overflow](https://stackoverflow.com/questions/89228/how-to-execute-a-program-or-call-a-system-command-from-python)
import os, sys, getopt, subprocess

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
    print("  python gitscan.py [-d directory] [--show-all]")
    print()
    print("Arguments:")
    print("  -d, --directory directory : Specify a directory to scan. Omit to scan the current directory.")
    print("  -h, --help                : Print this usage string.")
    print("      --show-all            : Print all directories. Omit to print only unclean ones.")

def main(argv):
    try:
        opts, args = getopt.getopt(argv, "hd:", ["help", "directory=", "show-all"])
    except getopt.GetoptError as err:
        print(f"{bcolors.FAIL}Error: {err}{bcolors.ENDC}")
        print_usage()
        sys.exit(90)

    directory = ""
    show_all = False

    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print_usage()
            sys.exit()
        elif opt in ("-d", "--directory"):
            directory = os.path.abspath(arg)
        elif opt == "--show-all":
            show_all = True
    
    if not directory:
        directory = os.getcwd()
    if not directory:
        print(f"{bcolors.FAIL}Error: directory is not specified.{bcolors.ENDC}")
        print_usage()
        sys.exit(91)
    if not os.path.exists(directory):
        print(f"{bcolors.FAIL}Error: '{directory}' does not exist.{bcolors.ENDC}")
        sys.exit(92)

    for item in os.listdir(directory):
        abspath = os.path.join(directory, item)
        if os.path.isdir(abspath):
            print(item)
            os.chdir(abspath)
            result = subprocess.run(["git", "status"], stdout=subprocess.PIPE)
            print(result.stdout.decode("utf-8"))
    #         filename, ext = os.path.splitext(item)
    #         if not extensionRegex.findall(ext):
    #             newname = item + f".{extension}"
    #             newabspath = os.path.join(directory, newname)
    #             print(f"{item}\t{bcolors.WARNING}->\t{newname}{bcolors.ENDC}")
    #             if not dry_run:
    #                 shutil.move(abspath, newabspath)
    #         else:
    #             if show_all:
    #                 print(f"{item}")

if __name__ == "__main__":
    main(sys.argv[1:])
