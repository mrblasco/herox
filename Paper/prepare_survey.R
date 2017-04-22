# Select sample
set.seed(1)
random <- runif(nrow(herox)) < 0.25 & herox$Num.challenges > 0
subset(herox, !is.na(Gender) & (Total.Visits.last.30.days > 0 | random)) -> dat

# Load emails
read.csv("Data/.emails.csv") -> ids
index <- match(dat$userID, ids$userID)
data.frame(email=ids$Email[index], dat[, c("userID", "First.name", "Gender")]) -> dat2

# Save files
write.csv(dat2, file="Data/emails_invited_survey.csv", row.names=FALSE)