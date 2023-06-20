# Instruction of reproducing results in ViralCC paper
We take the cow fecal datasets for example. The other two datasets were processed following the same procedure.

Scripts to process the intermediate data and plot figures are available in the folder [Scripts](https://github.com/dyxstat/Reproduce_ViralCC/tree/main/Scripts).

Source data of Figure 2 and 3 in the main text and Figure S1 in the supplementary materials are provided in the folder [Source Data](https://github.com/dyxstat/Reproduce_ViralCC/tree/main/Source%20Data).

**Version of softwares exploited in the analyses**
```
fastq_dump command from Sratoolkit: v2.10.8

bbduk.sh and clumpify.sh command from BBTools suite: v37.25

megahit command from MEGAHIT: v1.2.9

bwa command from BWA MEM: v0.7.17

samtools command from Samtools: v1.15.1

wrapper_phage_contigs_sorter_iPlant.pl command from VirSorter: v1.0.6

checkv command from CheckV: 0.7.0
```

**Step 1 Download and preprocess the raw data**
Note: NCBI may update its links for downloading the database. Please check the latest link at [NCBI](https://www.ncbi.nlm.nih.gov/) if you meet the download error.
```
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-13/ERR2282092/ERR2282092.1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-13/ERR2530126/ERR2530126.1
wget https://sra-downloadb.be-md.ncbi.nlm.nih.gov/sos2/sra-pub-run-13/ERR2530127/ERR2530127.1

fastq-dump --split-files --gzip ERR2282092.1
fastq-dump --split-files --gzip ERR2530126.1
fastq-dump --split-files --gzip ERR2530127.1

bbduk.sh  in1=ERR2282092.1_1.fastq.gz in2=ERR2282092.1_2.fastq.gz out1=COWSG1_AQ.fastq.gz out2=COWSG2_AQ.fastq.gz ref=/home1/yuxuandu/cmb/SOFTWARE/bbmap/resources/adapters.fa ktrim=r k=23 mink=11 hdist=1 minlen=50 tpe tbo
bbduk.sh  in1=ERR2530126.1_1.fastq.gz in2=ERR2530126.1_2.fastq.gz out1=S3HIC1_AQ.fastq.gz out2=S3HIC2_AQ.fastq.gz ref=/home1/yuxuandu/cmb/SOFTWARE/bbmap/resources/adapters.fa ktrim=r k=23 mink=11 hdist=1 minlen=50 tpe tbo
bbduk.sh  in1=ERR2530127.1_1.fastq.gz in2=ERR2530127.1_2.fastq.gz out1=M1HIC1_AQ.fastq.gz out2=M1HIC2_AQ.fastq.gz ref=/home1/yuxuandu/cmb/SOFTWARE/bbmap/resources/adapters.fa ktrim=r k=23 mink=11 hdist=1 minlen=50 tpe tbo

bbduk.sh  in1=S3HIC1_AQ.fastq.gz in2=S3HIC2_AQ.fastq.gz out1=S3HIC1_CL.fastq.gz out2=S3HIC2_CL.fastq.gz trimq=10 qtrim=r ftm=5 minlen=50
bbduk.sh  in1=M1HIC1_AQ.fastq.gz in2=M1HIC2_AQ.fastq.gz out1=M1HIC1_CL.fastq.gz out2=M1HIC2_CL.fastq.gz trimq=10 qtrim=r ftm=5 minlen=50
bbduk.sh  in1=COWSG1_AQ.fastq.gz in2=COWSG2_AQ.fastq.gz out1=COWSG1_CL.fastq.gz out2=COWSG2_CL.fastq.gz trimq=10 qtrim=r ftm=5 minlen=50

bbduk.sh in1=S3HIC1_CL.fastq.gz in2=S3HIC2_CL.fastq.gz out1=S3HIC1_trim.fastq.gz out2=S3HIC2_trim.fastq.gz ftl=10
bbduk.sh in1=M1HIC1_CL.fastq.gz in2=M1HIC2_CL.fastq.gz out1=M1HIC1_trim.fastq.gz out2=M1HIC2_trim.fastq.gz ftl=10

clumpify.sh in1=S3HIC1_trim.fastq.gz in2=S3HIC2_trim.fastq.gz out1=S3HIC1_dedup.fastq.gz out2=S3HIC2_dedup.fastq.gz dedupe
clumpify.sh in1=M1HIC1_trim.fastq.gz in2=M1HIC2_trim.fastq.gz out1=M1HIC1_dedup.fastq.gz out2=M1HIC2_dedup.fastq.gz dedupe
cat S3HIC1_dedup.fastq.gz M1HIC1_dedup.fastq.gz > HIC1.fastq.gz
cat S3HIC2_dedup.fastq.gz M1HIC2_dedup.fastq.gz > HIC2.fastq.gz
```

**Step 2: Assemble contigs and align processed Hi-C reads to contigs**
```
megahit -1 COWSG1_CL.fastq.gz -2 COWSG2_CL.fastq.gz -o COW_ASSEMBLY --min-contig-len 1000 --k-min 21 --k-max 141 --k-step 12 --merge-level 20,0.95

bwa index final.contigs.fa
bwa mem -5SP final.contigs.fa HIC1.fastq.gz HIC2.fastq.gz > COW_MAP.sam
samtools view -F 0x904 -bS COW_MAP.sam > COW_MAP_UNSORTED.bam
samtools sort -n COW_MAP_UNSORTED.bam -o COW_MAP_SORTED.bam
```

**Step3: Identify viral contigs from assembled contigs**
```
perl removesmalls.pl 3000 final.contigs.fa > cow_3000.fa
wrapper_phage_contigs_sorter_iPlant.pl -f cow_3000.fa --db 1 --wdir output_directory --ncpu 16 --data-dir /panfs/qcb-panasas/yuxuandu/virsorter-data
Rscript find_viral_contig.R
```

**Step4: Run ViralCC**
```
python ./viralcc.py pipeline -v final.contigs.fa COW_MAP_SORTED.bam viral.txt out_cow
```

**Step5: Evaluation draft viral genomes using CheckV**
```
python concatenation.py -p out_cow/VIRAL_BIN -o viralCC_cow_bins.fa
checkv end_to_end viralCC_cow_bins.fa output_checkv_viralcc_cow -t 16 -d /panfs/qcb-panasas/yuxuandu/checkv-db-v1.0
```
