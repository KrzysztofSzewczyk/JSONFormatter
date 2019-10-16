
RM=rm
RMFLAGS=-rf

CC=gcc
CFLAGS=-Ofast -march=native -w

GIT=git

BFASM=asmbf/bfasm
BFI=asmbf/bfi

.PHONY: all clean

all: asmbf urldecode.b jsonformatter.b

clean:
	$(RM) $(RMFLAGS) urldecode.b jsonformatter.b asmbf

asmbf:
	git clone https://github.com/kspalaiologos/asmbf.git
	cd asmbf && make all && cd ..

urldecode.b: urldecode.asm
	$(BFASM) < $^ > $@

jsonformatter.b: jsonformatter.asm
	$(BFASM) < $^ > $@

