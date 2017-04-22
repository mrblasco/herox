########################################
# Prepare dataset for HeroX project
# Andrea Blasco (ablasco@fas.harvard.edu)
# March 7, 2017
#########################################
rm(list=ls())
source("func_prep_data.R") # genderize functions

# Data files
#input 		<- "../Data/all_users.csv"
input 		<- "Data/HeroX Users_7April2017.csv"
identity 	<- "Data/.emails.csv"
output 		<- ".RData"
 
# Load raw data
raw.df <- read.csv(input, stringsAsFactors=FALSE)
dim(raw.df) # 65,000 x 122

# Define the functions
correct_data <- function(raw.df) {
	nc <- ncol(raw.df)
	nc0 <- which(colnames(raw.df)=='Last.Login') 
	df.challenge <- raw.df[, (nc0+1):nc]
	df <- raw.df[, 1:nc0]
	df$userID <- 1:nrow(df)
	df$First.name <- iconv(enc2utf8(df$First.name),sub="byte")
	df$Gender <- genderize(df$First.name)
	df$Gender2 <- genderize.multi(df$First.name)
	df$Gender[is.na(df$Gender)] <- df$Gender2[is.na(df$Gender)]
	df$Gender <- factor(df$Gender) # 80% identified
	df$Country <- factor(as.character(df$Country), exclude="")
	df$Referer <- factor(gsub("https?://([^/]+)/?.*", "\\1", df$Referer), exclude='')
# 	df$Bio<- iconv(e	nc2utf8(df$Bio), sub="byte")
	df$Bio.nchar <- nchar(df$Bio)
	df$Facebook.yes <- nchar(df$Facebook)>0
	df$Google.yes <- nchar(df$Google.)>0
	df$Twitter.yes <- nchar(df$Twitter)>0
	df$LinkedIn.yes <- nchar(df$LinkedIn)>0
	df$Registration.date <- as.Date(substring(df$Registration.date, 1, 10))
	df$Last.login <- as.Date(substring(df$Last.login, 1, 10))
	df$Newsletter.subscriber <- df$Newsletter.subscriber=='Y'
	df$Num.challenges <- apply(df.challenge, 1, function(x) sum(x==1))
	return(df)
}
consistent_data <- function(df) {
	index <- grepl("@herox.com", df$Email)
	df <- df[!index, ] 
	# Save identifiable information
	identifying <- c("userID","Last.name","Location", "Email", "Bio", "Affiliation"
				, "Facebook", "Google.", "Twitter", "LinkedIn")
	write.csv(df[, identifying], file=identity, row.names=FALSE)	
	df$Gender2 <- NULL	
	# Return de-identified data
	z <- df[, !colnames(df) %in% identifying]
	return(z)
}
prepare_data <- function(raw.df, genderize=FALSE) {
	df <- correct_data(raw.df)
	consistent_data(df)
}

# Do everything 
df <- prepare_data(raw.df)
summary(df)

summary(herox <- df)
save(herox, file=output)

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

# What predicts registration ? 
# sapply(df, function(x) {
# 	if (class(x)=='logical') {
# 		tab <- table(x, Participation=df$Num.challenges>0)
# 		ptab <- prop.table(tab)
# 		return(c(100*ptab[2,2], chisq.test(tab)$stat))
# 	} else {
# 		return(c(NA, NA))
# 	}
# })