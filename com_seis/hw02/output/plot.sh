#!/usr/bin/env -S bash -e
# GMT modern mode bash template
# Date:    2021-03-29T12:49:31
# User:    as
# Purpose: Purpose of this script
export GMT_SESSION_NAME=$$	# Set a unique session name
awk  '(NR>1){print $2, $3}' tttable.txt > tt
awk  '(NR>1){print $2, $4}' tttable.txt > tau
gmt begin ../image/tt png
gmt basemap -JX10c -R19/64/244/641 -Bxa10f5g10+l"delta (deg)" -Bya100f50g50+l"tt (sec)" -BWSen
gmt plot tt 
gmt end show
gmt begin ../image/taup png
gmt basemap -JX10c -R19/64/45/188 -Bxa10f5g10+l"delta (deg)" -Bya100f50g50+l"taup (sec)" -BWSen
gmt plot tau 
gmt end show

rm -rf tt tau
