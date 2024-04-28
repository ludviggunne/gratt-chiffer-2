<CsoundSynthesizer>

<CsOptions>
-o track.wav -F track.mid --midi-key-cps=4 --midi-velocity-amp=5 -T
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 64
nchnls = 1
0dbfs = 1

instr 1
	kEnv = madsr:k(0.6, 0.2, 0.4, 0.8)
	aVco = vco2:a(0.2, p4)
	aLp = moogladder:a(aVco, 1000 * kEnv, 0.2)
	outall aLp * kEnv
endin

instr 2
	kEnv = madsr:k(0.1, 0.4, 0.6, 0.2)
	aVco = vco2:a(0.2, p4)
	aLp = moogladder:a(aVco, 700 * kEnv, 0.2)
	aNull = 0
	outs aLp * kEnv, aNull
endin

instr 3
	kEnv = madsr:k(0.4, 0.4, 0.6, 0.2)
	aVco = vco2:a(0.2, p4)
	aLp = moogladder:a(aVco, 500 * kEnv, 0.3)
	aNull = 0
	outs aNull, aLp * kEnv
endin

instr 4
	kEnv = madsr:k(0.6, 0.2, 0.4, 0.8)
	aVco = vco2:a(0.2, p4)
	aLp = moogladder:a(aVco, 100 * kEnv, 0.1)
	outall aLp * kEnv
endin


</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>
