#Python script for merging files that have date information with files that have sequences

#File 1: Has taxon name and taxon date
#File 2: Has taxon name and taxon sequence


#Step 1: Build dictionary that maps the sampling date to the taxon name (name is the key)
taxa_dates = {}
with open("control_seq_dates.txt", 'rU') as f: #rU allows \n and \r to designate newline
	for line in f:
		split_line = line.split("\t")
		taxa_dates[split_line[0]] = split_line[1].strip()

#print taxa_date_dict.keys() #Check that dictionary read in has worked.

#in the sequence file, the header has more information than just the short ID in the other file.
#EG. >VL-1421214|env|control|NA, whereas the other file just has VL1421214 as the ID
#so, need a way to identify the sequences by the short name as well as still have access to the full header

shortID_seqs= ["taxon":taxon, "sequence":sequence]

with open("full_env_aligned.fasta", 'rU') as f:
    for line in f:
    	#Doing a bit of clean-up so that the headers are more useful 
        if line.startswith(">"): #for lines that represent the taxon name (full header)
        	val_list = line.split('|') #turn the name into a list of strings, splitting on pipes
        	shortID = val_list[0] #the "shortID is then the first element in that list"
        	shortID = shortID.replace('>', '') #remove the carrot from the short ID
        	if '-' in shortID: #because the names have - in one file, but not in the other, need to standardize
        		shortID = shortID.replace('-', '') #doing this because the VL names have - in one file, not in the other
        	
        	#NOW, go searching through the dict that has the date information and extract dates (the values)
        	#when the shortID's match between the two files.
        	if shortID in taxa_dates:
        		date = taxa_dates[shortID] #if shortID is in the date file, then date = the value (date) associated with the name key
        		control_status = 'control' #if shortID is in the date file, then date = the value (date) associated with the name key
        	else: #for some control sequences there isn't a date, so put N/A
        		date = val_list[3].strip() #if there isn't a record in taxa_dates, pull the date from the larger header
        		control_status = 'roka' #if there isn't a record in taxa_dates, pull the date from the larger header
        	shortID_seqs.append({'shortID' : shortID, 'control_status' : control_status,  'date' : date})

        else: #line is NOT a header(is a sequence)
        	shortID_seqs[-1]['seq'] = line.rstrip()# previous entry gets a new dict entry 'seq' and the sequence is attached

#shortID_seqs is a LIST of dictionaries, where each dictionary has all of a taxon's info (eg sampling date, seq, ID etc)
#print shortID_seqs[0]

### NOW, I want to print out a fasta file for all records that HAVE A SAMPLING DATE:
outfile = open("dated_controls_roka_aligned.txt", 'w')

for i in xrange(len(shortID_seqs)):
	if not shortID_seqs[i]['date'] in ['NA', 'N/A', 'NA\n']:
		output_string = ">" + shortID_seqs[i]['shortID'] + "|" + shortID_seqs[i]['control_status'] + "|" + shortID_seqs[i]['date'] + "\n" + shortID_seqs[i]['seq'] + "\n"
	outfile.write(output_string)

#printing multiple entries of X0401895, but that seems to be the only one. Not sure why. Troubleshoot tomorrow.
