
#include <assert.h>

#define MIDI_IMPLEMENTATION
#include "midi.h"

unsigned char palette[] = { 72, 71, 76, 66, 67, 57, 62, 36 };

size_t palette_size = sizeof(palette) / sizeof(*palette);

#define DIV 2048
#define LEN (DIV >> 2)
#define VEL 96
#define BITS palette_size
#define COUNT (1u << palette_size)
#define RBC(x) ((x) ^ ((x >> 1)))
#ifndef TRKS
#define TRKS 4
#endif

int main(int argc, char *argv[])
{
    (void) argc;
    (void) argv;

    unsigned short fmt = MIDI_FORMAT_SIMULTANEOUS;
    unsigned short div = midi_division_ticks_per_quarter_note(2048);
    midi_t midi = midi_create(fmt, div);

    midi_track_t *trks[TRKS];
    for (int i = 0; i < 4; i++) {
        assert((trks[i] = midi_track_create()));
    }

    midi_message_t msg;
    unsigned int prev[TRKS] = { 0 };

    for (unsigned int tn = 0; tn < TRKS; tn++) {
        for (unsigned int i = 0; i < COUNT; i++) {
            unsigned int curr = i;

            for (unsigned int j = 0; j < tn + 1; j++) {
                curr = RBC(curr);
            }

            for (unsigned int j = 0; j < BITS; j++) {
                unsigned int c = (curr >> j) & 1;
                unsigned int p = (prev[tn] >> j) & 1;

                if (c != p) {
                    int key = palette[j];

                    if (c) {
                        msg = midi_message_note_on(tn, key, VEL);
                    } else {
                        msg = midi_message_note_off(tn, key, VEL);
                    }

                    assert(midi_track_add_midi_message(trks[tn], LEN, msg) ==
                           0);
                }
            }

            prev[tn] = curr;
        }
    }

    for (int i = 0; i < TRKS; i++) {
        assert(midi_track_add_end_of_track_event(trks[i], LEN) == 0);
        midi_add_track(&midi, trks[i]);
    }

    assert(midi_write(&midi, stdout) == 0);

}
