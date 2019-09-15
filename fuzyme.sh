#!/bin/bash
#Thx To all Agressiv1njectorTeam
#Thx for Widhisec - IndoXploit

cyan='\033[0;36m'
green='\033[0;34m'
okegreen='\033[92m'
white='\033[1;37m'
red='\033[1;31m'
yellow='\033[1;33m'
BlueF='\033[1;34m'
N='\033[39m'
date=$(date)


str="------------------------------------------------------"
cat << "EOF"


███████╗██╗   ██╗███████╗██╗   ██╗███╗   ███╗███████╗
██╔════╝██║   ██║╚══███╔╝╚██╗ ██╔╝████╗ ████║██╔════╝
█████╗  ██║   ██║  ███╔╝  ╚████╔╝ ██╔████╔██║█████╗  
██╔══╝  ██║   ██║ ███╔╝    ╚██╔╝  ██║╚██╔╝██║██╔══╝  
██║     ╚██████╔╝███████╗   ██║   ██║ ╚═╝ ██║███████╗
╚═╝      ╚═════╝ ╚══════╝   ╚═╝   ╚═╝     ╚═╝╚══════╝
                                                     
::::::: Mass Url Scraping Crawler and fuzzer :::::::::
              [+] Author by Kedjaw3n [+]
EOF
echo -e "             ${date}"

echo "$str"
echo -e -n "[+]input url list :\e[1;32m"
read line
echo -e "\e[39m$str"
while read line
do
site="$line"
rm -rf 1.txt
rm -rf $site
echo -e -n "[+]crawling site  :\e[1;32m$line\e[39m......"
sp="/-\|"
sc=0
spin() {
   printf "\b${sp:sc++:1}"
   ((sc==${#sp})) && sc=0
}
endspin() {
   printf "\r%s\n" "$@"
}

function visit(){
    echo "$site"/$line >> ${site%/*}/url.txt                                                                                                                                       
    curl -s "$1" | grep -P -a -o 'href="[^"]*' | tr -d "#" | sed 's/href="//g' | sed 's/--//g' | tr -d '<>' | tr -d '!' | grep -v "^$" | cut -d ":" -f1 | sed 's/https//g' | sed 's/http//g' | grep -v "^$" >> $2
}
function jpg(){
    echo "$site"/$line >> ${site%/*}/url.txt                                                                                                                         
    curl -s "$1" | grep -P -a -o 'src="[^"]*' | tr -d "#" | sed 's/src="//g' | sed 's/--//g' | tr -d '<>' | tr -d '!' | grep -v "^$" | cut -d ":" -f1 | sed 's/https//g' | sed 's/http//g' | grep -v "^$" >> $2
}

mkdir -p $site

visit $site 1.txt
jpg $site 1.txt
while read line
do
    spin
    visit $line 1.txt
    jpg $line 1.txt
done < 1.txt;endspin
echo "$str"
echo -e "\e[1;33m[+]Result\e[39m"
echo "$str"

rm -r 1.txt


cat ${site%/*}/url.txt | grep -e ".jpg" -e ".png" -e ".ico" > ${site%/*}/images.txt
cat ${site%/*}/url.txt | grep -e ".css" -e ".js" > ${site%/*}/js.txt
cat ${site%/*}/url.txt | grep -e ".php?id=" -e "?*=" -e ".html" > ${site%/*}/sqli.txt

total=$(cat ${site%/*}/url.txt | wc -l)
echo "[+]Total Url      : ${total} url.txt"
img=$(cat ${site%/*}/images.txt | wc -l)
echo "[+]images url     : ${img} images.txt"
js=$(cat ${site%/*}/js.txt | wc -l)
echo "[+]js url         : ${js} js.txt"
sqli=$(cat ${site%/*}/sqli.txt | wc -l)
echo "[+]sqli vuln      : ${sqli} sqli.txt"
echo "$str"

done < $line;rm -rf *.jpg