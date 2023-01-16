# Hello World in Assembly

This assembly code is a basic example of how to output a "Hello World" message in assembly.

The code is written in 64-bit and is composed of two sections: `.data` and `.text`.

## Section .data

This section contains the data that will be used by the program. In this case, we have a `message` variable that contains the string "Hello, World!" and a `message_length` variable that contains the length of the `message` string.

## Section .text

This section contains the instructions that will be executed when the program is run.

The code begins by setting up the parameters of the `write` system call. This system call is used to output data to the standard output. The `write` system call requires three parameters:

- The file descriptor (`rdi`)
- A pointer to the data that will be written (`rsi`)
- The length of the data (`rdx`)

In this case, we are writing to the standard output (`rdi = 1`) and passing the `message` and `message_length` variables as arguments.

Finally, the `exit` system call is used to exit the program with a status code of `0` (successful).

## Summary

This assembly code is a basic example of how to output a "Hello World" message using system calls. The code is divided into two sections, `.data` and `.text`, which contain the data and instructions respectively. The `write` system call is used to output the `message` string to the standard output and the `exit` system call is used to exit the program.
