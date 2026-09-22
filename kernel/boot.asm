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

public page_table

page_directory:
	dd 0x00000083
	times (768 - 1) dd 0
	dd 0x00000083
	times (1024 - 769) dd 0

page_table:
	times 1024 dd 0

section '.text' executable

public _start

_start:
	mov edi, (page_table - 0xC0000000)
	mov eax, 0x3
	mov ecx, 1024

.fill_page_table:
	mov [edi], eax
	add eax, 0x1000
	add edi, 0x4
	loop .fill_page_table

	mov eax, cr3
	or eax, (page_directory - 0xC0000000)
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
	mov dword [page_directory], 0
	invlpg [0]

	mov esp, stack_top
	call kmain

	cli
.hlt:
	hlt
	jmp .hlt