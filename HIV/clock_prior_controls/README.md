HIV infections in Roka were sampled over a very short window of time (only a few weeks). As such, the Roka sequences have very little temporal signal with which to estimate the evolutionary rate. To improve the precision of our estimates of TMRCA we used an informed prior on the evolutionary rate for our analyses of HIV-Env in Roka. We derived the prior from using Bayesian coalescent analysis of 27 HIV-env sequences sampled from SE Asia between 1997 and 2014 that were unrelated to the Roka outbreak.

To derive the prior we did the following:

1. Get control sequences with large temporal spread from collaborators.
2. [Estimate evolutionary rate of controls by regression of numbers of raw nucleotide differences on time.](Raw_Clock_Plots/)
3. Estimate evolutionary rate of controls in Path-O-Gen using maximum likelihood tree as input.
4. Estimate posterior evolutionary rate of controls from BEAST using uninformative CTMC rate reference (init = 1e-4) as prior.
5. Compare all estimates of evolutionary rate under different methods to check consistency.

The final prior for the evolutionary rate was taken from the posterior distribution of `clock.rate` from the control sequences, and was Normal with mean and initial value of 3.8278E-3 and standard deviation of 6.1957E-4.
