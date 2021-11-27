#!/usr/bin/env bash
# Author: Lilian BESSON
# Email: Lilian.BESSON[AT]ens-cachan[DOT]fr
# Web version: https://perso.crans.org/besson/bin/count_total_pdf_pages.sh
# Date: 03-02-2019
#
# Count the total pages of all the input PDF documents.
#

function pdfinfo (){
    for i in "$@"; do
        echo -e "\n${green}# For '${red}${u}$i${U}${white}':";
        /usr/bin/pdfinfo "$i";
    done
}

nbOfPDF=$(ls -larth **/*.pdf | wc -l)
nbOfPages=$(pdfinfo **/*.pdf | grep 'Pages:' | awk '{print $2}' | paste -sd+ | bc)
echo -e "For ${nbOfPDF} PDF documents, the total number of pages is = ${nbOfPages}..."
