# Analysis of Roka HIV outbreak

##Workflow
There are two main analyses in the repo right now, an [env_only]() analysis and and the [env+prot+RT]() analysis. We are still working on the combined gene analysis.

###Maximum Likelihood analysis
ML trees can be found in the [MaxLikelihood folder](https://github.com/blab/roka/tree/master/MaxLikelihood)

###BEAST analysis
BEAST analysis files (xmls, tree files, mcc trees, log files etc) can be found in the [BEAST folder]()

####Analysis of Env gene only
Figures from this analysis can be seen in the [BEAST]() portion of the repo
Detailed analysis pipeline, including infile preparation, alignment etc is available [PipelineSteps.txt]()
For control sequences dates and taxon names were parsed together using [parse_seqdates.py]()

####Findings so far
*All samples from Roka group together phylogenetically except for NCHADS116, 171, 184, and 185
*Clock prior was estimated from Francois's original analysis using [this R script]()
*TMRCA estimated around
*Apparent logistic growth based on the skyline plots
    * When we run a logistic growth model in BEAST it appears that the midpoint of the logistic curve is in the future. BEAST can't handle this, so for trying to estimate growth rates we'll use an exponential demographic model. 


###Analysis of Env + Prot + RT
*Data wrangle to ensure that all taxa have same dates and naming convention using [parseMultipleGenes.py]()
*Concatenate gene segments together using [ConcatGeneSegs.py]() because segments on their own aren't sufficiently informative for GARD analysis
*Check for recombination: Ran GARD on [Datamonkey](http://www.datamonkey.org/) to look for possible recombination cutpoints. 