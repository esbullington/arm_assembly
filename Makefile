
AS := arm-linux-gnueabi-as

CC := arm-linux-gnueabi-gcc

CFLAGS := -static

EXE := program

all: $(EXE)

$(EXE): main.o
	$(CC) $(CFLAGS) -o $@ $<

main.o: main.S
	$(AS) -o $@ $<

clean:
	rm *.o $(EXE)

run:
	make --no-print-directory && qemu-arm $(EXE)


.PHONY: clean run
