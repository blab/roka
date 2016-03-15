# Analysis of Roka HIV outbreak

There are two main analyses in the repo right now, an Env gene only analysis and and the (in progress) env+prot+RT analysis.

###Maximum Likelihood analysis
ML trees can be found in the [MaxLikelihood folder](https://github.com/blab/roka/tree/master/MaxLikelihood). Currently only have an ML tree for env only.

###BEAST analysis
BEAST analysis files (xmls, tree files, mcc trees, log files etc) can be found in the [beast folder](https://github.com/blab/roka/tree/master/beast)

####Analysis of Env-only
Detailed analysis pipeline, including infile preparation, alignment etc. is available in [PipelineSteps.txt](https://github.com/blab/roka/blob/master/PipelineSteps.txt)
For control sequences dates and taxon names were parsed together using [parseSeqdates.py](https://github.com/blab/roka/blob/master/Scripts/Python_scripts/parseSeqDates.py)

####Notes
* Clock prior was estimated from Francois's original analysis using [this R script](https://github.com/blab/roka/blob/master/Scripts/R_scripts/clockprior_daytoyear.R). This rate really should be estimated from a broader temporal sample of sequences from roughly the same geographic area.

* Figures can be seen in the README file in [beast](https://github.com/blab/roka/tree/master/beast).


###Analysis of Env + Prot + RT (current plan of attack)
* Data wrangle to ensure that all taxa have same dates and naming convention using [parseMultipleGenes.py](https://github.com/blab/roka/blob/master/Scripts/Python_scripts/parseMultipleGenes.py). (Done)

* Concatenate gene segments together using [ConcatGeneSegs.py](https://github.com/blab/roka/blob/master/Scripts/Python_scripts/ConcatGeneSegs.py) because segments on their own aren't sufficiently informative for GARD analysis. (Done)

* Check for recombination: Ran GARD on [Datamonkey](http://www.datamonkey.org/) to look for possible recombination cutpoints. Dataset is too large to finish the run on datamonkey (gets to 75% finished before time runs out). No recombination detected at that point, but I want to do the full run. I'll get GARD set up locally and run again.

* Use Cambodian or SE Asian sequences (control sequences) to better estimate the clock rate to use as an informed prior for phylogenetic inference. Important to allow us to get more precise estimates of the TMRCA. There isn't enough temporal spread in the Roka samples to estimate the evolutionary rate well from that data.

* IF NO RECOMBINATION: Perform coalescent phylogenetic inference. Allow different clocks for the different genes, but share the tree priors. 

* IF YES RECOMBINATION: Split the sequence on found cutpoints and peform the phylogenetic analysis.
