
RM=rm
RMFLAGS=-rf

CC=gcc
CFLAGS=-Ofast -march=native -w

GIT=git

BFASM=asmbf/bfasm
BFI=asmbf/bfi

.PHONY: all clean test

test: all
	chmod +x jsonformat.cgi
	echo "var=%7B%22test%22%3A%22test%20%3A%20tests%20%5C%5Ctest%20%5C%22test%22%2C%5B%22simple%22%2C%0A%22as%22%2C%0A%22that%22%5D%7D" | ./jsonformat.cgi > output.hex
	diff output.hex expected.hex

all: format break asmbf urldecode.b jsonformatter.b urldecode_f.b jsonformatter_f.b

clean:
	$(RM) $(RMFLAGS) urldecode_f.b urldecode.b jsonformatter_f.b jsonformatter.b format break output.hex asmbf

format: format.c
	$(CC) $(CFLAGS) -o $@ $^

break: break.c
	$(CC) $(CFLAGS) -o $@ $^

asmbf:
	git clone https://github.com/kspalaiologos/asmbf.git
	cd asmbf && make all && cd ..

urldecode.b: urldecode.asm
	$(BFASM) < $^ > $@

jsonformatter.b: jsonformatter.asm
	$(BFASM) < $^ > $@

jsonformatter_f.b: jsonformatter.b
	chmod +x format
	./format flash.for < $^ > $@

urldecode_f.b: urldecode.b
	chmod +x format
	./format flash.for < $^ > $@

