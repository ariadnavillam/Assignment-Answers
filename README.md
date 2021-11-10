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

Use:
```bash
$ ruby main.rb gene_file.txt output.txt [intact-miscore] [depth]
```
- *gene_file.txt*: file containing the list of genes
- *output.txt*: file to save the output
- *\[intact-miscore]\(optional)*: minimum score to consider an interaction. Value between 0 and 1. The recommended value is 0.45, which is the default value in the script.
- *\[depth]\(optional)*: the depth of the search. Value can go from 1 to 3 (int). 1 being direct interaction, 2 interaction by one intermediate gene that is not on the list and 3 interaction by two intermediate genes*. Values bigger than 3 take too much time.

*The intermediate genes are not printed in the output.

