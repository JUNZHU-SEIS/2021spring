#!/usr/bin/env -S bash -e
# GMT modern mode bash template
# Date:    2021-03-29T12:49:31
# User:    as
# Purpose: Purpose of this script
export GMT_SESSION_NAME=$$	# Set a unique session name

m=`awk 'BEGIN{min=100}{if($3 < min)min=$3} END{print min}' ../data/CRUST_TK1.0/crsthk.xyz`
awk '($3<=8){print $1,$2,$3-x}' x=$m ../data/CRUST_TK1.0/crsthk.xyz > tmp
awk '($3>8){print $1,$2,5/23*$3-4/23*x}' x=$m ../data/CRUST_TK1.0/crsthk.xyz >> tmp 
awk '{print $1,$2,$3}' x=$m ../data/crust1.0/xyz-bd3 > etopo

gmt begin ../image/iso_topo png
	gmt xyz2grd tmp -Rd -I1/1 -Gtmp.grd -r -V
	gmt xyz2grd etopo -Rd -I1/1 -Getopo.grd -r -V
	gmt subplot begin 2x1 -Fs10c/5c
		gmt subplot set 0 	
		gmt basemap -Rg -JN180/?
		gmt grdimage tmp.grd
		gmt colorbar

		gmt subplot set 1 	
		gmt basemap -Rg -JN180/?
		gmt grdimage etopo.grd
		gmt colorbar
	gmt subplot end
gmt end show

gmt grdcut tmp.grd -R100/145/20/65 -Gtmp.nc
gmt grdcut etopo.grd -R100/145/20/65 -Getopo.nc

gmt begin ../image/iso_topo_region png
	gmt subplot begin 2x1 -Fs15c/8c
		gmt subplot set 0 	
		gmt basemap -JM12c
		gmt grdimage tmp.nc
		gmt colorbar

		gmt subplot set 1 	
		gmt basemap -JM12c
		gmt grdimage etopo.nc
		gmt colorbar
	gmt subplot end
gmt end show

rm -rf etopo* tmp* gmt*
