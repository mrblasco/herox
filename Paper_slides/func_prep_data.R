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

# Genderize main function
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
