rm(list=ls())

# Load data
read.csv(tail(list.files("Data/Profiles", full=T),1)) -> dat
questions <- unlist(droplevels(dat[1, ]))
questions.info <- dat[2, ]
profiles <- dat[-c(1,2), ]
for (i in 1:ncol(profiles)) {
	if(is.factor(profiles[, i])) {
		profiles[,i] <- droplevels(profiles[,i])
	}
}
save(list=c("profiles","questions"), file="profiles.RData")
##############################