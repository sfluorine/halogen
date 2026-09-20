format ELF

ALIGNBIT 	= 1 shl 0
MEMINFO 	= 1 shl 1
FLAGS		= ALIGNBIT or MEMINFO
MAGIC		= 0x1BADB002
CHECKSUM	= -(MAGIC + FLAGS)

extrn kmain

section '.multiboot' align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

section '.bss' align 16
stack_bottom:
	rb 0x4000
stack_top:

section '.text' executable

public _start

_start:
	mov esp, stack_top

	call kmain

	cli

hang:
	hlt
	jmp hang