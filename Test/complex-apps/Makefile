main : *.*
	clear
	riscv32-unknown-elf-gcc test.c -o test -O1 -nostartfiles -nostdlib -e start -Wl,-Ttext-segment,-0x94
	riscv32-unknown-elf-objdump -d test > test.s
	cat test.s | grep -E '^\s*[0-9a-f]+:.*$$' | grep -o -E '^\s*[0-9a-f]+:\s*[0-9a-f]+' | grep -o -E '[0-9a-f]+$$' > test.dat
	cat test.dat | sed ':a;N;s/\n/,/g;ta' | sed '1i;1.asm\nmemory_initialization_radix=16; \nmemory_initialization_vector=' | sed '$$s/$$/;/g' > test.coe