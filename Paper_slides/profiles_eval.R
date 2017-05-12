inputs <- list.files("Data/Profiles_evaluation", pattern="HeroX", full=T)
dat <-  read.csv(tail(inputs, 1))
description <- dat[1, ]
dat <- dat[-c(1,2), ]
index <- which(colnames(dat)=='Q38') + 1
x <- dat[, index:ncol(dat)]

lv <- c("Strongly agree", "Agree", "Somewhat agree", "Neither agree nor disagree", "Somewhat disagree", "Disagree", "Strongly disagree")
for (i in 1:ncol(x)) {
	x[, i] <- factor(x[, i], levels=lv)
}

out <- rep()
for (i in 1:ncol(x)) {
	y <- cbind(id=colnames(x)[i], rating=x[, i])
	out <- rbind(out, y)
}
tab <- table(data.frame(out))
index <- apply(tab, 1, FUN=function(x) x %*% 1:6 / sum(x))
tab <- tab[order(index, decreasing=FALSE), ]

get.name <- function(x) gsub("Name: ([^\n]+)\n.*","\\1", x)
names_l <- sapply(description, get.name)

out <- cbind(names_l[match(rownames(tab), names(names_l))], tab)
write.csv(out, file="Data/Profiles_evaluation/profiles_eval.csv", quote=F)
