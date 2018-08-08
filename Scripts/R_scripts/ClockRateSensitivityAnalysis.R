getwd()
setwd("/Users/alliblk/Desktop/gitrepos/roka/HIV/bayesian_skyline")

### READ IN DATA FILES (exported from BEAST, remember to delete FIRST line in file (Beast exports with text above headers))
exponHalfClock = read.table("roka_env_exponential_halfClockRate_skyline.tsv", header=T)
exponHalfClock
length(exponHalfClock$Time)

exponDoubleClock = read.table("roka_env_exponential_doubleClockRate_skyline.tsv", header=T)
head(exponDoubleClock)
length(exponDoubleClock$Time)

rokaExpon = read.table("roka_env_Exponential.tsv", header=T)
head(rokaExpon)
length(rokaExpon$Time)

########TRANSLATE DATES INTO TYPICAL CALENDAR FORMAT
#0.0 DATE in DECIMAL DATE = 2015.0739726027398
install.packages("lubridate")
library(lubridate)

####For Normal Exponential
BaseDateVector = rep(2015.0739726027398, 100) #base number from BEAST
DecimalDates = (BaseDateVector - rokaExpon$Time) #decimal dates back in time
DecimalDates #take a look to make sure everything looks alright

CalendarDates = format(date_decimal(DecimalDates), "%Y") #convert to calendar dates
CalendarDates #again, take a look. Most recent date should match with height 0 tip in Beauti (yes!)

#Add calendar dates to the rokaHIV dataframe
rokaCalendar = data.frame(rokaExpon,CalendarDates)
rokaCalendar

####For half clock rate exponential
BaseDateVector2 = rep(2015.0739726027398, 100) #base number from BEAST
DecimalDates2 = (BaseDateVector2 - exponHalfClock$Time) #decimal dates back in time
DecimalDates2 #take a look to make sure everything looks alright

CalendarDates2 = format(date_decimal(DecimalDates2), "%Y") #convert to calendar dates
CalendarDates2 #again, take a look. Most recent date should match with height 0 tip in Beauti (yes!)

rokaCalendar2 = data.frame(exponHalfClock,CalendarDates2)
rokaCalendar2

####For double clock exponential
BaseDateVector3 = rep(2015.0739726027398, 99) #base number from BEAST
DecimalDates3 = (BaseDateVector3 - exponDoubleClock$Time) #decimal dates back in time
length(DecimalDates3) #take a look to make sure everything looks alright

CalendarDates3 = format(date_decimal(DecimalDates3), "%Y") #convert to calendar dates
length(CalendarDates3) #again, take a look. Most recent date should match with height 0 tip in Beauti (yes!)

rokaCalendar3 = data.frame(exponDoubleClock,CalendarDates3)
rokaCalendar3

#make the polygon border vectors FOR NORMAL EXPONENTIAL
roka_Expon_X = c(rokaExpon$Time, rev(rokaExpon$Time))
roka_Expon_Y = c(rokaExpon$Lower,rev(rokaExpon$Upper))

#make the polygon border vectors for half clockrate exponential
roka_half_X = c(exponHalfClock$Time, rev(exponHalfClock$Time))
roka_half_Y = c(exponHalfClock$Lower,rev(exponHalfClock$Upper))

#make polygon vectors for double clockrate exponential
roka_double_X = c(exponDoubleClock$Time, rev(exponDoubleClock$Time))
roka_double_Y = c(exponDoubleClock$Lower,rev(exponDoubleClock$Upper))


#################################
#################################
#### PLOTTING OVERLAY ####
#################################
#################################


#define colors
colorNORMAL=rgb(0.15,0.41,0.6, alpha=0.4) # BLUE
colorHALF=rgb(0.95,0.6,0.1, alpha=0.4) # RED
colorDOUBLE=rgb(0.9,0.3,0.5, alpha=0.4) # Pink

#color3=rgb(0.55,0.77,0.3, alpha=0.3) # GREEN

colorNORMALstrong=rgb(0.15,0.41,0.6, alpha=0.6) # BLUE
colorHALFstrong=rgb(0.95,0.6,0.1, alpha=0.6) # RED
colorDOUBLEstrong=rgb(0.9,0.3,0.5, alpha=0.6) # Pink


par(mfrow=c(1,1))
par(fig=c(0.03,1,0,1))

