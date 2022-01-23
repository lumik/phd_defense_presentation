reset

fn =     'concds.dat     concts.dat'
legtxt = 'duplex         triplex'
fitspc = 'concdsfit.dat  conctsfit.dat'

set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "rna_triplex_conc.tex"

N = words(fn)

set border lw 4

set macros
ranges = "[-1:16][-0.05*1e2:1.1*1e2]"

set xlabel "Mg\\textsuperscript{2+} concentration (mM)"
set ylabel "Duplex/triplex concentration\nin basepairs/triads (\\%)" offset 0,0
set format x "%h"
set format y "%h"
set xtics autofreq nomirror

plot @ranges word(fn, 1) u 1:2:3 w errorbars pt 1 ps 2 lw 4 lc 0 title word(legtxt, 1),\
	word(fn, 2) u 1:2:3 w errorbars pt 2 lw 4 ps 2 lc 0 title word(legtxt, 2),\
	word(fitspc, 1) u 1:2 w l lt 1 lw 4 lc 0 notitle,\
	word(fitspc, 2) u 1:2 w l lt 1 lw 4 lc 0 notitle


set output