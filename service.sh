MODDIR ${0%/*}
rm -rf $MODPATH/LICENSE
while [ `getprop vendor.post_boot.parsed` != "1" ]; do
sleep 1s
done
while [ `getprop vendor.post_boot.parsed` != "1" ]; do
sleep 1s
done