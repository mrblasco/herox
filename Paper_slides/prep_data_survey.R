rm(list=ls())

# Load data
read.csv(tail(list.files("Data/Survey/", full=T, pattern="HeroX"), 1)) -> dat
read.csv(tail(list.files("Data/Survey/Rescue", full=T, pattern="HeroX"), 1)) -> rescue
col.diff <- setdiff(colnames(dat),colnames(rescue))
for (i in col.diff) rescue[i] <- NA
dat <- rbind(dat, rescue[-c(1:2), ])

questions <- unlist(droplevels(dat[1, ]))
questions.info <- dat[2, ]
survey <- subset(dat[-c(1,2), ], QID3!="")
for (i in 1:ncol(survey)) {
	if(is.factor(survey[, i])) {
		survey[,i] <- droplevels(survey[,i])
	}
}
save(list=c("survey","questions"), file="survey.RData")


##############
# Payments	##
##############
load(".RData")
children <- ifelse(survey$QID3=='<18', 1, 0)
emails <- as.character(survey$Q20)
miss <- emails==''
emails[miss] <- paste(survey$Q24_1[miss], survey$Q24_2[miss])
read.csv("Data/.emails.csv") -> dat
index <- match(tolower(emails), tolower(dat$Email))
last.name <- dat$Last.name[index]
first.name <- herox$First.name[index]
country <- herox$Country[index]
out <- data.frame(emails, first.name, last.name, country, children, missing=ifelse(miss, 1, 0))
write.csv(unique(out), file="Data/Survey/payments.csv", row.names=FALSE)
write.csv(unique(out)[children==0, ], file="Data/Survey/payments_no_children.csv", row.names=FALSE)


