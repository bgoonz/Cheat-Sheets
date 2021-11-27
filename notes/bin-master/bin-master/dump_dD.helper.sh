# Dump for spe (MP)
# Dump : done
cd ~/ma_101/MP/; time for d in $(find -type d -iname '[a-zA-Z]*'); do cd $d &>$null; title=$(grep -o "<title>.*</title>" index2.html | sed s/"<title>"// | sed s_"</title>"__); echo "title=$title et pwd=`pwd`."; for i in $(cat ex.list); do dump_dD.py "$i" "${title// /_}"; file=ex_"$i".fr.tex ; cat "$file" | tr '\t' ' ' | uniq | grep -v "^[[:space:]][[:space:]]*$" | uniq > "$file"~; diff "$file"~ "$file"; swap "$file" "$file"~; notify-send "$d:$i OK"; done; cd ~/ma_101/MP/ &>$null; done

# Dump : second try
cd ~/ma_101/MP/; time for d in $(find -type d -iname '[a-zA-Z]*'); do cd $d &>$null; title=$(grep -o "<title>.*</title>" index2.html | sed s/"<title>"// | sed s_"</title>"__); echo "title=$title et pwd=`pwd`."; for i in $(cat ex.list); do [ ! -f ex_"$i".fr.tex ] && ( dump_dD.py "$i" "${title// /_}"; file=ex_"$i".fr.tex ; cat "$file" | tr '\t' ' ' | uniq | grep -v "^[[:space:]][[:space:]]*$" | uniq > "$file"~; diff "$file"~ "$file"; swap "$file" "$file"~; notify-send "$d:$i OK" ); done; cd ~/ma_101/MP/ &>$null; done

# Build the LaTeX files : done
cd ~/ma_101/MP/; time for d in $(find -type d -iname '[a-zA-Z]*'); do cd $d &>$null; title=$(grep -o "<title>.*</title>" index2.html | sed s/"<title>"// | sed s_"</title>"__); echo "title=$title et pwd=`pwd`."; echo -e "%% -*- mode: latex; coding: utf-8 -*-\n%autotex% Titre: $title\n%% Start of LaTeX source for exercises for chapter : $title (MP), in French.\n\n\\\\begin{enumerate}" > "$d".fr.tex; for i in $(cat ex.list); do echo -e "Adding $i to $d/$d.fr.tex (chapter $title)..."; echo -e "\n\\\\item (\\\\href{http://mp.cpgedupuydelome.fr/mesexos.php?cor=1&numExo=$i}{Ex.\#$i})\n\\\\input{ex_$i.fr.tex}" >> "$d".fr.tex; done; echo -e "\n\\\\end{enumerate}\n\n%% End of LaTeX source." >> "$d".fr.tex; notify-send "Done for $d.fr.tex for chapter $title."; cd ~/ma_101/MP/ &>$null; done

# Construct the PDF files
cd ~/ma_101/MP/; CP */*.tex */*.png /tmp/; time for d in $(find -type d -iname '[a-zA-Z]*'); do cd $d &>$null; autotex -noansi "$d".fr.tex; echo -e "Done, compiling $d.fr.tex to $d.fr.pdf :)"; notify-send "Done, compiling $d.fr.tex to $d.fr.pdf :)"; cd ~/ma_101/MP/ &>$null; done


# Compress the PDF files : TODO
cd ~/ma_101/MP/; time for d in $(find -type d -iname '[a-zA-Z]*'); do cd $d &>$null; PDFCompress --no-zenity "$d".fr.pdf; echo -e "${red}Done, compressing $d.fr.pdf :)${white}"; notify-send "Done, compressing $d.fr.pdf :)"; cd ~/ma_101/MP/ &>$null; done