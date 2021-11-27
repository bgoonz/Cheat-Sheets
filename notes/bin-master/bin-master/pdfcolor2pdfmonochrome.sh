#!/bin/bash

function myprog() {
	pdf_path="$1"
	pdf_path=${pdf_path//"'"/}

	echo -e "pdf_path entered is $pdf_path"

	[ -f "$pdf_path" ] && echo "pdf_path found" || echo "pdf_path not found"

	rm -rf "/var/tmp/convert2monochrome"
	mkdir "/var/tmp/convert2monochrome"
	cp "$pdf_path" "/var/tmp/convert2monochrome/temp.pdf"

	cd /var/tmp/convert2monochrome/
	pdfFile=temp.pdf

	inputImage1="extracted-images"

	echo "extracting pages from pdf file"
	pdfimages $pdfFile $inputImage1
	echo "extraction completed"

	echo "total number of pages extracted as ppm file is"
	pgcountStr="$(pdfinfo $pdfFile |grep Pages)"
	pgcountStr=$(printf "%s" $pgcountStr)
	pgcountStrSize=${#pgcountStr}
	pgcountStr=${pgcountStr:6:$pgcountStrSize-6}
	pgCount=$((pgcountStr))
	echo "$pgCount"
	let pgCount2=pgCount-1

	echo "image conversion started"
	out="pdfFinal.pdf"

	# finding the resolution of the image
	resolution_temp="$(sed -n '2,2p' extracted-images-000.ppm)"
	IFS=' ' read -ra  resolution<<< "$resolution_temp"
	new_resolution=${resolution[0]}x${resolution[1]}
	echo "resolution of image extracted: "
	echo $new_resolution
	convert xc:none -page $new_resolution $out

	inputImage2=".ppm"
	for i in $(seq 0 $pgCount2)
	do
		outTemp1="outTemp1.pdf"
		outTemp2="outTemp2.pdf"
		cp $out $outTemp1

		if [ "$i" -lt "10" ]
		then
		    number=-00$i
		elif [ "$i" -lt "100" ]
		then
		    number=-0$i
		else
		    number=-$i
		fi
		inputImage=$inputImage1"$number"$inputImage2
		convert -monochrome $inputImage $outTemp2
		pdfunite $outTemp1 $outTemp2 $out
		echo "converted page $number"
	done

	echo "deleting the temporary files created "
	rm $outTemp1 $outTemp2 *.ppm

	new_pdf_path="${pdf_path%.pdf}.monochrome.pdf"
	new_pdf_path=${new_pdf_path//"'"/}
	echo "$new_pdf_path"
	cp /var/tmp/convert2monochrome/pdfFinal.pdf "$new_pdf_path"

	echo "copied file to $new_pdf_path directory with the file name pdfFinal.pdf :) "
}

for pdf_path in "$@"; do
	myprog "$pdf_path"
done
