set encoding utf8
reset
#set terminal qt enhanced size 1300,1000
#set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
#set output "power_optimization_triplexes_pU.tex"
set terminal cairolatex pdf color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "power_optimization_triplexes_pU.tex"

fn = 'pUI500_1mW_01.dat'
fn_pUfit = 'pUI500_1mW_01_pUfit.dat'
fn_pUfit1 = 'pUI500_1mW_01_pUfit1.dat'
fn_pU_cacfit = 'pUI500_1mW_01_pU_cacfit.dat'
fn_cacfit = 'pUI500_1mW_01_cacfit.dat'
fn_cacfit1 = 'pUI500_1mW_01_cacfit1.dat'
fn_cacfit2 = 'pUI500_1mW_01_cacfit2.dat'
fn_pUbands = 'pUI500_1mW_01_pUbands.dat'
fn_cacbands = 'pUI500_1mW_01_cacbands.dat'
lw = 4
lwfit = 8

du = .03  # band assignment line segment length
zu1 = .01  # first break of the segment - y distance from the beginning
zu2 = .02  # second break of the segment - y distance from the beginning
cyu = .01  # identation of the beginning of the segment from spectrum
cxt = .0  # text shift in x axis
cyt3 = cyu + du + .047  # y shift of text from the band from 3-digit numbers
cyt4 = cyu + du + .06  # y shift of text from the band from 3-digit numbers

decay(x, p1, p2, p3) = p1 * exp(-p2 * x) + p3;

# settings
set macros
ranges = "[400:1800][0.5:1.2]"

set border linewidth 4

set xlabel '$\tilde{\nu}$ (\icm)' offset 0,0
set ylabel 'intensity (a. u.)' offset 0,0
set tics scale 0.7
set xtics 200 offset 0,0.0
unset ytics
set format x "%h"

set tmargin at screen 0.95
set bmargin at screen 0.15
set rmargin at screen 0.95
set lmargin at screen 0.05

# cairo terminal somehow makes line spacing larger than eps output.
set key font ',0.8' spacing 2.5 samplen 40

set style arrow 1 nohead ls 1 lw 4 lc rgb 'black'
set style fill transparent solid 0.2 noborder
set style line 1 lc rgb '#0060ad' lt 1 lw lw  # spectrum

plot @ranges\
	fn w l notitle ls 1,\
	fn_pUfit w l notitle lw lwfit lc rgb '#558b4513',\
	fn_pU_cacfit w l notitle lw lwfit lc rgb '#88ff0000',\
	fn_pUfit1 u 1:2:3 w filledcurves notitle lw lwfit lc rgb '#228b22',\
	fn_pUfit1 u 1:2 w l title 'polyU band~~' lw lwfit lc rgb '#88228b22',\
	fn_cacfit u 1:2 w l title 'cacodylate band~~' lw lwfit lc rgb '#88ff0000',\
	fn_cacfit1 u 1:2:3 w filledcurves notitle lw lwfit lc rgb 'red',\
	fn_cacfit1 u 1:2 w l notitle lw lwfit lc rgb '#88ff0000',\
	fn_cacfit2 u 1:2 w l notitle lw lwfit lc rgb '#88ff0000',\
	fn_pUbands u 1:($2 + $5 + cyu):(0):(zu1) w vectors arrowstyle 1 notitle,\
	fn_pUbands u 1:($2 + $5 + cyu + zu1):($3):($4 + zu2 - zu1) w vectors arrowstyle 1 notitle,\
	fn_pUbands u ($1 + $3):($2 + $4 + $5 + cyu + zu2):(0):(du - zu2) w vectors arrowstyle 1 notitle,\
	fn_pUbands u ($1 + $3 + cxt):((($1 + 0.5) / 1000 < 1) ? ($2 + $4 + $5 + cyt3):\
		($2 + $4 + $5 + cyt4)):(sprintf("\\\\scriptsize %d",$1 + 0.5)) with labels rotate right notitle,\
	fn_cacbands u 1:($2 + $5 + cyu):(0):(zu1) w vectors arrowstyle 1 notitle,\
	fn_cacbands u 1:($2 + $5 + cyu + zu1):($3):($4 + zu2 - zu1) w vectors arrowstyle 1 notitle,\
	fn_cacbands u ($1 + $3):($2 + $4 + $5 + cyu + zu2):(0):(du - zu2) w vectors arrowstyle 1 notitle,\
	fn_cacbands u ($1 + $3 + cxt):((($1 + 0.5) / 1000 < 1) ? ($2 + $4 + $5 + cyt3):\
		($2 + $4 + $5 + cyt4)):(sprintf("\\\\scriptsize %d",$1 + 0.5)) with labels rotate right notitle,\


set output
