########################################
# Prepare dataset for HeroX project
# Andrea Blasco (ablasco@fas.harvard.edu)
# March 7, 2017
#########################################
rm(list=ls())

# Data files
# input <- "../Data/HeroX Users_15March2017.csv"
#input 		<- "../Data/all_users.csv"
input 		<- "../Data/HeroX Users_7April2017.csv"
identity 	<- "../Data/.emails.csv"
output 		<- "herox.RData"

# Load data
raw.df <- read.csv(input, stringsAsFactors=FALSE)

# Functions to match name and gender
source("0_gender_func.R")

# Define the functions
correct_data <- function(raw.df) {
	df.challenge <- raw.df[, 17:ncol(raw.df)]
	df <- raw.df[, 1:17]
# 	df <- raw.df[, 1:24]
	df$userID <- 1:nrow(df)
	df$First.name<- iconv(enc2utf8(df$First.name),sub="byte")
	df$Gender <- genderize(df$First.name)
	df$Gender2 <- genderize.multi(df$First.name)
	df$Gender[is.na(df$Gender)] <- df$Gender2[is.na(df$Gender)]
	df$Gender <- factor(df$Gender)
	df$Country <- factor(as.character(df$Country), exclude="")
	df$Referer <- factor(gsub("https?://([^/]+)/?.*", "\\1", df$Referer), exclude='')
# 	df$Bio<- iconv(e	nc2utf8(df$Bio), sub="byte")
	df$Bio.nchar <- nchar(df$Bio)
	df$Facebook.yes <- nchar(df$Facebook)>0
	df$Google.yes <- nchar(df$Google)>0
	df$Twitter.yes <- nchar(df$Twitter)>0
	df$LinkedIn.yes <- nchar(df$LinkedIn)>0
	df$Registration.date <- as.Date(substring(df$Registration.date, 1, 10))
	df$Last.login <- as.Date(substring(df$Last.login, 1, 10))
	df$Newsletter.subscriber <- df$Newsletter.subscriber=='Y'
	df$Num.challenges <- apply(df.challenge, 1, function(x) sum(x=='Y'))
	return(df)
}

consistent_data <- function(df) {

	# Drop HeroX staff
	index <- grepl("@herox.com", df$Email)
	df <- df[!index, ] 
	# Drop temp vars
	df$Gender2 <- NULL
	
	# Save identifiable information
	write.csv(df[, c("userID", "Email")], file=identity, row.names=FALSE)
	
	# De-identify data
	df$Last.name <- NULL
	df$Location <- NULL
	df$Email <- NULL 
	df$Bio <- NULL
	df$Affiliation <- NULL
	df$Facebook <- NULL
	df$Google. <- NULL
	df$Twitter <- NULL
	df$LinkedIn <- NULL
	return(df)
}
prepare_data <- function(raw.df, genderize=FALSE) {
	df <- correct_data(raw.df)
	consistent_data(df)
}

# Do everything 
df <- prepare_data(raw.df)
summary(df)

# What predicts registration ? 
sapply(df, function(x) {
	if (class(x)=='logical') {
		tab <- table(x, Participation=df$Num.challenges>0)
		ptab <- prop.table(tab)
		return(c(100*ptab[2,2], chisq.test(tab)$stat))
	} else {
		return(c(NA, NA))
	}
})
save(df, file=output)

# PLOT Gender imbalance!
# par(mar=c(4,4,1,1))
# df$male <- df$Gender=="male"
# tab <- table(ifelse(df$Num.challenges>0,"participating", "not participating"), ifelse(df$male,"male","female"))
# barplot(prop.table(tab, 2), beside=T, legend=T, ylim=c(0, 0.8))
# 
# 
#  [1] "First.name"                            
#  [2] "Last.name"                             
#  [3] "Location"                              
#  [4] "Country"                               
#  [5] "Email"                                 
#  [6] "Referer"                               
#  [7] "Bio"                                   
#  [8] "Facebook"                              
#  [9] "Twitter"                               
# [10] "Google."                               
# [11] "LinkedIn"                              
# [12] "Skills"                                
# [13] "Registration.date"                     
# [14] "Last.login"                            
# [15] "Newsletter.subscriber"                 
# [16] "Total.Visits"                          
# [17] "Total.Visits.last.30.days" 
# 
