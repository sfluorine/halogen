CC 		= i686-elf-gcc
FASM	= fasm
CFLAGS	= -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -nostdlib

all: halogen.kernel

boot.o: boot.asm
	$(FASM) $^ $@

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c $^ -o $@

halogen.kernel: boot.o kernel.o
	$(CC) $(LDFLAGS) -T linker.ld -o $@ $^ -lgcc

clean:
	rm -f *.o *.kernel

.PHONY: all clean