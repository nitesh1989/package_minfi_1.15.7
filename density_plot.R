#!/usr/bin/Rscript
# Import some required libraries
library('getopt');
library('minfi')
# Make an option specification, with the following arguments:
# 1. long flag
# 2. short flag
# 3. argument type: 0: No argument, 1: required, 2: optional
# 4. target data type
option_specification = matrix(c(
  'rgset','i',1,'character',
  'pdffile', 'f', 2, 'character',
  'pngfile', 'g', 2, 'character'
), byrow=TRUE, ncol=4);

# Parse options
options = getopt(option_specification);

# Create some simple test data
if(!is.null(options$rgset)){
	load(options$rgset)
}
RGset

# Set phenotype data
pd = pData(RGset)
pd$status

options$pdffile
options$pngfile

# Produce PDF file
if (!is.null(options$pdffile)) {
	# Make PDF of density plot
	pdf(options$pdffile)
	minfi::densityPlot(dat=RGset,sampGroups=pd$status,main = "Density Plot")

	dev.off()
}

# Produce PNG file
if (!is.null(options$pngfile)) {
	# Make PNG of density plot
	png(options$pngfile)
	minfi::densityPlot(dat=RGset,sampGroups=pd$status,main = "Density Plot")
	dev.off()
}





