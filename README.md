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

![Ensembl Screenshot](https://github.com/ariadnavillam/Assignment-Answers/Assignment3/Ensembl-screenshot.png)

*The file I used for this is called *chromosome_ensembl.gff3* and is the same as chromosme.gff3 but changing the attributes column and only mantaining the IDs. It wouldn't let see the features if I introduced the file with this extra attributes.

### Requirements
**Gems**: 'net/http' and 'bio' should be installed.





