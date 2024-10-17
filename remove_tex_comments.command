#!/usr/bin/env python
import sys
import os

DEBUG = False

name_of_program = sys.argv[0]

# Read from user input the names of the files
file_names_list = sys.argv[1:]

def we_are_on_empty_line(text:list, pos:int):
    # checks if the line from here to end of line is empty.
    # empty means that contains only space " ", tab "\t", newline "\n"
    here = pos
    line = "" 
    while here < len(text) and text[here] not in {'\n'}:
        line += text[here]
        here += 1
    chars = set(line)
    if chars.issubset({" ","\t"}):
        return True
    else:
        return False
    

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


for file_name in file_names_list:
    print(f"Working on {file_name}.")
    new_file_name = "no_comments/" + file_name 

    # Read the file e put the content in text_with_comments
    with open(file_name,'r') as file:
        text_with_comments = file.read()
    
    # The new text will be in text_without_comments 
    text_without_comments = ""
    pos = 0
    while pos < len(text_with_comments) :
        if DEBUG:
            print(pos, text_with_comments[pos])
        # For each character char = text_with_comments[pos]
        if text_with_comments[pos] == '%':
            # if char is '%', then we walk through the text, chararcter by character, until char is '\n'
            while pos < len(text_with_comments) and text_with_comments[pos] != '\n':
                if DEBUG:
                    print("\t",pos, text_with_comments[pos])
                pos += 1
            # now char is '\n', and we do a step forward, 
            # and back to the beginning (checking if char is '%')
            pos += 1
            # all characters from '%' to '\n' are forgotten:
            # this might be a problem if there was an empty line
            if we_are_on_empty_line(text_with_comments,pos):
                # If we are on an empty line, we recover the '\n' so that we will keep an empty line.
                text_without_comments += '\n'
        else:
            # if char is not '%', we append it to text_without_comments, move to the next character 
            # and back to the beginning (checking if char is '%')
            text_without_comments += text_with_comments[pos]
            pos += 1
    
    with open(new_file_name,'w') as file:
        file.write(text_without_comments)
    
    print(f"Text from file {file_name} written without comments in {new_file_name}")

sys.exit(0)
