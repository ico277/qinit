PREFIX = /usr/local
CC = gcc
CFILES = $(wildcard src/*.c)
EXECUTABLE = Q
CFLAGS = -O2

build:
	$(CC) $(CFILES) -o $(EXECUTABLE).out $(CFLAGS)

install: ./$(EXECUTABLE).out
	cp ./$(EXECUTABLE).out $(PREFIX)/bin/$(EXECUTABLE)

uninstall: $(PREFIX)/bin/$(EXECUTABLE)
	rm $(PREFIX)/bin/$(EXECUTABLE)

clean:
	rm ./$(EXECUTABLE).out 2> /dev/null || true
	rm ./$(EXECUTABLE)_debug.out 2> /dev/null || true
	rm ./vgcore* 2> /dev/null || true

run: build
	./$(EXECUTABLE).out

debug: clean
	$(CC) $(CFILES) -o $(EXECUTABLE).out_debug $(CFLAGS)
	valgrind --leak-check=full --show-leak-kinds=all ./$(EXECUTABLE).out_debug
	