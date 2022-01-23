set encoding utf8
reset
# set terminal qt enhanced size 1300,1000
set terminal epslatex color solid size 13.5cm,9cm header "\\sffamily\\sansmath"
set output "power_optimization_triplexes.tex"

fn_01mW  = 'pUIt_01mW.dat'
fn_02mW  = 'pUIt_02mW.dat'
fn_10mW  = 'pUIt_10mW.dat'
lw = 4
ps = 2

decay(x, p1, p2, p3) = p1 * exp(-p2 * x) + p3;

set macros
ranges = "[0:26][-0.05:0.4]"

set border linewidth 4

set xlabel 'time (min)'
set ylabel 'intensity (a. u.)'
set xtics 5
unset ytics
set format x "%h"

set lmargin at screen 0.05

plot @ranges\
	fn_01mW w p title "1\\,mW" pt 2 ps ps lw lw lc 'red',\
	decay(x, 3.720600e-01, 5.965743e-02, 0) w l lw lw lc 'black' notitle, \
	fn_02mW w p title "2\\,mW" pt 4 ps ps lw lw lc 'green',\
	decay(x, 3.831249e-01, 1.313771e-01, 0) w l lw lw lc 'black' notitle, \
	fn_10mW w p title "10\\,mW" pt 6 ps ps lw lw lc 'blue',\
	decay(x, 4.629436e-01, 4.410476e-01, 0) w l lw lw lc 'black' notitle

set output
