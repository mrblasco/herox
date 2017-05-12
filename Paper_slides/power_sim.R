#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
#																		 #
#	Identification and power simulations for gender imbalance experiment #
#	Andrea Blasco (ablasco@fas.harvard.edu)								 # 
# 																		 #
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

# Description of the experiment 
# 	N subjects assigned to one of G groups
# 	Simple case each group g features a "role model" with fixed characteristics 
# 	(gender, ethnicity, etc.)

# Theoretical background
# 	Using xxx definition, role models have three characteristics.
# 		i) succesful ii) similar iii) xxxx.

# Empirical implications: 
# a) Succesfull role model should impact participation vs regular participants
# b) Interactions with gender, ethnicity similarity
# c) Images vs no-images to control for "relevance" of our intervention

# Identification problem

# FACT 1: Gender effects of subjects are not identified in general.
# Imagine the propensity to participate is x1 <- rchisq(n, df=2) which is unobserved
# Participation is rnorm(n, mean= a + x1*b + gender) AND gender = rbinom(n, 1, prob=x1)
# Then, the ols estimate "bhat" is biased and inconsistent

# FACT 2: For the same reason, also gender effects 
# of the profiles are not identified in general!!!!

# Identification strategy
# Interactions are correctly identified (need to control for fixed effects)

set.seed(1)
a <- 0.25
b <- 0.33
st_dev <- 1.5

# Baseline
n <- 1000 		# Number of experimental units
x1 <- rchisq(n, df=2)
male <- rbinom(n, 1, prob=0.70)
y <- rnorm(n, mean=a + x1 * b, sd=st_dev)

# Treatment
np <- 16 	# Number of profiles
male_p <- ifelse((1:np)%%2==1, 1, 0)
assignment <- sample(np, n, replace=T)
male_p.assigned <- male_p[assignment] # 50% male 50% Female
z1 <- rnorm(np, sd=0.1) ## Small fixed effects
fe_p <- z1[assignment]

samesex <- ifelse(male_p.assigned==male, 1, 0)

# Simulate case with uncorrelated gender and no fixed effects
replicate(1000, {
	y <- rnorm(n, mean=a + x1*b + fe_p + 0.25*samesex, sd=st_dev)
	coef(lm(y ~ samesex + factor(assignment))) # X1 is not observed
}) -> sim

## Add fixed effects
boxplot(t(sim))
abline(h=0, col=2)
points(1:2, c(a, 0.25), pch=16)

# Problem is when gender is correlated with x1
male2 <- rbinom(n, 1, prob=pnorm(0.5*x1))
samesex2 <- ifelse(male_p.assigned==male2, 1, 0)

# Simulate case with uncorrelated gender and no fixed effects
replicate(1000, {
	y <- rnorm(n, mean=a + x1*b + fe_p + 0.25*samesex2, sd=st_dev)
	coef(lm(y ~ samesex2 + factor(assignment))) # missing x1
}) -> sim

## Add fixed effects
boxplot(t(sim))
abline(h=0, col=2)
points(1:2, c(a, 0.25), pch=16)





