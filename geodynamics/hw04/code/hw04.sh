export GMT_SESSION_NAME=$$	# Set a unique session name

gmt begin ../image/Indian_bathy png
	gmt makecpt -Cetopo1 
#	gmt grdimage ../data/relief/ETOPO1_Ice_g_gmt4.grd -JM60/10c -R40/80/-30/30 -I+d -Bafg -BWSen
	gmt grdimage ../data/relief/ETOPO1_Ice_g_gmt4.grd -JH0/10c -Rg -I+d -Bafg -BWSen
	gmt colorbar -Bxa3000f -Bx+l"Bathymetry (m)"
	gmt plot ../data/pb2002.txt -W1p,red
gmt end show

gmt begin ../image/Indian_age png
	gmt makecpt -Chot -T0/170/10 
#	gmt grdimage ../data/age/age.2020.1.GTS2012.1m.nc -JM60/10c -R40/80/-30/30 -I+d -Bafg -BWSen
	gmt grdimage ../data/age/age.2020.1.GTS2012.1m.nc -JH0/10c -Rg -I+d -Bafg -BWSen
	gmt colorbar -Bxa20f -Bx+l"Age (Myrs)"
	gmt plot ../data/pb2002.txt -W1p,red
gmt end show

gmt begin ../image/Indian_hf png
	gmt coast -JH0/12c -Rg -W0.5p -A10000 -Ba30f
	gmt makecpt -Crainbow -T0/200/10
	gmt plot ../data/heat_flux/hf -Sc0.03c -C
	gmt colorbar -DJMR+w10c+o1.5c/0c+ml -Bxa50f -By+l"mWm^-2"
	gmt plot ../data/pb2002.txt -W0.5p,red
gmt end show
rm -rf hf.nc
