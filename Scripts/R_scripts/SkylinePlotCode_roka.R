getwd()
setwd("")

### READ IN DATA FILES (exported from BEAST, remember to delete FIRST line in file (Beast exports with text above headers))
rokaHIV = read.table("roka_env_SkyGrid.tsv", header=T)
rokaHIV
length(rokaHIV$Time)

rokaConstantExpon = read.table("roka_env_ConstantExpon.tsv", header=T)
head(rokaConstantExpon)
length(rokaConstantExpon$Time)

rokaExpon = read.table("roka_env_Exponential.tsv", header=T)
head(rokaExpon)
length(rokaExpon$Time)

########TRANSLATE DATES INTO TYPICAL CALENDAR FORMAT
#0.0 DATE in DECIMAL DATE = 2015.0739726027398
install.packages("lubridate")
library(lubridate)

####For SKYGRID
BaseDateVector = rep(2015.0739726027398, 64) #base number from BEAST
DecimalDates = (BaseDateVector - rokaHIV$Time) #decimal dates back in time
DecimalDates #take a look to make sure everything looks alright

CalendarDates = format(date_decimal(DecimalDates), "%Y") #convert to calendar dates
CalendarDates #again, take a look. Most recent date should match with height 0 tip in Beauti (yes!)

#Add calendar dates to the rokaHIV dataframe
rokaCalendar = data.frame(rokaHIV,CalendarDates)
rokaCalendar

####For EXPONENTIAL
BaseDateVector2 = rep(2015.0739726027398, 100) #base number from BEAST
DecimalDates2 = (BaseDateVector2 - rokaExpon$Time) #decimal dates back in time
DecimalDates2 #take a look to make sure everything looks alright

CalendarDates2 = format(date_decimal(DecimalDates2), "%Y") #convert to calendar dates
CalendarDates2 #again, take a look. Most recent date should match with height 0 tip in Beauti (yes!)

#Add calendar dates to the rokaHIV dataframe
rokaCalendar2 = data.frame(rokaExpon,CalendarDates2)
rokaCalendar2

####For CONSTANT + EXPONENTIAL
BaseDateVector3 = rep(2015.0739726027398, 99) #base number from BEAST
DecimalDates3 = (BaseDateVector3 - rokaConstantExpon$Time) #decimal dates back in time
length(DecimalDates3) #take a look to make sure everything looks alright

CalendarDates3 = format(date_decimal(DecimalDates3), "%Y") #convert to calendar dates
length(CalendarDates3) #again, take a look. Most recent date should match with height 0 tip in Beauti (yes!)

#Add calendar dates to the rokaHIV dataframe
rokaCalendar3 = data.frame(rokaConstantExpon,CalendarDates3)
rokaCalendar3

#make the polygon border vectors FOR SKYLINE
roka_X = c(rokaHIV$Time, rev(rokaHIV$Time))
roka_Y = c(rokaHIV$Lower,rev(rokaHIV$Upper))

#make the polygon border vectors FOR EXPONENTIAL
roka_Expon_X = c(rokaExpon$Time, rev(rokaExpon$Time))
roka_Expon_Y = c(rokaExpon$Lower,rev(rokaExpon$Upper))

#make polygon vectors for CONSTANT + EXPONENTIAL
roka_ConstantExpon_X = c(rokaConstantExpon$Time, rev(rokaConstantExpon$Time))
roka_ConstantExpon_Y = c(rokaConstantExpon$Lower,rev(rokaConstantExpon$Upper))


#################################
#################################
#### PLOTTING OVERLAY ####
#################################
#################################


#define colors
colorGRID=rgb(0.15,0.41,0.6, alpha=0.4) # BLUE
colorCONS=rgb(0.95,0.6,0.1, alpha=0.4) # RED
colorEXPON=rgb(0.9,0.3,0.5, alpha=0.4) # Pink

#color3=rgb(0.55,0.77,0.3, alpha=0.3) # GREEN

