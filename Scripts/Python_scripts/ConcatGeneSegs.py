#start with the file that has the date information (the env file)

from Bio import SeqIO
#Make nested dictionaries with following format:
# {NCHADS000: {'Date':12-13-1900, 'RT':'ACCTTTTT', 'ENV':'ACGCGT', 'PROT': 'CGCGCGCTTT'}

master_dict = {}

#read in to master dict the taxa names as keys
with open("roka_env_aligned.fasta", 'rU') as file:
    for line in file:
        if line.startswith(">"): #for lines that represent the taxon name (full header)
            val_list = line.split('|') #turn the name into a list of strings, splitting on pipes
            shortID = val_list[0] #the "shortID is the first element in that list"
            shortID = shortID.replace('>', '') #remove the carrot from the short ID
            date = val_list[3].strip() #sampling date
            master_dict[shortID] = {'date': date}
        else: #line is a sequence that is a whole string WITHOUT NEW LINES
            master_dict[shortID]['env'] = line.rstrip().upper()# previous entry gets a new dict entry 'seq' and the sequence is attached
            #the master_list[-1]seems a little funky, but if you are at the sequence, then the taxon it belongs to is one line BEHIND the seq. 
file.close()

#Now I want to read in the other gene sequences, and add the correct sequence to the dictionary using the taxon name key in master_dict

#Doing this for the PROT seqs here
prot_file = open('Roka_Prot_Aligned.fasta', "rU")
prot_dict = SeqIO.to_dict(SeqIO.parse(prot_file, "fasta"))
prot_file.close()

for key in prot_dict.keys():
	if key in master_dict.keys():
		master_dict[key]['prot'] = prot_dict[key].seq.upper()
	else:
		master_dict[key] = {'prot': prot_dict[key].seq.upper()}

#And now for the RT sequences as well:
RT_file = open('Roka_RT_Aligned.fasta', "rU")
RT_dict = SeqIO.to_dict(SeqIO.parse(RT_file, "fasta"))
RT_file.close()

for key in RT_dict.keys():
	if key in master_dict.keys():
		master_dict[key]['RT'] = RT_dict[key].seq.upper()
	else:
		master_dict[key] = {'RT': RT_dict[key].seq.upper()}


# Check how long each gene's alignment is (note that all entries will be the same length because the input files were already aligned with MAFFT)
'''
print len(master_dict['NCHADS134']['prot'])
print len(master_dict['NCHADS134']['RT'])
print len(master_dict['NCHADS134']['env'])
'''
#PROT alignment has 399 columns
#RT alignment has 828 columns
#Env alignment has 638 columns


# For those taxa that do not have sequences for all three gene segments of interest, make an entry that is N (ambiguous) which will be treated like
# missing data in the phylogenetic analyses.
null_env = 'N' * 638
null_prot = 'N' * 399
null_RT = 'N' * 828

for taxon in master_dict:
	if 'env' not in master_dict[taxon]:
		master_dict[taxon]['env'] = null_env

for taxon in master_dict:
	if 'prot' not in master_dict[taxon]:
		master_dict[taxon]['prot'] = null_prot

for taxon in master_dict:
	if 'RT' not in master_dict[taxon]:
		master_dict[taxon]['RT'] = null_RT
		
for taxon in master_dict:
	if 'date' not in master_dict[taxon]:
		master_dict[taxon]['date'] = 'XX-XX-XXXX'
#Note that concatenation goes PROT + RT + ENV (the actual genomic order of these segments in the HIV genome)
with open ('envProtRT_concat_AB.txt', 'w') as outfile:
	for taxon in master_dict:
		outfile.write(str('>' + taxon + '|' + master_dict[taxon]['date'] + '\n'))
		outfile.write(str(master_dict[taxon]['prot'] + master_dict[taxon]['RT'] + master_dict[taxon]['env'] + '\n'))
