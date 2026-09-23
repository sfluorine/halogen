#include "tty.h"

#include <stddef.h>

static size_t strlen(const char* str)
{
	size_t i = 0;
	for (; str[i] != 0; i++) {}
	return i;
}

static void putStr(const char* str, size_t size)
{
	for (size_t i = 0; i < size; i++)
		terminalPutChar(str[i]);
}

static void putCStr(const char* str)
{
	putStr(str, strlen(str));
}

static void printInteger(uint32_t integer)
{
	size_t length = 0;
	char buffer[16];

	while (integer) {
		buffer[15 - length] = (integer % 10) + '0';
		integer /= 10;
		length++;
	}

	const char* startingBuffer = buffer + (16 - length);
	putStr(startingBuffer, length);
}

void kmain()
{
	terminalInit();

	for (size_t i = 0; i < 1024; i++) {
		printInteger(69420);
		putCStr("\n");
	}
}