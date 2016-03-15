def parse_multiline_seq(fasta_file):
    sequences_dict={}
    with open(fasta_file, "rU") as f:
        reformatted_seqs=[]
        multiline_seqList = []
        for line in f:
            if line.startswith(">"):
                sequences_dict['taxon'] = line.strip()
            if not line.startswith(">"):
                multiline_seqList.append(line.strip().upper())
            full_seq = "".join(multiline_seqList)
            sequences_dict['sequence'] = full_seq

            reformatted_seqs.append()
    return sequences_dict
    f.close()

reformatted_seqs = []

reformatted_seqs.append(parse_multiline_seq('roka_RT.fasta'))

print reformatted_seqs[1]