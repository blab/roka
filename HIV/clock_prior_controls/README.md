Because sequences from the Roka outbreak were sampled so close together in time the dataset has very little temporal signal. To improve the precision of our estimates of TMRCA we used an informed prior on the evolutionary rate for HIV-Env sequences.

While we might expect the clock to be slightly different on the time scale of an epidemic (when there's not enough time for purifying selection to reduce the mutation load) than over the time scale of 10-15 years, there's not a great dataset to use for prior elicitation at the epidemic level. The scale we are working at should be a decent approximation.

To derive the prior we did the following:

1. Get control sequences with large temporal spread from collaborators.
2. Estimate evolutionary rate of controls by regression of numbers of raw nucleotide differences on time.
3. Estimate evolutionary rate of controls in Path-O-Gen using maximum likelihood tree as input.
4. Estimate posterior evolutionary rate of controls from BEAST using uninformative CTMC rate reference (init = 1e-4) as prior.
5. Compare all estimates of evolutionary rate under different methods to check consistency.

The final prior for the evolutionary rate was taken from the posterior distribution of `clock.rate` from the control sequences, and was Normal with mean and initial value of 3.8278E-3 and standard deviation of 6.1957E-4.
