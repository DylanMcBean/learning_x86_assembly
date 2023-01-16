# Assembly(x64) Language Programs

This repository contains a collection of asembly language programs to help me learn assembly, it also has scripts for assembling, linking and executing the programs.

## File Structure

- **Program_Name**: Folders containing the assembly source code and other project files for each program. Each folder should contain a `main.asm` file which is the entry point for the program.
- **.gitignore**: A file specifying files and directories to ignore when using git.
- **compile**; A shell script for assembling, linking and executing the program(s)
- **README.md**: This file

## How to Use

1. make sure you have **NASM** and **ld** installed on your machine.
2. Run the `compile` script with the `-f` option followed by the name of the folder containing the assembly source code.
3. The script will assemble, link and execute the program, and the output will be stored in the **Builds** folder.

### Options for `compile` script

- `-d`: This option is used to remove the output file after execution
- `-h`: Show the Help message
- `-f`: Folder name containing the assembly file to be compiled

#### Example

```sh
./compile -f "Hello World"
```

this would assemble and link the main.asm file in the `Hello World` folder and execute it. the output binary file will be stored in the **Builds** folder aslong as the `-d` flag is not passed.

### License

- This program is licensed under the MIT License. See the LICENSE file for details.

### Disclaimer

- These programs are for educational purposes only. The author of these programs is not responsible for any damages that may result from the use of these programs.
- If you wish to execute any of these scripts, please make sure you understand the code that is being run.
