# Load data
read.csv("Data/HeroX Challenge Data_Daily_10Aug16.csv") -> dat

head(dat)

# 20 challenges
table(dat$challenge)
table(dat$challenge.type)

# 
competitors <- tapply(dat$rolling.comp, dat$challenge, tail, n=1) 
submissions <- tapply(dat$rolling.sub, dat$challenge, tail, n=1) 
unique.views <- tapply(dat$unique.views, dat$challenge, tail, n=1) 
prizes <- tapply(dat$prize, dat$challenge, tail, n=1) 

# # Views and competitors
plot(log(unique.views), log(competitors), bty='n', xaxt="n",yaxt='n')
text(log(unique.views), log(competitors), names(competitors), pos=sample(4, length(competitors), replace=TRUE), xpd=TRUE, col=2)
axis(1, at=log(unique.views), unique.views)
axis(2, at=log(competitors), competitors)
abline(ols <- lm(log(competitors) ~ log(unique.views), subset=competitors>0))
lab <- sprintf("E[comp] = exp(%0.2f + %0.2f * log(views))", coef(ols)[1], coef(ols)[2])
mtext(lab, 3)

# 
# Prizes and views
plot(log(prizes), log(unique.views), bty='n', xaxt="n", yaxt="n")
text(log(prizes), log(unique.views), names(unique.views), pos=sample(4, length(unique.views), replace=TRUE), xpd=TRUE, col=2)
axis(1, at=log(prizes), prizes)
axis(2, at=log(unique.views), unique.views)
abline(ols <- lm(log(unique.views) ~ log(prizes), subset=competitors>0), lwd=2)
lab <- sprintf("E[views] = exp(%0.2f + %0.2f * log(prize))", coef(ols)[1], coef(ols)[2])
legend("top", lty=1, lab, bty="n")




