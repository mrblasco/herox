install.packages("xlsx")
require(xlsx)

################################################################################
# iContact data 
################################################################################
files <- list.files("../Data/Previous Outreach Lists", pattern=".csv", full=TRUE)
listDF <- lapply(files, function(x) { 
	y <- import(x); y$link <- x
	return(y)
})
icontact <- do.call("rbind", listDF)

################################################################################
# Outreach data 
################################################################################

read.csv(files[2]) -> dat
read.csv(files[3]) -> dat

