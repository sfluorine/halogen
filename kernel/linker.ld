ENTRY(_start)

SECTIONS
{
	. = 0xC0100000;

	.text : AT(ADDR(.text) - 0xC0000000)
	{
		*(.multiboot)
		*(.text .text.*)
	}

	.rodata ALIGN(4K) : AT(ADDR(.rodata) - 0xC0000000)
	{
		*(.rodata .rodata.*)
	}

	.data ALIGN(4K) : AT(ADDR(.data) - 0xC0000000)
	{
		*(.data .data.*)
	}

	.bss ALIGN(4K) : AT(ADDR(.bss) - 0xC0000000)
	{
		*(.bss .bss.*)
	}

	_kernel_end = .;
}