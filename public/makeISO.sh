#!/bin/bash

# Download the content
wget -r -m -k -E -c -t inf -p http://selibre.osl.ull.es

# Copy the images
scp -r adminosl@librecms.osl.ull.es:/var/rails/windowsLibre/current/public/images/* ./selibre.osl.ull.es/images

# Correct the path to the homepage
for i in `ls selibre.osl.ull.es/*.html` ;
do
   sed -i 's#http://selibre\.osl\.ull\.es/##g' $i &> /dev/null;
done
 
level=0
path="../"

tourInDepth ()
{
  level="$1"
  for dir in `find . -maxdepth 1 -type d | grep -v "^.$" | grep -v "^\./\."` ;
  do
    cd $dir;
    ((level++))
    path=""
    for ((i=0;i<$level;i+=1));
    do
      path+="../"
    done
    for i in `ls *.html` ;
    do
      sed -i 's#http://selibre\.osl\.ull\.es/#'$path'#g' $i ;
    done
    tourInDepth $level
    cd ..;
    ((level--))
  done
}

cd selibre.osl.ull.es;
tourInDepth $level &> /dev/null;
cd ..;

FROM="ñÑáÁéÉíÍóÓúÚ"
TO="nNaAeEiIoOuU"
for i in `find selibre.osl.ull.es/* -iname "*.html"` ;
do
   # Correct the path to the homepage
   sed -i 's#\(\(\.\./\)\+\)\?search/Mozilla_Firefox#\1index#g' $i &> /dev/null;
   sed -i 's#\.\./Mozilla_Firefox#../../index#g' $i &> /dev/null;
   # Add the extension HTML to the application list
   sed -i 's#applications\"#applications.html"#g' $i &> /dev/null;
   # Add the extension HTML to the name of the application
   sed -i 's#applications/\(.*\)\">#applications/\1.html">#g' $i &> /dev/null;
   sed -i 's#\.html\.html#.html#g' $i &> /dev/null;
   # Remove search field
   sed -i -E -n '1h;1!H;${;g;s/<!\-\- Search  \-\->.*<!\-\- Search  end\-\->//g;p;}' $i &> /dev/null;
   # Remove tracking code
   sed -i -E -n '1h;1!H;${;g;s/<!\-\- Piwik \-\->.*<!\-\- End Piwik Tag \-\->//g;p;}' $i &> /dev/null;
   # Remove the link to the .ISO
   sed -i 's#<a href=.*\"Descargar una ISO de DVD\"></a>##' $i &> /dev/null;
   # Change "?" by "-" in the links of the pagination (needed for Windows)
   sed -i 's#%3Fpage#\-page#g' $i &> /dev/null;
   # Replace the ñ's and accents in URLs
   for url in `egrep -oi 'href=.*html' $i | sort -u | sed 's/href=.//' | grep -v "^http://" | grep -i "[ÑÁÉÍÓÚ]"`;
   do
      newURL=$(echo $url | sed "y#$FROM#$TO#")
      sed -i "s|$url|$newURL|g" $i &> /dev/null;
   done
   # Remove timestamps    
   sed -i 's|%3F[0-9]*[^"]*||g' $i &> /dev/null;
done

# Change "?" by "-" in the name of the HTML files (needed for Windows)
for file in `find selibre.osl.ull.es/* -iname "*.html" -type f` ;
do
NEWFILE=`echo $file | sed -e 's/\?page/\-page/'`;
mv -f $file $NEWFILE &> /dev/null;
done

# Replace the ñ's and accents in the directories
FROM="ñÑáÁéÉíÍóÓúÚ"
TO="nNaAeEiIoOuU"
for dir in `find selibre.osl.ull.es/* -type d | grep -i "[ÑÁÉÍÓÚ]"`;
do
   newDir=$(echo $dir | sed "y#$FROM#$TO#");
   mkdir $newDir &> /dev/null;
   cp $dir/* $newDir &> /dev/null;
done

# Remove the directories with ñ's or accents
for dir in `find selibre.osl.ull.es/* -type d | grep -i "[ÑÁÉÍÓÚ]"`;
do
   rm -rf $dir &> /dev/null;
done

# Remove timestamps
for file in `find selibre.osl.ull.es/* -type f | grep -r "?"` ;
do
   NEWFILE=`echo $file | sed -e 's/?.*//'`;
   mv -f $file $NEWFILE &> /dev/null;
done

# Remove robots.txt
rm -f selibre.osl.ull.es/robots.txt &> /dev/null;

touch selibre.osl.ull.es/autorun.inf
echo @echo off >> selibre.osl.ull.es/autorun.inf
echo [autorun] >> selibre.osl.ull.es/autorun.inf
echo open=autorun.bat >> selibre.osl.ull.es/autorun.inf
echo icon=favicon.ico >> selibre.osl.ull.es/autorun.inf
echo label=Software_Libre >> selibre.osl.ull.es/autorun.inf
echo @exit >> selibre.osl.ull.es/autorun.inf

touch selibre.osl.ull.es/autorun.bat
echo @echo Abriendo SeLibre ... >> selibre.osl.ull.es/autorun.bat
echo @start index.html >> selibre.osl.ull.es/autorun.bat
echo @cls >> selibre.osl.ull.es/autorun.bat
echo @exit >> selibre.osl.ull.es/autorun.bat

touch selibre.osl.ull.es/autorun
echo '#!/bin/bash' >> selibre.osl.ull.es/autorun
echo 'for a in firefox konqueror opera; do' >> selibre.osl.ull.es/autorun
echo 'if [[ -e `which $a` ]]; then' >> selibre.osl.ull.es/autorun
echo 'CMD=`$a index.html`;' >> selibre.osl.ull.es/autorun
echo 'exit 0' >> selibre.osl.ull.es/autorun
echo 'fi' >> selibre.osl.ull.es/autorun
echo 'done' >> selibre.osl.ull.es/autorun
echo 'exit 1' >> selibre.osl.ull.es/autorun
chmod 777 selibre.osl.ull.es/autorun

ISONAME=SeLibre$(date +%d.%m.%Y).iso
mkisofs -J -R -V "SeLibre" -o $ISONAME selibre.osl.ull.es
rm -rf selibre.osl.ull.es # Borramos el contenido descargado
ln -s $ISONAME SeLibre.iso
