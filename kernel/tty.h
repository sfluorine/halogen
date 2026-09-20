#pragma once

#include "vga.h"

void terminalInit();
void terminalSetColor(uint8_t foreColor, uint8_t backColor);
void terminalSetCursor(uint8_t x, uint8_t y);
void terminalPutChar(char c);