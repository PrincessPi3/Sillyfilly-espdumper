#!/bin/bash
datestamp=$(date "+%d%m%y%H%M%S")
chip="esp32c5"
file_prefix=esp32c5-devkitc-1-stub
out_dir="./live-roms/$file_prefix-$datestamp"
stub=False # True/False case sensitive
args_file="./config/ESP32-C5-Full-Named-Dump.conf"
log_file="$out_dir/log-$file_prefix-$datestamp.txt"
tmp_file="./.dump_rom_tmp.tmp"
start_header="Starting dump from chip: $chip\n\ton port: $ESPPORT\n\tat: $ESPBAUD baud\n\tto directory: $out_dir\ntwith log file: $log_file\n"

if [ ! -d ./live-roms ]; then
    mkdir ./live-roms
fi

mkdir $out_dir

if [ "$stub" != "False" ]; then
	stubby='--no-stub'
fi

echo -e "\n====================="
echo -e $start_header

echo -e $start_header >> $log_file

echo -e "Running chipinfo, appending to $log_file"
echo -e "Chipinfo:"
chipinfo >> $log_file


# usage
#     dump_section name start_address length
#         name is a string
#         start_address in hex with no _s
#         length in hex with no _s
dump_section () {
	file_name="$out_dir/$file_prefix-$chip-$1-$2-$3-$datestamp.bin"
	command="esptool.py $stubby --baud $ESPBAUD --port $ESPPORT --chip $chip dump_mem $2 $3 $file_name"

	header="$1 starting: $2 length: $3 on $chip stub: $stub\n\nRunning: $command"

	echo -e "\nDumping Section:\n$header\n\nPlease wait..."

	echo -e $header >> $log_file
	echo -e "	File: $file_name" >> $log_file
	echo -e "	$command" >> $log_file

	eval "$command"
	return_status=$?

	if [ $return_status -ne 0 ]; then
		echo -e "\tERROR: return status $return_status dump:" >> $log_file
		cat $tmp_file >> $log_file
		echo -e "ERROR: dump failed. check $log_file"
		echo -e "esptool output:"
		cat $tmp_file
		rm $tmp_file
		exit
	fi

	checksum=$(sha256sum $file_name)
	echo -e "	sha256sum: $checksum" >> $log_file
	echo -e "	Sucess\n===\n" >> $log_file
	echo -e "Successfully dumped\nsha256sum: $checksum\n continuing..."
}

cat $args_file | \
	while read args; do
		dump_section `echo $args`
	done

sha256sum $out_dir/* >> $out_dir/sha256sum.txt

echo -e "\nDone :3"
