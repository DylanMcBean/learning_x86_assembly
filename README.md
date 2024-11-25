# Assembly(x64) Language Programs

This repository contains a collection of x86-64 assembly language programs designed for learning and experimentation. It also includes a comprehensive shell script for assembling, linking, and executing these programs.

## File Structure

- **Program_Name**: Folders containing the assembly source code and other project files for each program. Each folder must contain a `main.asm` file, which serves as the entry point for the program.
- **.gitignore**: Specifies files and directories to ignore when using Git.
- **compile**: A shell script for assembling, linking, and executing assembly programs.
- **README.md**: This file.

## Prerequisites

Ensure the following tools are installed on your system:
- `nasm`: The Netwide Assembler for assembling the `.asm` files.
- `ld`: The GNU linker for linking object files.
- `gdb`: The GNU Debugger, if debugging is needed.
- `strace`: A system call tracer for Linux systems.

## Usage

Run the `compile` script with appropriate options to assemble, link, and execute a program. At a minimum, you must provide the `-f` option followed by the name of the folder containing the assembly source code.

### Script Options

- `-f <folder_name>`: **Required**. Specifies the folder containing the assembly file to be compiled. This folder must include a `main.asm` file.
- `-d`: Removes the output binary file after execution.
- `-h`: Displays the help message with detailed usage instructions.
- `-i`: Includes the local directory (the folder specified with `-f`) in the search path for libraries.
- `-g`: Compiles with debugging information included.
- `-t`: Runs the program with `strace` if auto-run is enabled. Takes precedence over `GDB` if both are enabled.
- `-r`: Automatically runs the compiled program after linking. Uses `GDB` for debugging if `-g` is specified.
- `-v`: Enables verbose output, providing more details during execution.
- `-s`: Optimizes the output file size by stripping symbol information.
- `-o <output_dir>`: Specifies a custom directory for storing the compiled binary. Defaults to a `Build` folder if not provided.

### Example

```sh
./compile -f "HelloWorld"
```

This command assembles and links the `main.asm` file in the `HelloWorld` folder, and the output binary is stored in the `Build` folder (unless the `-d` flag is used).

To enable debugging and run the program automatically with `GDB`, use:

```sh
./compile -f "HelloWorld" -g -r
```

To include a local library path and optimize the binary size:

```sh
./compile -f "HelloWorld" -i -s
```

### Outputs

- By default, the compiled binary will be saved in the `Build` folder. If a custom directory is specified using the `-o` option, the binary will be moved there.
- If the `-d` option is used, the binary will be deleted after execution.
- If `-t` is used, system calls will be logged to a file named `strace.log` in the specified folder.

### License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

### Disclaimer

These programs are for educational purposes only. Ensure you understand the code being executed. The author assumes no responsibility for any misuse or damages arising from the use of this code.
