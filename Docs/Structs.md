# This file contains the documentation for the structs used.

## Stat Struct
### Description
Strict is used too store the stats about a file in the file system

### Layout
| Field          | Description                             | Size          | Offset        |
|----------------|-----------------------------------------|---------------|---------------|
| `st_dev`       | ID of device containing file            | 8 bytes       | 0 bytes       |
| `st_ino`       | Inode number                            | 8 bytes       | 8 bytes       |
| `st_nlink`     | Number of hard links                    | 8 bytes       | 16 bytes      |
| `st_mode`      | Protection                              | 8 bytes       | 24 bytes      |
| `st_uid`       | User ID of owner                        | 8 bytes       | 32 bytes      |
| `st_gid`       | Group ID of owner                       | 8 bytes       | 40 bytes      |
| `__pad0`       | Padding                                 | 8 bytes       | 48 bytes      |
| `st_rdev`      | Device ID (if special file)             | 8 bytes       | 56 bytes      |
| `st_size`      | Total size, in bytes                    | 8 bytes       | 64 bytes      |
| `st_blksize`   | Blocksize for filesystem I/O            | 8 bytes       | 72 bytes      |
| `st_blocks`    | Number of 512B blocks allocated         | 8 bytes       | 80 bytes      |
| `st_atime`     | Time of last access                     | 8 bytes       | 88 bytes      |
| `st_atime_nsec`| Time of last access, nanoseconds        | 8 bytes       | 96 bytes      |
| `st_mtime`     | Time of last modification               | 8 bytes       | 104 bytes     |
| `st_mtime_nsec`| Time of last modification, nanoseconds  | 8 bytes       | 112 bytes     |
| `st_ctime`     | Time of last status change              | 8 bytes       | 120 bytes     |
| `st_ctime_nsec`| Time of last status change, nanoseconds | 8 bytes       | 128 bytes     |
| `__unused`     | Unused                                  | 24 bytes      | 136 bytes     |
| **Total**      |                                         | **144 bytes** |               |