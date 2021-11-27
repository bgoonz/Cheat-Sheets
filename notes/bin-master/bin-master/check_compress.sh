#!/usr/bin/env /bin/bash
# (C) Lilian Besson, 09-10-2013
#
# A very simple script to check if a PDF file has already been compressed with gs or
# PDFCompress (last version on http://perso.crans.org/besson/bin/PDFCompress).
#
# Use it with find to find the PDF not compressed
# Example:
# $ find . -type f -iname '*'.pdf -exec check_compress.sh '{}' \;
#   --> print every PDF file not already compressed.

for i in "$@"; do
( pdfinfo "$i" | grep "\(Ghostscript\|PDFCompress\)" > /dev/null ) \
 || echo "$i"
done