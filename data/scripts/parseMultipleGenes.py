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
'''
print master_dict['NCHADS042']
print master_dict['NCHADS042']['date']
print master_dict['NCHADS042']['env']
'''
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
'''
print master_dict['NCHADS134']
print master_dict['NCHADS134']['env']
print master_dict['NCHADS134']['prot']
print master_dict['NCHADS171']
print master_dict['NCHADS171']['prot']
'''

#And now for the RT sequences as well:
RT_file = open('Roka_RT_Aligned.fasta', "rU")
RT_dict = SeqIO.to_dict(SeqIO.parse(RT_file, "fasta"))
RT_file.close()

for key in RT_dict.keys():
	if key in master_dict.keys():
		master_dict[key]['RT'] = RT_dict[key].seq.upper()
	else:
		master_dict[key] = {'RT': prot_dict[key].seq.upper()}

#print master_dict['NCHADS134']

#make separate outfiles for ENV PROT and RT gene segments with TAXON LABELS THE SAME
#note that not all taxa have sequences for each gene. If no sequence is known then 
#the taxa is currently excluded. If necessary I'll change that and make it fill in N's
with open ('roka_env_AB.txt', 'w') as outfile:
	for taxon in master_dict:
		if 'date' in master_dict[taxon] and 'env' in master_dict[taxon]:
			outfile.write(str('>' + taxon + '|' + master_dict[taxon]['date'] + '\n'))
			outfile.write(str(master_dict[taxon]['env'] + '\n'))
		else:
			continue

with open('roka_PROT_AB.txt', 'w') as outfile:
	for taxon in master_dict:
		if 'date' in master_dict[taxon] and 'prot' in master_dict[taxon]:
			outfile.write(str('>' + taxon + '|' + master_dict[taxon]['date'] + '\n'))
			outfile.write(str(master_dict[taxon]['prot'] + '\n'))
		else:
			continue	

with open ('roka_RT_AB.txt', 'w') as outfile:
	for taxon in master_dict:
		if 'date' in master_dict[taxon] and 'RT' in master_dict[taxon]:
			outfile.write(str('>' + taxon + '|' + master_dict[taxon]['date'] + '\n'))
			outfile.write(str(master_dict[taxon]['RT'] + '\n'))
		else:
			continue	






