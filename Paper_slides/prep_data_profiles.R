rm(list=ls())

# Load profiles data from Qualtrics
input <- list.files("Data/Profiles", full=T, pattern="HeroX")
read.csv(tail(input, 1), stringsAsFactors=FALSE) -> dat
questions <- unlist(droplevels(dat[1, ]))
questions.info <- dat[2, ]
dat <- subset(dat, Finished=='True')

# Extra data
graphics <- read.csv("Data/Profiles/qualtrics_pictures_urls.txt", strings=FALSE)
choices.attr <- c("Extremely attractive", "Moderately attractive", "Slightly attractive", "Neither attractive nor unattractive", "Slightly unattractive", "Moderately unattractive", "Extremely unattractive")
choices.rm <- c("Strongly agree", "Agree", "Somewhat agree", "Neither agree nor disagree", "Somewhat disagree", "Disagree", "Strongly disagree")

# Master dataset
input <- list.files("Data", full=T, pattern="Users")
read.csv(tail(input, 1), stringsAsFactors=FALSE) -> users
emails <- users$Email
bio <- users$Bio
last.col <- which(colnames(users)=='Last.Login')

# Print
print.profile <- function(x) {
	cat("\n\n[[Question:MC:SingleAnswer:Vertical]]\n")

	# Match picture with urls
	index <- grep(x[9], graphics$picture)
	if (length(index)==1)
	 	cat(sprintf("<img src=\"%s\"><br>\n", graphics$url[index]))
	# Match name by email with master
 	index <- which(tolower(emails)==tolower(as.character(x[17])))
	cat(sprintf("Name: %s<br>", users$First.name[index]))
	# AWARDS
	if (length(index)>0) {
		y <- t(users[index, (last.col+1):ncol(users)])
		rows <- which(y!="N")
		won <- sum(y=="4")
		subm <- sum(y=="3") + won
		cat(sprintf("<h4>Awards</h4>\n<p>%s awards received (out of %s competitions with submissions)</p>\n", won, subm))
		sapply(rows, function(x) { 
			if(y[x]=='4') cat("<p>Won an award in "
							, rownames(y)[x],"</p>\n")
			if(y[x]=='3') cat("<p>Participated with submissions in ", rownames(y)[x],"</p>\n")})
	}
	cat(sprintf("<h4>Motivations to be on HeroX</h4>\n%s<br>\n", x[22]))
	if (x[23]=='') x[23] <- bio[index]
	cat(sprintf("<h4>Short Bio</h4>\n%s<br>\n", x[23]))
# 	cat("\n[[Choices]]\n")
# 	for (x in choices) cat(x, sep='\n')
# 	cat("\n\n[[Question:MC:SingleAnswer:Vertical]]\n")	
	cat("<hr>")
	cat("<h4>Do you agree or disagree on the following: 'This profile can be viewed as a role model for other members of HeroX'</h4>")
	cat("\n[[Choices]]\n")
	for (x in choices.rm) cat(x, sep='\n')
}

index <-  match(tolower(as.character(dat$Q11_1)), tolower(emails))
x <- cbind(users[index, c("First.name", "Last.name")], email=dat$Q11_1, Motives=dat$Q3, Bio=dat$Q4)
write.csv(x, file="~/Desktop/recruited_profiles.csv", row.names=FALSE)

# Print all profiles
cat("[[AdvancedFormat]]\n\n")
apply(dat, 1, print.profile) -> x
