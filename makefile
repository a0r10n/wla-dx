
CC = gcc
CFLAGS = -c -O3 -ansi -pedantic -Wall -DMSDOS -DWIN32 -DSUPERFX
LD = gcc
LDFLAGS = -lkernel32
WLAFLAGS = $(CFLAGS) -DMSDOS -DSUPERFX

CFILES = main.c parse.c include_file.c pass_1.c pass_2.c pass_3.c pass_4.c stack.c listfile.c
HFILES = main.h parse.h include_file.h pass_1.h pass_2.h pass_3.h pass_4.h stack.h listfile.h defines.h
OFILES = main.o parse.o include_file.o pass_1.o pass_2.o pass_3.o pass_4.o stack.o listfile.o


all: $(OFILES) makefile
	$(LD) $(LDFLAGS) $(OFILES) -o wla-superfx.exe

main.o: main.c defines.h main.h makefile
	$(CC) $(CFLAGS) main.c

parse.o: parse.c defines.h parse.h makefile
	$(CC) $(CFLAGS) parse.c

include_file.o: include_file.c defines.h include_file.h makefile
	$(CC) $(CFLAGS) include_file.c

pass_1.o: pass_1.c defines.h pass_1.h parse.h makefile opcodes_gb.c opcodes_z80.c
	$(CC) $(CFLAGS) pass_1.c

pass_2.o: pass_2.c defines.h pass_2.h makefile
	$(CC) $(CFLAGS) pass_2.c

pass_3.o: pass_3.c defines.h pass_3.h makefile
	$(CC) $(CFLAGS) pass_3.c

pass_4.o: pass_4.c defines.h pass_4.h makefile
	$(CC) $(CFLAGS) pass_4.c

stack.o: stack.c defines.h stack.h makefile
	$(CC) $(CFLAGS) stack.c

listfile.o: listfile.c defines.h makefile
	$(CC) $(WLAFLAGS) listfile.c


$(OFILES): $(HFILES)


clean:
	rm -f $(OFILES) *~ wla-superfx.exe

install:
	make ; cp wla-superfx.exe /usr/local/bin