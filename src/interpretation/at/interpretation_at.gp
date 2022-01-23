set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 25cm,17cm header "\\sffamily\\sansmath"
set output "interpretation_at.tex"

fn     = 'AMP_low.dat                TMP_low.dat                pdAdT05_low.dat                pdAdT95_low.dat'
bands  = 'plotAMP_lowbands.dat       plotTMP_lowbands.dat       plotpdAdT05_lowbands.dat       plotpdAdT95_lowbands.dat'
kak    = 'plotAMP_lowbands_artf.dat  plotTMP_lowbands_artf.dat  plotpdAdT05_lowbands_artf.dat  plotpdAdT95_lowbands_artf.dat'
dy     = '29                         21                         10                             0'
scale  = '1                          1                          3                              1'
scalex = '1790                       1790                       1790                           1790'
scaley = '305                        225                        115                            15'

labels = 'AMP                        TMP                        "poly(dAdT) -- 5\,$^\circ$C"   "poly(dAdT) -- 95\,$^\circ$C"'
lposx  = '520                        520                        520                            520'
lposy  = '370                        260                        170                            70'
llabels = 'a)                        b)                         c)                             d)'
llposx = 520
lldy   = 2

du = 0.9  # band assignment line segment length
zu1 = .3  # first break of the segment - y distance from the beginning
zu2 = .6  # second break of the segment - y distance from the beginning
cyu = .3  # identation of the beginning of the segment from spectrum
cxt = 3.0  # text shift in x axis
cyt3 = cyu + du + 2.8  # y shift of text from the band from 3-digit numbers
cyt4 = cyu + du + 3.3  # y shift of text from the band from 3-digit numbers

cysol = 2  # identation of star from spectrum
cxsol = 0  # x-shift of text

tm = 0.005
bm = 0.07
N = words(fn)

set_label(ii, x, y) = sprintf("set label '\\LARGE %s' at first %f, %f left",  word(labels, ii), x, y)
set_llabel(ii, y) = sprintf("set label '\\LARGE %s' at first %f, %f left",  word(llabels, ii), llposx, y + lldy)
set_scale_label(ii, x, y) = sprintf("set label '\\LARGE %s$\\times$' at first %f, %f right", word(scale, ii), x, y)

set border lw 4

set style arrow 1 nohead ls 1 lw 4 lc rgb 'black'

unset key

set lmargin at screen 0.05
set rmargin 0.1
set tmargin at screen 1 - tm
set bmargin at screen bm

unset ytics

bborder = 1
lborder = 2
tborder = 4
rborder = 8

set macros
ranges = "[500:1800][-0.5:44.5]"

set border bborder + lborder + tborder + rborder

set xtics autofreq nomirror
set xlabel "\\LARGE wavenumber (cm\\textsuperscript{-1})" offset 0,.2
set ylabel "\\LARGE Raman intensity (au)" offset 0,0
set format x "\\LARGE %h"

do for [ii = 1:words(labels)] {
	evaluate set_label(ii, int(word(lposx, ii)), int(word(lposy, ii)) / 10.)
	evaluate set_llabel(ii, int(word(lposy, ii)) / 10.)
}
do for [ii = 1:words(scale)] {
	evaluate set_scale_label(ii, int(word(scalex, ii)), int(word(scaley, ii)) / 10.)
}

plot @ranges for [ii = 1:N] word(fn, ii) u 1:($2 * int(word(scale, ii)) + int(word(dy, ii))) w l lt 1 lw 4 lc 0,\
	for [ii = 1:N] word(bands, ii) u 1:($2 * int(word(scale, ii)) + $5 + cyu + int(word(dy, ii))):(0):(zu1) w vectors arrowstyle 1 notitle,\
	for [ii = 1:N] word(bands, ii) u 1:($2 * int(word(scale, ii)) + $5 + cyu + zu1 + int(word(dy, ii))):($3):($4 + zu2 - zu1) w vectors arrowstyle 1 notitle,\
	for [ii = 1:N] word(bands, ii) u ($1 + $3):($2 * int(word(scale, ii)) + $4 + $5 + cyu + zu2 + int(word(dy, ii))):(0):(du - zu2) w vectors arrowstyle 1 notitle,\
	for [ii = 1:N] word(bands, ii) u ($1 + $3 + cxt):((($1 + 0.5) / 1000 < 1) ? ($2 * int(word(scale, ii)) + $4 + $5 + cyt3 + int(word(dy, ii))) : ($2 * int(word(scale, ii)) + $4 + $5 + cyt4 + int(word(dy, ii)))):(sprintf("\\\\LARGE %d",$1+0.5)) with labels rotate right notitle,\
	for [ii = 1:N] word(kak, ii) u ($1 + $3 + cxsol):($2 * int(word(scale, ii)) + $4 + cysol + int(word(dy, ii))):("\\\\LARGE *") with labels notitle

set output