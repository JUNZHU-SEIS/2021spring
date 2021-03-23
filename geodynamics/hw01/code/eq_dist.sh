#!/usr/bin/env -S bash -e
# GMT modern mode bash template
# Date:    2021-03-20T16:01:18
# User:    as
# Purpose: Purpose of this script
export GMT_SESSION_NAME=$$	# Set a unique session name
#global
gmt begin ../image/global_earqhquake_distribution png
gmt coast -JH180/15c -Rg -B0 -W0.5p -A15000
gmt grdimage @earth_relief_10m -Cetopo1 -I+d
gmt colorbar -Bxa2000f+l"Elevation (m)"

gmt makecpt -CgrayC -T10/500
gmt plot -W0.2p,black,solid -Sa -C ../data/global_catalog/global_earthquake.dat
gmt end show

#regional 
gmt begin ../image/regional_earthquake_distribution png
gmt coast -JM15c -R128/146/30/47 -Baf -W0.5p -A10000

gmt grdimage @earth_relief_30s -Cetopo1 -I+d
gmt colorbar -Bxa2000f+l"Elevation (m)"

gmt makecpt -CgrayC -T10/100
gmt plot -W0.2p,black,solid -Sa0.5c -C ../data/global_catalog/global_earthquake.dat
gmt end show

#subduction
gmt begin tonga png
gmt coast -JM15c -R/-195/-168/-49/-18 -Baf -W0.5p -A100
gmt grdimage @earth_relief_30s -Cetopo1 -I+d
gmt colorbar -Bxa2000f+l"Elevation (m)"

gmt makecpt -CgrayC -T10/100
gmt plot -W0.2p,black,solid -Sa0.5c -C ../data/global_catalog/global_earthquake.dat

cat > line.dat <<EOF
166 -45
-173 -20
EOF

gmt plot line.dat -W3p,red,solid -A
#test 
#gmt project -C 
gmt end show
