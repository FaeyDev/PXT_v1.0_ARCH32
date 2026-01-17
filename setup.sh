#!/sbin/sh
###############################
# XTemplate private
###############################

# Config Vars
# Choose if you want to skip mount for your module or not.
SKIPMOUNT=false
# Set true if you want to load system.prop
PROPFILE=true
# Set true if you want to load post-fs-data.sh
POSTFSDATA=false
# Set true if you want to load service.sh
LATESTARTSERVICE=true
# Set true if you want to clean old files in module before injecting new module
CLEANSERVICE=true
# Select true if you want to want to debug
DEBUG=true
# Select this if you want to add cloud support to your scripts
#CLOUDSUPPPORT=true
# Add cloud host path to this variable
#CLOUDHOST=

# Custom var
MODDIR=/data/adb/modules

# unzip
unzip -o "$ZIPFILE" 'addon/*' -d $TMPDIR >&2
unzip -o "$ZIPFILE" 'tmp/*' -d $MODPATH >&2

ui_print "╔═══╦═╗╔═╦════╗"
ui_print "║╔═╗╠╗╚╝╔╣╔╗╔╗║"
ui_print "║╚═╝║╚╗╔╝╚╝║║╚╝"
ui_print "║╔══╝╔╝╚╗──║║"
ui_print "║║──╔╝╔╗╚╗─║║"
ui_print "╚╝──╚═╝╚═╝─╚╝"
ui_print ""
sleep 1
ui_print ""
ui_print " ▌VERSION 1.0"
sleep 1
ui_print ""
ui_print " Device Info : "
sleep 4
ui_print ""
ui_print "DEVICE : $(getprop ro.product.model) "
sleep 1
ui_print ""
ui_print "BRAND : $(getprop ro.product.system.brand) "
sleep 1
ui_print ""
ui_print "MODEL : $(getprop ro.build.product) "
sleep 1
ui_print ""
ui_print "KERNEL : $(uname -r) "
sleep 1
ui_print ""
ui_print "PROCESSOR : $(getprop ro.product.board) "
sleep 1
ui_print ""
ui_print " Don't Use With Any Other Performance Related Module"
sleep 2
# Load Vol Key Selector
. $TMPDIR/addon/Volume-Key-Selector/install.sh

ui_print ""
ui_print "DO YOU WANT TO OPTIMIZE YOUR DEVICE?"
sleep 0.5
ui_print ""
sleep 0.5
ui_print ""
ui_print "▌VOLUME UP = SWITCH , VOLUME DOWN = SELECT"
sleep 1
ui_print ""
ui_print " [1] ▌ YES , OPTIMIZE (HIGHLY RECOMMEND)"
sleep 1
ui_print ""
ui_print " [2] ▌ NO , THANKS"
sleep 1
ui_print ""
ui_print "▌ WAITING FOR RESPONSE : "
DTT=1
while true
do
ui_print "$DTT"
if $VKSEL
then
DTT=$((DTT + 1))
else
break
fi
if [ $DTT -gt 2 ]
then
DTT=1
fi
done

case $DTT in
1) DTT="YES";;
2) DTT="NO"
esac

ui_print ""
ui_print "[*] Selected: $DTT"
ui_print ""

if [[ "$DTT" == "YES" ]]; then
ui_print "▌OPTIMIZING YOUR DEVICE IT MAY TAKE  5-10 MINUTES"
cmd package bg-dexopt-job
fstrim -v /system
sleep 1
fstrim -v /data
sleep 1
fstrim -v /cache
ui_print "▌OPTIMIZATION COMPLETED"
sleep 0.5
ui_print ""
ui_print "▌TERMUX COMMAND su -c pxt"
ui_print "";
elif [[ "$DTT" == "NO" ]]; then
ui_print "▌ OPTIMIZATION SKIPPED"
ui_print ""
true
fi
set_permissions() {
set_perm_recursive "$MODPATH" 0 0 0755 0644
set_perm_recursive "$MODPATH/system" 0 0 0755 0644
set_perm_recursive "$MODPATH/system/xbin" 0 0 0755 0644
set_perm_recursive "$MODPATH/system/bin" 0 0 0755 0755
}
