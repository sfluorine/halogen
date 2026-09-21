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

section '.data' align 4096
page_directory:   dd 1024 dup 0
first_page_table: dd 1024 dup 0

section '.text' executable

public _start

_start:

    xor ecx, ecx
.fill_table:
    mov eax, ecx
    shl eax, 12                 ; ecx * 0x1000
    or  eax, 3
    mov [first_page_table + ecx*4], eax
    inc ecx
    cmp ecx, 1024
    jne .fill_table

    xor ecx, ecx
.fill_dir:
    mov dword [page_directory + ecx*4], 2
    inc ecx
    cmp ecx, 1024
    jne .fill_dir

    ; directory entry 0 -> first page table
    mov eax, first_page_table
    or  eax, 3
    mov [page_directory], eax

    mov eax, page_directory
    mov cr3, eax

    mov eax, cr0
    or  eax, 0x80000000
    mov cr0, eax

	mov esp, stack_top
	call kmain

	cli
.hlt:
	hlt
	jmp .hlt