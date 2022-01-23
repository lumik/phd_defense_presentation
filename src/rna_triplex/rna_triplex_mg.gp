set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal cairolatex pdf color solid size 13.5cm,6.5cm header "\\sffamily\\sansmath"
# set terminal epslatex color solid size 13.5cm,6.5cm header "\\sffamily\\sansmath"
set output "rna_triplex_mg.tex"

set datafile separator ","
fn  = 'All05.txt'
lw = 4

set macros
ranges = "[500:1800][-0.05:0.5]"

set border linewidth 4

set xlabel '$\tilde{\nu}$ (\icm)'
set ylabel 'intensity (a. u.)' offset 0,0
set tics scale 0.7
set xtics 200 offset 0,0.0
set format x "%h"
unset ytics

set tmargin at screen 0.95
set bmargin at screen 0.15
set rmargin at screen 0.95
set lmargin at screen 0.05

# cairo terminal somehow makes line spacing larger than eps output.
set key font ',0.8' spacing 2.5 samplen 40

n=5

# show palette rgbformulae
# set palette rgbformulae 33,13,10    #rainbow palette
# set cbrange [0:n]
# unset colorbox  #The colorbox will not plotted

# plot @ranges for [i = 1:n]\
# 	'All05.txt' u 1:(column(10 - i)) w l title sprintf("%d mM Mg", (6 - i) * 3) lw lw lc palette cb i

set angle degrees
fr(x) = abs(2 * x - 0.5)
r(x) = fr(x) < 0 ? 0: (fr(x) > 1) ? 1 : fr(x)
g(x) = sin(180 * x)
b(x) = cos(90 * x)
myColor(x) = (int(r(x) * 0xff) << 16) + (int(g(x) * 0xff) << 8) + int(b(x) * 0xff) + (int(0x55) << 24)

plot @ranges for [i = 1:n]\
	'All05.txt' u 1:(column(10 - i)) w l title sprintf("%d\\,mM Mg\\textsuperscript{2+}", (6 - i) * 3) lw lw lc rgb myColor(real(6 - i) / n)

set datafile separator whitespace

set output
