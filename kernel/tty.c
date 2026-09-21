#include "tty.h"

uint16_t* g_vgaBuffer = (uint16_t*)VGA_BUFFER;

uint8_t g_foreColor = VGA_COLOR_WHITE;
uint8_t g_backColor = VGA_COLOR_BLACK;
uint8_t g_cursorColumn = 0;
uint8_t g_cursorRow = 0;

// TODO: implement terminal scrolling.

void terminalInit() // clear VGA buffer.
{
	for (int y = 0; y < VGA_BUFFER_HEIGHT; y++) {
		for (int x = 0; x < VGA_BUFFER_WIDTH; x++)
			g_vgaBuffer[y * VGA_BUFFER_WIDTH + x] = vgaEncode(' ', VGA_COLOR_BLACK, VGA_COLOR_BLACK);
	}
}

void terminalSetColor(uint8_t foreColor, uint8_t backColor) // set color for current cursor until changed.
{
	g_foreColor = foreColor;
	g_backColor = backColor;
}

void terminalSetCursor(uint8_t x, uint8_t y)
{
	g_cursorColumn = x;
	g_cursorRow = y;
}

void terminalPutChar(char c)
{
	if (c == '\n') {
		g_cursorColumn = 0;
		g_cursorRow += 1;
		return;
	}

	g_vgaBuffer[g_cursorRow * VGA_BUFFER_WIDTH + g_cursorColumn] = vgaEncode(c, g_foreColor, g_backColor);

	if (++g_cursorColumn >= VGA_BUFFER_WIDTH) {
		g_cursorColumn = 0;
		if (++g_cursorRow >= VGA_BUFFER_HEIGHT)
			g_cursorRow = 0;
	}
}