# Assignment Answers

Name: Ariadna Villanueva Marijuán

Course: Bioinformatic Programming Challenges

## Assignment 1 - Creating objects

Use:

```bash
$ ruby process_database.rb  gene_information.tsv  seed_stock_data.tsv  cross_data.tsv  new_stock_file.tsv
```

## Assignment 2 - Intensive integration using Web APIs

This script takes a list of genes and creates interaction networks with them, searching for interactions in the [IntAct Database](https://www.ebi.ac.uk/intact/home), and then annotates the networks with a KEGG pathway and GO terms using web APIs.

### Use:
```bash
$ ruby main.rb gene_file.txt output.txt [intact-miscore] [depth]
```
- *gene_file.txt*: file containing the list of genes
- *output.txt*: file to save the output
- *\[intact-miscore]\(optional)*: minimum score to consider an interaction. Value between 0 and 1. The recommended value is 0.45, which is the default value in the script.
- *\[depth]\(optional)*: the depth of the search. Value can go from 1 to 3 (int). 1 being direct interaction, 2 interaction by one intermediate gene that is not on the list and 3 interaction by two intermediate genes*. Values bigger than 3 take too much time.

*The intermediate genes are not printed in the output.

**Warning**: errors are not printed in the screen. Check the file *log.txt* for errors. 

### Requirements
**Gems**: "rest-client", "CSV" and "json" must be installed.

## Assignment 3 - GFF feature files and visualization

The purpose of this script is to search for CTTCTT motifs the exons of a list of genes using BioRuby. It takes the file with the genes and retrieves the EMBL entry, obtaining the sequence of the gene, the exons, the chromosome position, etc. and searches for the CTTCTT motifs in this exons using regular expressions. It also looks for AAGAAG motif since the sequenced used is the one of the coding exon, so there could be a CTTCTT motif in the complementary strand. 

Use:

```bash
$ ruby main.rb  genes_list.txt
```

Ouput:
- *genes.gff3*: gff3 file contaning the motifs with the gene coordinates (I added the 4 since it's the one corresponding to that exercise).
- *chromosome.gff3*: gff3 file containing the motifs with chromosome coordinates. In the attributes columns (the last one) prints out the exons contaning the motifs (exercise 5).
- *genes_wo_motif.txt*: list of genes in which a CTTCTT motif was not found.

Screenshot of gff3 file in Ensemble:

![Ensembl Screenshot](https://github.com/ariadnavillam/Assignment-Answers/blob/main/Assignment3/Ensembl-screenshot.png)

*The file I used for this is called *chromosome_ensembl.gff3* and is the same as chromosme.gff3 but changing the attributes column and only mantaining the IDs. It wouldn't let see the features if I introduced the file with this extra attributes.

### Requirements
**Gems**: 'net/http' and 'bio' should be installed.


## Assignment 4 - Searching for Orthologues

Putative orthologs search is made using local blast. For that purpose, a reciprocal best BLAST is made. 

Parameter to filter:
As stated in (1) and (2), to filter the searches I will use a maximum evalue of $10^-6$. The lower the E-value, or the closer it is to zero, the more "significant" the match is. In {blast webpage}[https://blast.ncbi.nlm.nih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=FAQ] they also recommend using the e-value for significance threshold. However, we have to take into account that higher e-values are more common in short alignments, because the probability of finding shorter sequences is higher. We could be leaving out some identical matches of short sequences.

Use:

```bash
$ ruby main.rb  file_species1.fa file_species2.fa outputfile.txt ([evalue])
```
- *file_species1.fa*: fasta file with genes of species 1.
- *file_species2.fa*: fasta file with genes of species 2.
- *outputfile.txt*: file to save the output 
- *\[evalue]\(optional)*: evalue to filter the homology. The recommended value is 1e-6, which is the default value in the script.


Output:
The output is a txt file with two colums, named after the input files. 

To continue the analysis...
In the datafiles we have for this assignment we have a dataset of nucleic acids and another one of proteins. In the nucleic acids file, the genes could have introns, exons or regulatory sequences. If we had both files with proteins we could also consider to filter by coverage of 50%, which is also proposed in (2). We could also compare the GOs of the putative orthologs. This was proposed in (3) although they argue that there are differences in GO annotations depending on the species. However, it was found the orhologs had more common GO annotations than paralogs. 

Another approach could be comparing the phylogentic tree of the species, as proposed in (4), although we need a small set of genes for that. 

It seems like finding orthologs is not as easy as it seems, since there is an open collaboration framework called "Quest for Orthologs" currently developing a standard methodology. It is formed by experts in comparative phylogenomics and related research areas who have an interest in highly accurate orthology predictions and their applications (5).

References:
1. Gabriel Moreno-Hagelsieb, Kristen Latimer, Choosing BLAST options for better detection of orthologs as reciprocal best hits, Bioinformatics, Volume 24, Issue 3, 1 February 2008, Pages 319–324, [https://doi.org/10.1093/bioinformatics/btm585]
2. Ward N, Moreno-Hagelsieb G (2014) Quickly Finding Orthologs as Reciprocal Best Hits with BLAT, LAST, and UBLAST: How Much Do We Miss?. PLOS ONE 9(7): e101850. [https://doi.org/10.1371/journal.pone.0101850]
3. Altenhoff AM, Studer RA, Robinson-Rechavi M, Dessimoz C (2012) Resolving the Ortholog Conjecture: Orthologs Tend to Be Weakly, but Significantly, More Similar in Function than Paralogs. PLOS Computational Biology 8(5): e1002514. [https://doi.org/10.1371/journal.pcbi.1002514]
4. David M. Kristensen, Yuri I. Wolf, Arcady R. Mushegian, Eugene V. Koonin, Computational methods for Gene Orthology inference, Briefings in Bioinformatics, Volume 12, Issue 5, September 2011, Pages 379–391, [https://doi.org/10.1093/bib/bbr030]
Kristoffer Forslund, Cecile Pereira, Salvador Capella-Gutierrez, Alan Sousa da Silva, Adrian Altenhoff, Jaime Huerta-Cepas, Matthieu Muffato, Mateus Patricio, Klaas Vandepoele, Ingo Ebersberger, Judith Blake, Jesualdo Tomás Fernández Breis, The Quest for Orthologs Consortium, Brigitte Boeckmann, Toni Gabaldón, Erik Sonnhammer, Christophe Dessimoz, Suzanna Lewis, Quest for Orthologs Consortium, Gearing up to handle the mosaic nature of life in the quest for orthologs, Bioinformatics, Volume 34, Issue 2, 15 January 2018, Pages 323–329, [https://doi.org/10.1093/bioinformatics/btx542]


### Requirements
**Gems**: 'bio' should be installed.
Blast should also be installed locally ([https://blast.ncbi.nlm.nih.gov/Blast.cgi]).


