getwd()
setwd("/Users/alliblk/Desktop/Git_Repo_Folders/roka/beast/timeYears")

#Remember to remove title line from tsv file manually before 
#loading the data into R.
rokaHIV = read.table("roka_env_strict_bs10YEARS_skyline.tsv", header=T)
head(rokaHIV)

########TRANSLATE DATES INTO TYPICAL CALENDAR FORMAT
#0.0 DATE in DECIMAL DATE = 2015.0739726027398
install.packages("lubridate")
library(lubridate)

length(rokaHIV$Time) # vector is 100 long

#intialize a new vector of length 100, and fill it with the base decimal date
BaseDateVector = rep(2015.0739726027398, 100) #base number from BEAST
DecimalDates = (BaseDateVector - rokaHIV$Time) #decimal dates back in time
DecimalDates #take a look to make sure everything looks alright

CalendarDates = format(date_decimal(DecimalDates), "%d-%m-%Y") #convert to calendar dates
CalendarDates #again, take a look.

#Add calendar dates to the rokaHIV dataframe
rokaCalendar = data.frame(rokaHIV,CalendarDates)
rokaCalendar

#######PLOTTING
#set up plotting panels
par(mfrow=c(1,1))

#Skyline plot, NOTE CAN'T USE DATES, STILL NEED TO USE THE TIME VARIABLE!!
plot(rokaCalendar$Median ~rokaCalendar$Time, type="l",  
     log="y", #note log 0 is -inf, so need a value
     col="black", 
     xlim = c(3.25,0),
     xaxt = "n", #plot without x axis
     ylim = c(0.1, 1000),
     ylab = expression(paste(italic("N"[e]),tau," ","(years)")),
     xlab= "Date (DD-MM-YYYY)",
     main = "Roka HIV Outbreak",
     lwd=6)

#to plot the axis with calendar ticks, I just looked at the the data frame and 
#matched different values of Time variable with the same values of CalendarDates
#did this just by looking at the data with command rokaCalendar
axis(1, at=(0), labels = CalendarDates[1])
axis(1, at=(1.60102463), labels = CalendarDates[50])
axis(1, at=(3.23472324), labels = CalendarDates[100])

#the line above will be covered by the polygon
#however this allows me to get the plot area, axes, labels
#etc that I want to have on the plot.

#make the polygon border vectors
roka_X = c(rokaHIV$Time, rev(rokaHIV$Time))
roka_Y = c(rokaHIV$Lower,rev(rokaHIV$Upper))

#plot the polygon
polygon(roka_X, roka_Y, border=NA, col="light blue")

#plot the skyline lines over top of the polygon
lines(rokaHIV$Median ~rokaHIV$Time, type="l", 
      lwd=4, col="black")


