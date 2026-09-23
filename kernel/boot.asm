format ELF

ALIGNBIT 	= 1 shl 0
MEMINFO 	= 1 shl 1
FLAGS		= ALIGNBIT or MEMINFO
MAGIC		= 0x1BADB002
CHECKSUM	= -(MAGIC + FLAGS)

; 4 MB Page Size Extension bit in CR4
CR4_PSE = 1 shl 4
; Paging enable bit in CR0
CR0_PG = 1 shl 31

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

page_directory:
	dd 0x00000083
	times (768 - 1) dd 0
	dd 0x00000083
	times (1024 - 769) dd 0

page_table:
	times 1024 dd 0

section '.rodata' align 8

gdt_start:
	dd 0x00000000
	dd 0x00000000

	dw 0xFFFF
	dw 0x0000
	db 0x00
	db 10011010b
    db 11001111b
    db 0x00

	dw 0xFFFF
    dw 0x0000
    db 0x00
	db 10010010b
    db 11001111b
    db 0x00
gdt_end:

gdt_ptr:
	dw gdt_end - gdt_start - 1
	dd gdt_start

section '.text' executable

public _start

_start:
	mov eax, (page_directory - 0xC0000000)
	mov cr3, eax

	mov eax, cr4
	or eax, CR4_PSE
	mov cr4, eax

	mov eax, cr0
	or eax, CR0_PG
	mov cr0, eax

	lea eax, [higher_half]
	jmp eax

higher_half:
	lgdt [gdt_ptr]

	jmp 0x08:.reload_cs

.reload_cs:
	mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

	mov dword [page_directory], 0
	invlpg [0]

	mov esp, stack_top
	call kmain

	cli
.hlt:
	hlt
	jmp .hlt