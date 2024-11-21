CC = gcc
AS = nasm

DEBUG = -g3 -O0
ARCH = -m32
PIE = -no-pie -fno-pie
STACK = -z noexecstack
CFLAGS = $(ARCH) $(PIE) $(DEBUG) -Wall
LDFLAGS = $(ARCH) $(PIE) $(STACK)
ASFLAGS = -g -f elf32 -F dwarf

PROG1 = part1
PROGS = $(PROG1) $(PROG2)

#There are some speciat make variables
#$@ is the target filename
#$^ is the names of all the prerequisites
#$< is the name of the first dependency
#there are others, but these are the ones we wilt be using

all: $(PROGS)

$(PROG1): $(PROG1).o
	$(CC) $(LDFLAGS) -o $@ $^

$(PROG1).o: $(PROG1).asm
	$(AS) $(ASFLAGS) -l $(PROG1).lst $<

clean:
	rm -f $(PROGS) *.s *.o *.lst *~ \#*

git checkin:
	if [ ! -d .git ] ; then git init; fi
	git add *.asm ?akefile
	git commit -m "comment"
	git push
TAR_FILE= ${LOGNAME}_$(PROG1).tar.gz

tar zip:
	rm -f $(TAR_FILE)
	tar cvaf $(TAR_FILE) *.asm [Mm]akefile
	tar tvaf $(TAR_FILE)