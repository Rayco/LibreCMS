#!/bin/bash

rm -f WindowsLibre*.iso
rm -f WindowsLibre.iso

wget -r -m -k -E -c -t inf -p http://windowslibre.osl.ull.es
cp -r ./images/* ./windowslibre.osl.ull.es/images
cat windowslibre.osl.ull.es/stylesheets/style.css\?* | sed -e 's/\/images/..\/images/' > windowslibre.osl.ull.es/stylesheets/style.css
rm windowslibre.osl.ull.es/stylesheets/style.css\?*

touch windowslibre.osl.ull.es/autorun.inf
echo @echo off >> windowslibre.osl.ull.es/autorun.inf
echo [autorun] >> windowslibre.osl.ull.es/autorun.inf
echo open=autorun.bat >> windowslibre.osl.ull.es/autorun.inf
echo icon=favicon.ico >> windowslibre.osl.ull.es/autorun.inf
echo label=Software_Libre >> windowslibre.osl.ull.es/autorun.inf
echo @exit >> windowslibre.osl.ull.es/autorun.inf

touch windowslibre.osl.ull.es/autorun.bat
echo @echo Abriendo Software Libre para Windows... >> windowslibre.osl.ull.es/autorun.bat
echo @start index.html >> windowslibre.osl.ull.es/autorun.bat
echo @cls >> windowslibre.osl.ull.es/autorun.bat
echo @exit >> windowslibre.osl.ull.es/autorun.bat

touch windowslibre.osl.ull.es/autorun
echo '#!/bin/bash' >> windowslibre.osl.ull.es/autorun
echo 'for a in firefox konqueror opera; do' >> windowslibre.osl.ull.es/autorun
echo 'if [[ -e `which $a` ]]; then' >> windowslibre.osl.ull.es/autorun
echo 'CMD=`$a index.html`;' >> windowslibre.osl.ull.es/autorun
echo 'exit 0' >> windowslibre.osl.ull.es/autorun
echo 'fi' >> windowslibre.osl.ull.es/autorun
echo 'done' >> windowslibre.osl.ull.es/autorun
echo 'exit 1' >> windowslibre.osl.ull.es/autorun
chmod 777 windowslibre.osl.ull.es/autorun

for i in `find windowslibre.osl.ull.es/* -iname "*.html"` ;
do
sed -i 's/\%3F[0-9]*\S/\"/' $i &> /dev/null;
done

for oldfile in `find windowslibre.osl.ull.es/* -type f` ;
do
NEWFILE=`echo $oldfile | sed -e 's/\?.*//'`;
mv -f $oldfile $NEWFILE &> /dev/null;
done

# Sustituimos las ñ's y acentos en los directorios

for dir in `find windowslibre.osl.ull.es/* -type d`;
do
   newDir=$(echo $dir | sed -e 's/ñ/n/g;s/Ñ/N/g;s/á/a/g;s/Á/A/g;s/é/e/g;s/É/E/g;s/í/i/g;s/Í/I/g;s/ó/o/g;s/Ó/O/g;s/ú/u/g;s/Ú/U/g');
   mkdir $newDir &> /dev/null;
   cp $dir/* $newDir &> /dev/null;
done
for dir in `ls windowslibre.osl.ull.es | grep "[ñ|Ñ|á|Á|é|É|í|Í|ó|Ó|ú|Ú]"`;
do
   rm -rf windowslibre.osl.ull.es/$dir &> /dev/null;
done

# Sustituimos las ñ's y acentos en las URL's locales

FROM="ñÑáÁéÉíÍóÓúÚ"
TO="nNaAeEiIoOuU"
for fich in `find windowslibre.osl.ull.es/* -iname "*.html"`;
do
   for url in `egrep -oi 'href=.[^"]*' $fich | sort -u | sed 's/href=.//' | grep -v "^http://"`;
   do
      newURL=$(echo $url | sed "y#$FROM#$TO#")
      sed "s|$url|$newURL|g" -i $fich
   done
done

rm -f windowslibre.osl.ull.es/robots.txt &> /dev/null;
ISONAME=WindowsLibre$(date +%d.%m.%Y).iso
mkisofs -J -R -V "Software Libre para Windows" -o $ISONAME windowslibre.osl.ull.es
rm -rf windowslibre.osl.ull.es # Borramos el contenido descargado
ln -s $ISONAME WindowsLibre.iso

