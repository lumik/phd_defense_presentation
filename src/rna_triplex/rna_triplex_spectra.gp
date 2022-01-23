set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 25cm,17cm header "\\sffamily\\sansmath"
set output "rna_triplex_spectra.tex"

fn     = 'PolyA.dat           PolyU.dat           duplex.dat         triplex.dat'
bands  = 'plotAbands.dat      plotUbands.dat      plotdbands.dat     plottbands.dat'
kak    = 'plotAbands_kak.dat  plotUbands_kak.dat  plotdbands_kak.dat plottbands_kak.dat'
dy     = '39                  27                  12                 0'

labels = 'polyA               polyU               duplex             triplex'
lposx  = '400                 400                 400                400'
lposy  = '450                 330                 180                 65'
llabels = 'a)                 b)                  c)                 d)'
llposx = 400
lldy   = 2.5

mlabels = '   2     2     3'
mlposx  = '1788  1788  1788'
mlposy  = ' 290   135    15'

# delka usecky prirazeni pasu
du=1.2

# prvni zlom usecky v y-vzdalenosti od pocatku usecky
zu1=.4

# druhy zlom usecky v y-vzdalenosti od pocatku usecky
zu2=.8

# odsazeni pocatku usecky od krivky
cyu=.4

# posunuti textu vuci pasu v x-ove ose
cxt=-3.0

# odsazeni popisku od pasu pro 3-ciferna cisla
cyt3=cyu+du+3.2

# odsazeni popisku od pasu pro 4-ciferna cisla
cyt4=cyu+du+4.0

# odsazeni hvezdicek od krivky
cysol = .4

# posunuti textu v x-ove ose
cxsol = .0

# odsazeni hvezdicek od diff krivky nahoru
pcydsol = .4

# odsazeni hvezdicek od diff krivky dolu
mcydsol = -1.0


tm = 0.005
bm = 0.11
N = words(fn)

set_label(ii, x, y) = sprintf("set label '\\LARGE %s' at first %f, %f right",  word(labels, ii), x, y)
set_llabel(ii, y) = sprintf("set label '\\LARGE %s' at first %f, %f right",  word(llabels, ii), llposx, y+lldy)
set_mlabel(ii, x, y) = sprintf("set label '\\LARGE %s$\\times$' at first %f, %f", word(mlabels, ii), x, y)

set border lw 4

set style arrow 1 nohead ls 1 lw 4 lc rgb 'black'

# vykresleni grafu
unset key

set lmargin 3
set rmargin 0.3
set tmargin at screen 1-0.005
set bmargin at screen 0.07

unset ytics

bborder = 1
lborder = 2
tborder = 4
rborder = 8

set macros
ranges = "[1800:350][-0.5:54.5]"

set border bborder + lborder + tborder + rborder

set xtics autofreq nomirror
set xlabel "\\LARGE wavenumber (cm\\textsuperscript{-1})" offset 0,.2
set ylabel "\\LARGE Raman intensity (au)" offset 0,0
set format x "\\LARGE %h"

do for [ii = 1:words(labels)] {
	evaluate set_label(ii, int(word(lposx, ii)), int(word(lposy, ii)) / 10.)
	evaluate set_llabel(ii, int(word(lposy, ii)) / 10.)
}
do for [ii = 1:words(mlabels)] {
	evaluate set_mlabel(ii, int(word(mlposx, ii)), int(word(mlposy, ii)) / 10.)
}

plot @ranges for [ii = 1:N] word(fn, ii) u 1:($2+int(word(dy, ii))) w l lt 1 lw 4 lc 0,\
	 for [ii = 1:N] word(bands, ii) u 1:($2+$5+cyu+int(word(dy, ii))):(0):(zu1) w vectors arrowstyle 1 notitle,\
	 for [ii = 1:N] word(bands, ii) u 1:($2+$5+cyu+zu1+int(word(dy, ii))):($3):($4+zu2-zu1) w vectors arrowstyle 1 notitle,\
	 for [ii = 1:N] word(bands, ii) u ($1+$3):($2+$4+$5+cyu+zu2+int(word(dy, ii))):(0):(du-zu2) w vectors arrowstyle 1 notitle,\
	 for [ii = 1:N] word(bands, ii) u ($1+$3+cxt):((($1+0.5) / 1000 < 1) ? ($2+$4+$5+cyt3+int(word(dy, ii))) : ($2+$4+$5+cyt4+int(word(dy, ii)))):(sprintf("\\\\LARGE %d",$1+0.5)) with labels rotate right notitle,\
	 for [ii = 1:N] word(kak, ii) u ($1+$3+cxsol):($2+$4+cysol+int(word(dy, ii))):("\\\\LARGE *") with labels notitle

set output
