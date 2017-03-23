load(".RData")

require(arm)
require(xtable)

## COLORS
palette(c("navy","brown", "black", "orange", "blue", "green3", "yellow", "dodgerblue", "gray", "purple", "tomato1"))
transp.color <- function(x) {
	v <- col2rgb(x)/255
	rgb(red=v[1], green=v[2], blue=v[3], alpha=0.5)
}
