###################################################
# code chunk number 1: Record starting time
###################################################
timeStart <- as.character(Sys.time())

### code chunk number 2: Load all required libraries
library(minfi, quietly=TRUE, warn.conflicts=FALSE,verbose = FALSE)

### code chunk number 3: Update package version
if (packageVersion("minfi") < "1.15.6") {
  stop("Please update 'minfi' to version >= 1.15.7  to run this tool")
}

# Get arguments from the command line
args = commandArgs(TRUE)
print(args[1])

input_idat = args[1]
RGset = read.450k(input_idat,verbose=T)
beta = getBeta(RGset)
beta