colorGRIDstrong=rgb(0.15,0.41,0.6, alpha=0.6) # BLUE
colorCONSstrong=rgb(0.95,0.6,0.1, alpha=0.6) # RED
colorEXPONstrong=rgb(0.9,0.3,0.5, alpha=0.6) # Pink



par(mfrow=c(1,1))
par(fig=c(0.03,1,0,1))

#Plot Skyline first with all the appropriate axes and labeling etc.
plot(rokaCalendar$Median ~rokaCalendar$Time, type="l",  
     log="y", #note log 0 is -inf, so need a value
     col="black", 
     xlim = c(4.25,0.135),
     xaxt = "n", #plot without x axis
     yaxt = 'n',
     ylim = c(0.0000007, 450000),
     bty="l",
     cex.axis = 0.7,
     cex.lab = 1,
     ylab = expression(paste(italic("N"[e]),tau," ","(years)")),
     xlab= "Year",
     #main = "Roka HIV Outbreak",
     lwd=2)

axis(1, at=(0), labels = CalendarDates[1], cex.axis=0.7)
axis(1, at=(0.9183673), labels = CalendarDates[10], cex.axis=0.7)
axis(1, at=(1.9387755), labels = CalendarDates[20], cex.axis=0.7)
axis(1, at=(2.9591837), labels = CalendarDates[30], cex.axis=0.7)
axis(1, at=(3.9795918), labels = CalendarDates[40], cex.axis=0.7)
axis(1, at=(5.0000000), labels = CalendarDates[50], cex.axis=0.7)
axis(1, at=(5.9183673), labels = CalendarDates[60], cex.axis=0.7)

axis(2, at=(0.000001), labels = "0.000001", cex.axis=0.7, las=2)
axis(2, at=(0.0001), labels = "0.0001", cex.axis=0.7, las=2)
axis(2, at=(0.01), labels = "0.01", cex.axis=0.7, las=2)
axis(2, at=(1), labels = "1.0", cex.axis=0.7, las=2)
axis(2, at=(100), labels = "100", cex.axis=0.7, las=2)
axis(2, at=(10000), labels = "10000", cex.axis=0.7, las=2)
axis(2, at=(1000000), labels = "1000000", cex.axis=0.7, las=2)


#Plot both polygons
polygon(roka_X, roka_Y, border=NA, col=colorGRID)
polygon(roka_Expon_X, roka_Expon_Y, border=NA, col=colorEXPON)
polygon(roka_ConstantExpon_X, roka_ConstantExpon_Y, border=NA, col=colorCONS)

#plot both of the median lines
lines(rokaHIV$Median ~rokaHIV$Time, lty=1, lwd=3, col="black", add=T)
lines(rokaExpon$Median ~rokaExpon$Time, lty=4, lwd=2, col="black", add=T)
lines(rokaConstantExpon$Median ~rokaConstantExpon$Time, lty=4, lwd=2, col="black", add=T)

#add vertical lines at mean values of TMRCA
abline(v=4.1177, lty=2, col=colorGRIDstrong, lwd=2) #TMRCA SkyGrid
abline(v=2.204, lty=2, col=colorCONSstrong, lwd=2) #TMRCA ConstantExponential
abline(v=2.242, lty=2, col=colorEXPONstrong, lwd=2) #TMRCA Exponential

#add legend
#legend('topright', inset=0.02,c("SkyGrid","Constant Exponential"),fill=c(color1,color2),  bty = "n")
legend(x=2.0, y=0.005, inset=0.02,c("SkyGrid","Exponential", "Constant+Exponential"),fill=c(colorGRID,colorEXPONstrong,colorCONSstrong), border=NA,  bty = "n")

#add lines to indicate 95%HPD around TMRCA
rect(6.4193, 300000, 2.2672, 400000, col = colorGRID, border=NA) #95%HPD on SkyGrid TMRCA, numbers from Tracer (log file)
rect(3.18, 700000, 1.34, 1000000, col = colorCONS, border=NA) #95%HPD on Exponential TMRCA
rect(3.26, 450000, 1.38, 630000, col = colorEXPON, border=NA) #95%HPD on Exponential TMRCA
