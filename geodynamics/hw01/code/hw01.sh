#!/usr/bin/env -S bash -e
# GMT modern mode bash template
# Date:    2021-03-20T16:01:18
# User:    as
# Purpose: Purpose of this script
export GMT_SESSION_NAME=$$	# Set a unique session name

gmt begin ../image/global_ETOP png
	gmt makecpt -Cetopo1 
	gmt grdimage ../data/relief/ETOPO1_Ice_g_gmt4.grd -JH180/10c -Rg -I+d
	gmt colorbar -Bxa3000f -Bx+l"Elevation (m)"
gmt end show

gmt begin ../image/regional_ETOP png
	gmt makecpt -Cetopo1
	gmt grdimage ../data/relief/region.nc -JM15c -Baf -BWSen -I+d
	gmt colorbar -Bxa3000f+l"Elevation (m)"
gmt end show

gmt begin ../image/global_quake_distribution png
	gmt coast -JH180/15c -Rg -B0 -W0.5p -A15000
	gmt grdimage @earth_relief_10m -Cetopo1 -I+d
	gmt colorbar -Bxa2000f+l"Elevation (m)"
	gmt makecpt -CgrayC -T0/678
	gmt plot -W0.2p,black,solid -Sa0.2c -C ../data/catalog/quake.dat
gmt end show

gmt begin ../image/regional_quake_distribution png
	gmt coast -JM15c -R128/146/30/47 -Baf -W0.5p -A10000
	gmt grdimage @earth_relief_30s -Cetopo1 -I+d
	gmt colorbar -Bxa2000f+l"Elevation (m)"
	gmt makecpt -CgrayC -T0/678
	gmt plot -W0.2p,black,solid -Sa0.2c -C ../data/catalog/quake.dat
gmt end show

gmt begin ../image/tonga png
	gmt coast -JM15c -R/-182/-172/-30/-14 -Baf -W0.5p -A100
	gmt grdimage @earth_relief_30s -Cetopo1 -I+d
	gmt colorbar -Bxa2000f+l"Elevation (m)"
cat > line.dat <<EOF
180 -16
-173 -19
EOF
	gmt plot line.dat -W3p,red,solid -A
	gmt makecpt -CgrayC -T0/678/150
	gmt plot -W0.2p,black,solid -Sa0.2c -C ../data/catalog/quake.dat
gmt end show

gmt begin ../image/subduction png
	gmt project ../data/catalog/quake.dat -C180/-16 -E-173/-19 -Q -W-1200/400 -Fpz > Tonga_benioff.dat
	gmt basemap -R0/844/0/680 -JX8.4c/-6.8c -Bxa100f100+l"distance (km)" -Bya100f100+l"depth (km)" -BWSen+t"Tonga Benioff Zone"
	gmt makecpt -Cviridis -T3/7/1
	gmt plot -Sc0.05c -C Tonga_benioff.dat 
	gmt colorbar -DJMR+w4c+o0.5c/0c+ml -Bxa2f -By+l"Mw"
gmt end show

rm line.dat Tonga*
