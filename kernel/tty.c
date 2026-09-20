#include "tty.h"

uint16_t* g_vgaBuffer = (uint16_t*)VGA_BUFFER;

uint8_t g_foreColor = VGA_COLOR_WHITE;
uint8_t g_backColor = VGA_COLOR_BLACK;
uint8_t g_cursor = 0;

void terminalInit()
{
}

void terminalSetColor(uint8_t foreColor, uint8_t backColor) // set color for current cursor until changed.
{
}

void terminalSetCursor(uint8_t x, uint8_t y)
{
}

void terminalPutChar(char c)
{
	g_vgaBuffer[g_cursor] = vgaEncode(c, g_foreColor, g_backColor);
}