library(MatchIt)

dat <- subset(df, !is.na(Gender) & !is.na(Country))
dat <- dat[, c("Gender", "Country", "Newsletter.subscriber","Total.Visits")]

# Match based on Country and Newsletter subscriber
m.out <- matchit(Gender=='male' ~ Country + Newsletter.subscriber, data=dat, method="exact")

m.data <- match.data(m.out)

table(dat)