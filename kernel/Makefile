CC 		= i686-elf-gcc
FASM	= fasm
CFLAGS	= -ffreestanding -O2 -Wall -Wextra

BUILD_DIR = build

SRCS = $(wildcard *.c)
OBJS = $(BUILD_DIR)/boot.o $(SRCS:%.c=$(BUILD_DIR)/%.o)


all: $(BUILD_DIR) | $(BUILD_DIR)/halogen.kernel

$(BUILD_DIR)/boot.o: boot.asm
	$(FASM) $^ $@

$(BUILD_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -c $^ -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/halogen.kernel: $(OBJS)
	$(CC) $(CFLAGS) -nostdlib -T linker.ld -o $@ $^ -lgcc

clean:
	rm -rf build

.PHONY: all clean