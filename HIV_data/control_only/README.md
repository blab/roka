### Analyses performed on the controls

##### Dating controls:

Dates were pulled from excel files and were parsed into the fasta files based on matching of the ID in the fasta header with the ID in the excel file.
See ipython notebook for details.

##### Alignments of control sequences:

Alignments were performed using MAFFT and checked visually in Geneious. A couple of notes:

* RT and Prot sequences were easily aligned using mafft linsi. COMMAND: mafft-linsi infile.fasta > outfile.fasta

* Env sequences did not align particularly well under mafft-linsi (there were lots of odd introduced gaps).
In order to improve the alignment quality I aligned the env sequences as fragments to the LANL env sequence compendium alignment.
COMMAND: 

See (http://mafft.cbrc.jp/alignment/software/addsequences.html) for explanations and visuals of how this works in mafft.

##### Testing for recombination in control sequence alignments:

* Aligned control sequence fasta files were analyzed by GARD via (www.datamonkey.org) using HKY85, and no variation between sites.