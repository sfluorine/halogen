SUBDIRS = kernel

all: $(SUBDIRS) qemu

$(SUBDIRS):
	$(MAKE) -C $@

qemu:
	qemu-system-i386 -kernel kernel/build/halogen.kernel

clean:
	for dir in $(SUBDIRS); do $(MAKE) -C $$dir clean; done

.PHONY: $(SUBDIRS) clean qemu


