# Data

This directory contains data for `HIV`, `HCV`, and `HBV`. The datafiles were created via the following pipeline.

1. Merge date information with genetic sequences, writing date information in fasta headers.
2. Align sequences using mafft-linsi.
3. Check alignments visually in Geneious.
4. For maximum likelihood analyses convert `.fasta` to `.phyx` using seqmagick.
