
CC=gcc
TRKS?=4
CFLAGS=$(shell past -sd " " compile_flags.txt) -DTRKS=$(TRKS)

.PHONY: clean

track.wav: track.mid patch.csd
	csound --nodisplays patch.csd

track.mid: main
	./$< > $@

main: main.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -rf *.mid *.wav main
