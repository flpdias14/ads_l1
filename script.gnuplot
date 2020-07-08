reset
set terminal postscript eps solid color enhanced "Helvetica" 20
set output "firefox_cache_buffer.eps"
set xlabel "# Amostra"
set ylabel "Memoria Cached/Buffer (MB)"
set style line 10 linetype 1
set yrange [1800:*]
set xrange [0:*]
set datafile separator ';'
plot "log_dados.csv" using 1:($11/1024) with lines title "" lw 5 lc rgb "black"
