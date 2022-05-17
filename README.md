# **Downloading Genomes from RefSeq** <br />
<br />


## **Step 1: Collect the assembly summary report for your organism of interest from the NCBI RefSeq Index** 


**For example, the assembly summary report for Bacteria can be obtained as follows:**


```
wget ftp://ftp.ncbi.nih.gov/genomes/refseq/bacteria/assembly_summary.txt
```


For other organisms, navigate to the assembly summary report starting from the ‘Index of /genomes/refseq’ as shown below:
<br />
<br />
<br />
<br />
<p align="center">
  <img 
    width="650"
    height="700"
    src="https://github.com/asadprodhan/Downloading_genomes_from_RefSeq/blob/main/Index_NCBI.PNG"
  >
</p>
<p align = "center">
Figure showing organism directory in RefSeq
</p>

<br />


## **Step 2: Filter out your targeted genomes from the assembly report** 


**For example, all species of Pseudomonas can be extracted from the bacterial assembly report as follows:**


```
#!/bin/bash
awk -F '\t' '{if($8 ~ /Pseudomonas/) print $1","$2","$3","$5","$8","$11","$12","$14","$15","$16","$20}' assembly_summary.txt > assembly_summary_complete_genomes_Pseudomonas.txt
```


**What the script does:**



- Column 8 ($8) in the assembly report contains the name of the species. ‘~ /Pseudomonas/’ will extract only the Pseudomonas species
  Here, we are extracting Pseudomonas species along with other metadata in different columns of the assembly report.
  
  
- Column 1 ($1):  # assembly_accession


- Column 2 ($2):  bioproject ID


- Column 3 ($3):  biosample ID


- Column 5 ($5):  refseq_category, is it a representative genome? representative genome are quality-checked by RefSeq team


- Column 8 ($8):  organism_name


- Column 11 ($11):  version_status, is it latest?


- Column 12 ($12):  assembly_level, complete genome, scaffold or contig


- Column 14 ($14):  genome_rep, full? or partial?


- Column 15 ($15):  seq_rel_date, release date


- Column 16 ($16):  asm_name, assembly name


- Column 20 ($20):  ftp_path, the download link (however, the links, as they appear here, do not download the files, the links need to be amended in the following step to get them download-ready)

<br />


## **Step 3: Amend the above links to get them download-ready**


In column 20, the links appear as follows:


https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/763/245/GCF_000763245.3_ASM76324v3


To get it download-ready, two amendments are required:


•	The last part i.e. “GCF_000763245.3_ASM76324v3” needs to be repeated. So, it will look like this: https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/763/245/GCF_000763245.3_ASM76324v3/GCF_000763245.3_ASM76324v3


•	A file extension (_genomic.fna.gz) need to be added
So, the download-ready version of the links in column 20 will look like this:


https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/763/245/GCF_000763245.3_ASM76324v3/GCF_000763245.3_ASM76324v3_genomic.fna.gz


**This amendment can be done in excel as follows:**


- Convert the filter assembly report from text to xlsx format


- Select Column 20 and split it using the ‘Text to Columns’ function in the ‘Data’ Tab and ‘/’ as text separator


- Then build the link using concatenation function in excel


- Save the names of the genomes and their newly built download-ready link in csv format. This file will serve as a temple or metadata for the next step
<br />


## **Step 4: Download the genomes**


The following script will download the genomes using the download-ready links and rename the files 


```
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
```


**What the script does:**


- 'SAMPLES=*.csv' takes a csv file that has the genome names in Column 1 (Field 1) and the download-ready links in Column 2 (Field 2)

- 'wget' downloads and renames the files


- 'gzip' decompress the file


- 'echo' will show the progress on the screen


- 'tput' commands are for color formating of the screen displays (optional)

<br />
<br />


**The End**


