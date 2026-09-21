CC 		= i686-elf-gcc
FASM	= fasm
CFLAGS	= -ffreestanding -O2 -Wall -Wextra

BUILD_DIR = build

SRCS = $(wildcard *.c)
OBJS = $(BUILD_DIR)/boot.o $(SRCS:%.c=$(BUILD_DIR)/%.o)

all: $(BUILD_DIR)/halogen.kernel

$(BUILD_DIR):
	mkdir -p $@

$(BUILD_DIR)/boot.o: boot.asm | $(BUILD_DIR)
	$(FASM) $^ $@

$(BUILD_DIR)/%.o: %.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/halogen.kernel: $(OBJS) linker.ld
	$(CC) $(CFLAGS) -nostdlib -T linker.ld -o $@ $(OBJS) -lgcc

clean:
	rm -rf build

.PHONY: all clean