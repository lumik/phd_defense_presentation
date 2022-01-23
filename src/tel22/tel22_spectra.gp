set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
# set terminal epslatex color solid size 13.5cm,8cm header "\\sffamily\\sansmath"
set terminal cairolatex pdf color solid size 13.5cm,8cm header "\\sffamily\\sansmath"
set output "tel22_spectra.tex"

fna = 'tel22a_low.dat'
fnb = 'tel22b_low.dat'
fnc = 'tel22c_low.dat'
fnbands = 'plottel22_lowbands.dat'
lw = 4

du = 0.9  # band assignment line segment length
zu1 = .3  # first break of the segment - y distance from the beginning
zu2 = .6  # second break of the segment - y distance from the beginning
cyu = .3  # identation of the beginning of the segment from spectrum
cxt = 0.0  # text shift in x axis
cyt3 = cyu + du + 1.0  # y shift of text from the band from 3-digit numbers
cyt4 = cyu + du + 1.4  # y shift of text from the band from 3-digit numbers

cysol = 2  # identation of star from spectrum
cxsol = 0  # x-shift of text

tm = 0.005
bm = 0.07

set border lw 4

set style arrow 1 nohead ls 1 lw lw lc rgb 'black'

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

set macros
ranges = "[1150:1800][-0.5:13]"

set xtics autofreq nomirror
set xlabel 'wavenumber (cm$^{-1}$)'
set ylabel "Raman intensity (au)" offset 0,0

plot @ranges fna u 1:2 w l title 'anealed' lt 1 lw lw lc rgb 0x55ff0000,\
	fnb u 1:2 w l title '37\,\textdegree{}C incubated' lt 1 lw lw lc rgb 0x5500ff00,\
	fnc u 1:2 w l title 'thermally pristine' lt 1 lw lw lc rgb 0x550000ff,\
	fnbands u 1:($2 + $5 + cyu):(0):(zu1) w vectors arrowstyle 1 notitle,\
	fnbands u 1:($2 + $5 + cyu + zu1):($3):($4 + zu2 - zu1) w vectors arrowstyle 1 notitle,\
	fnbands u ($1 + $3):($2 + $4 + $5 + cyu + zu2):(0):(du - zu2) w vectors arrowstyle 1 notitle,\
	fnbands u ($1 + $3 + cxt):((($1 + 0.5) / 1000 < 1) ? ($2 + $4 + $5 + cyt3) : ($2 + $4 + $5 + cyt4)):(sprintf("\\\\scriptsize %d",$1+0.5)) with labels rotate right notitle

set output
