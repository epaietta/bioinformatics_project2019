<<<<<<< HEAD
#we could not get this to actually work yet
#it told us that we had the incorrect number of command line arguments
#we think we should run the proteomes through this, and then the ones that worked through hsp 
for files in proteome_*.fasta
do
../hmmer-3.2.1/bin/hmmsearch ref_sequences/aligned_mcr_genes.hmm proteomes/$files 
=======
#put all mcr and hsp genes into one file each
cat hsp*.fasta >> all_hsp_genes.fasta
cat mcr*.fasta >> all_mcr_genes.fasta

#muscle alignments of all_hsp_genes.fasta and all_mcr_genes.fasta
../../muscle -in all_hsp_genes.ref -out aligned_hsp_genes.ref

#hmmsearch output into specific tables
for files in ./proteomes/proteome*
do
../../hmmer-3.2.1/bin/hmmsearch --tblout mcr$files.hm ../ref_sequences/aligned_mcr_genes.hmm $files 
../../hmmer-3.2.1/bin/hmmsearch --tblout hsp$files.hm ../ref_sequences/aligned_hsp_genes.hmm $files
done

#make a file containing number of hits for hsp and mcr for each proteome
echo "proteome,mcr,hsp" > proteomes/final.txt
for i in {01..50}
do  
a=$(cat proteomes/hspproteome_$i.fasta.hm | grep -v "#" | wc -l)
b=$(cat proteomes/mcrproteome_$i.fasta.hm | grep -v "#" | wc -l)
echo "$i,$b,$a" >> proteomes/final.txt
>>>>>>> 673e11b4332179cec71ac6110f93cf2226d3b157
done
