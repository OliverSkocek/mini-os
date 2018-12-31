NAME=$1
FILENAME="${NAME%.*}"
EXTENSION="${NAME##*.}"
if [ $EXTENSION = "s" ]; then
	echo "Assembling boot seqeunce..."
	as "$1" -o "$FILENAME.o"
	ld --oformat binary -Ttext 0x7C00 -o "$FILENAME.bin" "$FILENAME.o"
	echo "Writing to Floppy disk..."
	dd if="$FILENAME.bin" of=/dev/fd0i bs=512 count=1
	md5 "$FILENAME.bin"
	dd if=/dev/fd0i of="FLOPPY.img" bs=512 count=1
	md5 "FLOPPY.img"
	echo "Done!"
else
	echo "Wrong Format!"
fi
