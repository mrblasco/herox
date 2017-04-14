# outreach 

# Do you have what it takes?
read.csv("Data/iContact/CompareMessage_kyla.csv") -> dat
table(dat$Subject)
sort(dat$Opened)


# 
read.csv("Data/iContact/CompareMessage_maureen1.csv") -> dat1
read.csv("Data/iContact/CompareMessage_maureen2.csv") -> dat2
read.csv("Data/iContact/CompareMessage_maureen3.csv") -> dat3
rbind(dat1, dat2, dat3) -> dat

attach(dat)

levels(Subject) # Subject

x <- as.Date(Date, fo="%B %d, %Y")
x[is.na(x)] <- as.Date(Date[is.na(x)])
date <- x

# Statistics
par(mfrow=c(1, 3))
hist(Contacts_Sent_To, "Scott")
plot(date, Opened, cex=Contacts_Sent_To/1e4)
ols <- lm(Opened ~ 1, weights=Contacts_Sent_To)
mtext(sprintf("Mean=%0.2f%s", coef(ols),"%"), 3)
plot(date, Clicks, cex=Contacts_Sent_To/1e4)
ols <- lm(Clicks ~ 1, weights=Contacts_Sent_To)
mtext(sprintf("Mean=%0.2f%s", coef(ols), "%"), 3)


# By the day of the week
days.of.week <- weekdays(x=as.Date(seq(7), origin="1950-01-01"))
wdays <- factor(weekdays(date), levels=days.of.week)
ols <- lm(Opened ~ wdays, weights=Contacts_Sent_To)
summary(ols)
ols <- lm(Clicks ~ wdays, weights=Contacts_Sent_To)
summary(ols)



