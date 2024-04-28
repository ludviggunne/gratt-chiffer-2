
CC=gcc
TRKS?=4
CFLAGS=-Wall -Wextra -Wpedantic -Werror -DTRKS=$(TRKS) -g

.PHONY: clean

track.wav: track.mid patch.csd
	csound -d patch.csd

track.mid: main
	./$< > $@

main: main.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -rf track.mid main
