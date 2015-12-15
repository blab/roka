#To estimate the clock prior for the BEAST analysis
#Using the clock.rate distribution from Francois et al.'s original log files
#Appears to be a roughly normal distribution

getwd()
setwd("/Users/alliblk/Desktop/Git_Repo_Folders/roka/")


rokaFrancois = read.table("Francois_strictLog.tsv", header=T)
head(rokaFrancois$clock.rate)
length(rokaFrancois$clock.rate)
#100,000 entries representing 100 million states...logging every 1000 

#To simulate the burnin that Tracer would do, drop the first 10% of the observations
#Here that's the first 10000 logged observations 

burnedclockrate_days= rokaFrancois$clock.rate[c(10000:100000)]
head(burnedclockrate_days)
hist(burnedclockrate_days, breaks=50, col="red")

#Transform the clock rate to years (original log file has mut rate in days)
burnedclockRate_years = (burnedclockrate_days * 365)
head(clockRateYears, n=25)
hist(burnedclockRate_years, breaks = 50, col = "blue")

#Get the mean and the standard deviation for the clock rate (in years)
summary(burnedclockRate_years)
sd(burnedclockRate_years)

#check that summary stats for the clock rate in days gives same estimates as Tracer
#TRACER STATS: mean = 1.25E-5, SD= 1.785E-6
#Looks good :)
summary(burnedclockrate_days)
sd(burnedclockrate_days)

