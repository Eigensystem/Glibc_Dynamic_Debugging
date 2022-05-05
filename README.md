# README

## Introduction

- Compiled mainstream version of libc & ld from 2.23 to 2.34
- Patch a ELF file and change its dynamic link library to a specific version between 2.23 and 2.34

## Install

- Dependence : [patchelf](https://github.com/NixOS/patchelf)
- You may get old version of patchelf from software sources. To get the latest version, please visit the [github repo](https://github.com/NixOS/patchelf).
- Arch

```bash
yay -S patchelf
```

- Ubuntu & Debain

```bash
sudo apt install patchelf
```

## Usage

1. Clone the repo
2. (To make it more convenient, you may write a alias in your shell config file)

```bash
./change.sh dest_libc_version path_to_your_elf
```

1. Enjoy your new libc

## Examples

```bash
$ ls
2.23  2.25  2.26  2.27  2.28  2.29  2.30  2.31  2.32  2.33  2.34  change.sh  house_of_lore

$ ldd house_of_lore
	linux-vdso.so.1 (0x00007ffd51731000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f48d30fa000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f48d36ee000)

$ ./change.sh 2.27 house_of_lore

$ ldd house_of_lore
	linux-vdso.so.1 (0x00007ffdcb582000)
	/root/pwn/Heap_Learning/glibc_dynamic_debuging/2.27/libc-2.27.so (0x00007fb26d591000)
	/root/pwn/Heap_Learning/glibc_dynamic_debuging/2.27/ld-2.27.so => /lib64/ld-linux-x86-64.so.2 (0x00007fb26db4b000)

$ ./change.sh 2.31 house_of_lore

$ ldd house_of_lore
	linux-vdso.so.1 (0x00007ffc843c0000)
	/root/pwn/Heap_Learning/glibc_dynamic_debuging/2.31/libc-2.31.so (0x00007fb0ec038000)
	/root/pwn/Heap_Learning/glibc_dynamic_debuging/2.31/ld-2.31.so => /lib64/ld-linux-x86-64.so.2 (0x00007fb0ec5fb000)
```

## Problems

- If you got this error:

```bash
warning: working around a Linux kernel bug by creating a hole of 2093056 bytes in ‘your_elf_name’
```

It is because you have a old version of patchelf. Visit official repo above to get latest version then you will solve the problem :D
