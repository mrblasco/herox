######################################################################
#
#	Power simulations for gender imbalance
#	Andrea Blasco (ablasco@fas.harvard.edu)
# 
# sim(n) simulates data from binomial 
#	distribution (n size of each group)
# simulate.power() calls sim() many times 
#	and compute power for given effect size & alpha
######################################################################

sim <- function(n, p.control, p.treat) {
  treat <- rbinom(n, 1, p.treat)
  contr <- rbinom(n, 1, p.control)
  d <- data.frame(y=c(contr, treat), Treated=c(rep(0, n), rep(1, n)))
  return(d)
}

simulate.power <- function(x, alpha=0.05, num.rep=1e2) {
	n <- seq(100, 1000, l=10)
	h <- seq(0.01, 0.10, l=10)
	p <- matrix(nrow=10,ncol=10)
	rownames(p) <- n
	colnames(p) <- h
	for (j in 1:10) {
		for (i in 1:10) {
			pval <- replicate(num.rep, 
				chisq.test(table(sim(n[i], h[j], h[j]+x)) + 1)$p.val)
			p[i, j] <- mean(pval < alpha)
		} 
	}
	return (list(power.mat=p, effect.size=x, alpha=0.05))
}


# Figure
# par(mfrow=c(2,2))
# effect.size <- seq(0.01, 0.04, l=4)
# n <- seq(100, 1000, l=10)
# h <- seq(0.01, 0.10, l=10)
# for (i in effect.size) {
# 	p <- simulate.power(i)$power.mat
# 	plot(NA, NA, xlim=c(50, 1000), ylim=c(0, 1), type='b', bty='n'
# 		, ylab="Power (alpha=0.05)", xlab="Observations per group"
# 		, main=sprintf("True effect size: %f",i))
# 	apply(p, 2, function(x) lines(n, x, col=2))
# 	abline(h=0.8, lty=2)
# 	text(x=n, y=diag(p), h)
# }
