#include "vga.h"

uint16_t vgaEncode(char c, uint8_t foreColor, uint8_t backColor)
{
	return (backColor << 12) | (foreColor << 8) | c;
}
