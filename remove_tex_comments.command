#!/usr/bin/env python
import sys
import os

DEBUG = False

name_of_program = sys.argv[0]

# Create the output directory
directory_name = "no_comments"
try:
    os.mkdir(directory_name)
    print(f"Directory '{directory_name}' created successfully.")
except FileExistsError:
    print(f"Directory '{directory_name}' already exists.")
    ans = input("Files will be overwritten! Continue? [y/N] ")
    if ans != 'y':
        print(f"Program \"{name_of_program}\" will terminate.")
        sys.exit(0)
except PermissionError:
    print(f"Permission denied: Unable to create '{directory_name}'.")
    print(f"Program \"{name_of_program}\" will terminate.")
    sys.exit(1)
except Exception as e:
    print(f"An error occurred: {e}")
    print(f"Program \"{name_of_program}\" will terminate.")
    sys.exit(1)

# Read from user input the names of the files
file_names_list = sys.argv[1:]

for file_name in file_names_list:
    print(f"Working on {file_name}.")
    new_file_name = "no_comments/" + file_name 

    with open(file_name,'r') as file:
        text_with_comments = file.read()

    text_without_comments = ""
    pos = 0
    while pos < len(text_with_comments) :
        if DEBUG:
            print(pos, text_with_comments[pos])
        if text_with_comments[pos] == "%":
            while pos < len(text_with_comments) and text_with_comments[pos] != '\n':
                if DEBUG:
                    print("\t",pos, text_with_comments[pos])
                pos += 1
            pos += 1
        else:
            text_without_comments += text_with_comments[pos]
            pos += 1
    
    with open(new_file_name,'w') as file:
        file.write(text_without_comments)
    
    print(f"Text from file {file_name} written without comments in {new_file_name}")

sys.exit(0)
