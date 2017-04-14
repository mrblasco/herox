require(gender)

# Clean names
clean.names <- function(x) {
	trim <- function (x) gsub("^\\s+|\\s+$", "", x)
	rm.spaces <- function(x) gsub("\\s+"," ", x)
	rm.email <- function(x) gsub("@.*", "", x)
	rm.accent <- function(x) {
		x <- gsub("[éèêēėęễếë]", "e", x)
		x <- gsub("[àáâäæãåāầ]", "a", x)
		x <- gsub("[îïíīįì]", "i", x)
		x <- gsub("[ôöòóœøōõ]", "o", x)
		x <- gsub("[ûüùúū]", "u", x)
		x <- gsub("[ćçč]", "c", x)
		x <- gsub("[ğ]", "g", x)
		x <- gsub("[ł]", "l", x)
		x <- gsub("[ÿ]", "y", x)
		x <- gsub("[ßśš]", "s", x)
		x <- gsub("[ñń]", "n", x)
		return(x)
	} 
	x.lower <- tolower(rm.email(x))
	x.accent <- rm.accent(x.lower)
	x.cleaned <- trim(rm.spaces(gsub("[._/-]"," ", x.accent)))
	return(x.cleaned)
}
genderize <- function(x, ...) {
	x.cleaned <- clean.names(x)
	g <- gender(x.cleaned, ...) # US Social Security Administration
	index <- match(x.cleaned, g$name)
	return(g$gender[index])
}

# More than one name
genderize.multi <- function(x, ...) {
	x.cleaned <- clean.names(x)
	x.multi <- x.cleaned[grep(" ", x.cleaned)]
	l <- strsplit(x.multi, " ")
	ids <- unlist(sapply(1:length(l), function(x) rep(x, length(l[[x]]))))
	allnames <- unlist(l)
	g <- gender(allnames)
	index <- match(allnames, g$name)
	d <- data.frame(ids, allnames, p=g$proportion_male[index])
	tapply(d$p, d$ids, function(x) {
		index <- (x > 0) & (x < 1) & !is.na(x)
		x[index] <- 1.15*x[index]
		# Logic: give higher weights to more accurate estimates
		# mean(c( (1+w)*0.98, 0)) > 0.5
		ifelse(median(x, na.rm=TRUE)>0.5, "male", "female")
	}) -> gender.multi
	index <- match(x.cleaned, x.multi)
	return(as.character(gender.multi)[index])
}

# Compute and update
# dat$Gender <- genderize(allnames)
# dat$Gender2 <- genderize.multi(dat$First.name)
# dat$Gender[is.na(dat$Gender)] <- dat$Gender2[is.na(dat$Gender)]

# PLOT Percent women by country
# g <- tapply(dat$Gender=="female", dat$Country, mean, na.rm=TRUE)
# n <- tapply(dat$Gender, dat$Country, length)
# top.countries <- names(tail(sort(n), 10))
# 
# par(mar=c(1,4,1,1))
# plot(g, cex=n/1e3, bty="n", ann=FALSE, xaxt="n")
# for (i in 1:length(top.countries)) {
# 	x <- which(names(g)==top.countries[i])
# 	text(y=g[x], x=x, top.countries[i], xpd=TRUE, pos=1, col=i)
# 	points(y=g[x], x=x, col=i, cex=n[x]/1e3)
# }
# abline(h=mean(dat$Gender=="female", na.rm=TRUE), lty=2)
# mtext("Percentage women", 2, 3)
# message <- sprintf("Women (%i) Men (%i) Missing (%i) "
# 	, sum(dat$Gender=="female", na.rm=T)
# 	, sum(dat$Gender=='male', na.rm=T)
# 	, sum(is.na(dat$Gender)) 
# )
# mtext(message, 3, 0)

# 
# genderize.stats <- function(x, g) {
# 	n <- length(x)
# 	arabic.names <- x[grep("[\u0627-\u06FF]+", x)]
# 	chinese.names <- x[grep("[\u4E00-\u9FFF]+", x)]
# 	numeric.names <- x[grep("[0-9]", x)]
# 	multi.names <- x[grep(" ", x)]
# 	alpha.names <- x[grep("[^a-zA-Z0-9 ]", x)]
# 	m0 <- sprintf("Matched %i percent from US SSA", percent(mean(!is.na(g))))
# 	m1 <- sprintf("Numeric %0.3f", length(numeric.names)/n)
# 	m2 <- sprintf("Chinese %0.3f", length(chinese.names)/n)
# 	m3 <- sprintf("Arabic %0.3f", length(arabic.names)/n)
# 	m4 <- sprintf("Multiple names %0.3f", length(multi.names)/n)
# 	m5 <- sprintf("Not alpha names %0.3f", length(alpha.names)/n)
# 	cat(m0, m1, m2, m3, m4, m5, sep='\n')
# }
# 
# genderize.stats(dat$First.name, dat$Gender)
