awk '{print $1, $2}' cmt.bk > tmp

gmt begin distri png.pdf
gmt coast -JM180/15c -R120/185/-30/50 -Bafg -W0.5p -A15000
gmt plot -W0.2p,black,solid -Gred -Sa0.2c tmp 
gmt end show

gmt begin meca png,pdf
#gmt meca -JQ104/15c -R168/174/-15.5/-12 -Ba -Sm0.5c cmt
gmt meca -JQ104/15c -R170.5/171.5/-14.5/-13.5 -Ba -Sm1c << EOF
170.87 -13.99 642 -3.43 2.42 1.01 -0.94 0.17 -1.27 24 X Y 121492D
EOF
gmt end show

rm -rf tmp
