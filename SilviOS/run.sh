NAME=$1
FILENAME="${NAME%.*}"
EXTENSION="${NAME##*.}"
if [ $EXTENSION = "asm" ]; then
	echo "Assembling boot sequence..."
#   as "$1" -o "$FILENAME.o"
#   ld --oformat binary -Ttext 0x7C00 -o "$FILENAME.bin" "$FILENAME.o"
	nasm "$1" -f bin -o "$FILENAME.bin"
	echo "Writing to Floppy disk..."
#	dd if="$FILENAME.bin" of=/dev/fd0i bs=512 count=1
    dd if="$FILENAME.bin" of=/dev/sdc bs=512 count=1
	md5sum "$FILENAME.bin"
#	dd if=/dev/fd0i of="FLOPPY.img" bs=512 count=1
    dd if=/dev/sdc of="FLOPPY.img" bs=512 count=1
	md5sum "FLOPPY.img"
	echo "Done!"
else
	echo "Wrong Format!"
fi
