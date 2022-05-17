#!/bin/bash
#
#textFormating
Red="$(tput setaf 1)"
Green="$(tput setaf 2)"
reset=`tput sgr0` # turns off all atribute
Bold=$(tput bold)
#
#FTP-links
SAMPLES=*.csv
#
while IFS=, read -r field1 field2  

do  
    echo "${Red}${Bold} Downloading...${reset}: "${field1}""
    echo "Name : $field1" 
    echo "FTP-link : $field2" 
        
    wget "${field2}" -O ${field1}.fna.gz 
    gzip -d ${field1}.fna.gz 
    echo "${Green}${Bold} Download completed${reset}:"${field1}""
    echo " "
    
done < ${SAMPLES}

