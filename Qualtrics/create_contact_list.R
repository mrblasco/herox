
output <- "../Data/contacts_qualtrics_survey.csv"
emails <- "../Data/.emails.csv"
input <- "../.RData"

# Load data
load(input)

# Select sample
df1 <- subset(df, !is.na(Gender) & Total.Visits.last.30.days>0) 
df1 <- df1[sample(nrow(df1)), ] # Order at random
index <- tapply(1:nrow(df1), df1$Gender, head, n=500)
out <- df1[c(index$male, index$female), c("userID", "Gender", "First.name")]

# Match with emails
read.csv(emails) -> contacts
i <- match(out$userID, contacts$userID)

# Output
data.frame(out, Email=contacts$Email[i]) -> final
write.csv(final, file=output, row.names=FALSE)