#Plot Skyline first with all the appropriate axes and labeling etc.
plot(rokaCalendar$Median ~rokaCalendar$Time, type="l",  
     log="y", #note log 0 is -inf, so need a value
     col="black", 
     xlim = c(5,0.1),
     xaxt = "n", #plot without x axis
     yaxt = 'n',
     ylim = c(0.0000007, 4500),
     bty="l",
     cex.axis = 0.7,
     cex.lab = 1,
     ylab = expression(paste(italic("N"[e]),tau," ","(years)")),
     xlab= "Year",
     #main = "Roka HIV Outbreak",
     lwd=2)

axis(1, at=(0), labels = CalendarDates2[1], cex.axis=0.7)
axis(1, at=(0.79586778), labels = CalendarDates2[11], cex.axis=0.7)
axis(1, at=(1.67132233), labels = CalendarDates2[22], cex.axis=0.7)
axis(1, at=(2.54677688), labels = CalendarDates2[33], cex.axis=0.7)
axis(1, at=(3.42223143), labels = CalendarDates2[44], cex.axis=0.7)
axis(1, at=(4.29768599), labels = CalendarDates2[55], cex.axis=0.7)
axis(1, at=(5.17314054), labels = CalendarDates2[66], cex.axis=0.7)
axis(1, at=(6.04859509), labels = CalendarDates2[77], cex.axis=0.7)
axis(1, at=(6.92404965), labels = CalendarDates2[88], cex.axis=0.7)
axis(1, at=(7.79950420), labels = CalendarDates2[99], cex.axis=0.7)

axis(2, at=(0.0000000001), labels = "0.0000000001", cex.axis=0.7, las=2)
axis(2, at=(0.00000001), labels = "0.00000001", cex.axis=0.7, las=2)
axis(2, at=(0.000001), labels = "0.000001", cex.axis=0.7, las=2)
axis(2, at=(0.0001), labels = "0.0001", cex.axis=0.7, las=2)
axis(2, at=(0.01), labels = "0.01", cex.axis=0.7, las=2)
axis(2, at=(1), labels = "1.0", cex.axis=0.7, las=2)
axis(2, at=(100), labels = "100", cex.axis=0.7, las=2)
axis(2, at=(10000), labels = "10000", cex.axis=0.7, las=2)
axis(2, at=(1000000), labels = "1000000", cex.axis=0.7, las=2)


#Plot both polygons
polygon(roka_Expon_X, roka_Expon_Y, border=NA, col=colorNORMAL)
polygon(roka_half_X, roka_half_Y, border=NA, col=colorHALF)
polygon(roka_double_X, roka_double_Y, border=NA, col=colorDOUBLE)

#plot both of the median lines
lines(rokaExpon$Median ~rokaExpon$Time, lty=4, lwd=2, col="black", add=T)
lines(exponHalfClock$Median ~exponHalfClock$Time, lty=4, lwd=3, col="black", add=T)
lines(exponDoubleClock$Median ~exponDoubleClock$Time, lty=3, lwd=2, col="black", add=T)

#add vertical lines at mean values of TMRCA
abline(v=2.204, lty=2, col=colorNORMALstrong, lwd=2) #TMRCA Normal Exponential
abline(v=4.449, lty=2, col=colorHALFstrong, lwd=2) #TMRCA half clock exponential
abline(v=1.207, lty=2, col=colorDOUBLEstrong, lwd=2) #TMRCA double clock exponential

#add legend
#legend('topright', inset=0.02,c("SkyGrid","Constant Exponential"),fill=c(color1,color2),  bty = "n")
legend(x=1.1, y=0.0001, inset=0.02,c("0.5x Clock Rate","1x Clock Rate", "2x Clock Rate"),
       fill=c(colorHALFstrong,colorNORMAL,colorDOUBLEstrong),
       border=NA, cex=0.8, bty = "n")

#add growth rate annotations
text(x=3.8, y=0.5, labels=expression(paste(italic("r"),'= 2.1 [0.55 - 3.5]')), cex=0.7, pos=3)
text(x=2.8, y=0.0003, labels=expression(paste(italic("r"),'= 3.9 [2.1 - 6.4]')), cex=0.7, pos=3)
text(x=0.75, y=0.005, labels=expression(paste(italic("r"),'= 7.2 [3.7 - 11.0]')), cex=0.7, pos=3)
text(x=3., y=500, labels='tMRCAs', cex=0.7, pos=3)


#add lines to indicate 95%HPD around TMRCA
rect(1.6148, 1200, 0.8085, 2000, col = colorDOUBLE, border=NA) #95%HPD 
rect(7.8791, 5000, 1.9286, 8000, col = colorHALF, border=NA) #95%HPD 
rect(3.26, 2500, 1.38, 4000, col = colorNORMAL, border=NA) #95%HPD 
