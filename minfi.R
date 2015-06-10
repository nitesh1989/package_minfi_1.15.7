
###################################################
# code chunk number 1: Record starting time
###################################################
timeStart <- as.character(Sys.time())

###################################################
### code chunk number 2: Load all required libraries
###################################################
library(minfi, quietly=TRUE, warn.conflicts=FALSE)

###################################################
### code chunk number 3: Update package version
###################################################
if (packageVersion("minfi") < "1.15.6") {
  stop("Please update 'minfi' to version >= 1.15.7  to run this tool")
}

################################################### 
### code chunk number 3: baseDir
###################################################
baseDir <- system.file("extdata", package = "minfiData")
list.files(baseDir)


###################################################
### code chunk number 4: baseDir
###################################################
list.files(file.path(baseDir, "5723646052"))


###################################################
### code chunk number 5: sampleSheet
###################################################
targets <- read.450k.sheet(baseDir)
targets


###################################################
### code chunk number 6: BasenameColumn
###################################################
sub(baseDir, "", targets$Basename)


###################################################
### code chunk number 7: paths
###################################################
RGset <- read.450k.exp(base = baseDir, targets = targets)


###################################################
### code chunk number 8: pData
###################################################
RGset
pd <- pData(RGset)
pd[,1:4]


###################################################
### code chunk number 9: read2
###################################################
RGset2 = read.450k.exp(file.path(baseDir, "5723646052"))
RGset3 = read.450k.exp(baseDir, recursive = TRUE)


###################################################
### code chunk number 10: sampleSheet2
###################################################
targets2 <- read.csv(file.path(baseDir, "SampleSheet.csv"), 
                     stringsAsFactors = FALSE, skip = 7)
targets2


###################################################
### code chunk number 11: Basename
###################################################
targets2$Basename <- file.path(baseDir, targets2$Sentrix_ID, 
                               paste0(targets2$Sentrix_ID, 
                                      targets2$Sentrix_Position))


###################################################
### code chunk number 12: qcReport-quick (eval = FALSE)
###################################################
## qcReport(RGset, sampNames = pd$Sample_Name, 
##          sampGroups = pd$Sample_Group, pdf = "qcReport.pdf")


###################################################
### code chunk number 13: qcReport-density
###################################################
densityPlot(RGset, sampGroups = pd$Sample_Group, 
            main = "Beta", xlab = "Beta")


###################################################
### code chunk number 14: qcReport-bean
###################################################
par(oma=c(2,10,1,1))
densityBeanPlot(RGset, sampGroups = pd$Sample_Group, 
                sampNames = pd$Sample_Name)


###################################################
### code chunk number 15: qcReport-stripplot
###################################################
controlStripPlot(RGset, controls="BISULFITE CONVERSION II", 
                 sampNames = pd$Sample_Name)


###################################################
### code chunk number 16: Msetraw
###################################################
MSet.raw <- preprocessRaw(RGset)


###################################################
### code chunk number 17: allMsets
###################################################
MSet.norm <- preprocessIllumina(RGset, bg.correct = TRUE,
                                normalize = "controls", reference = 2)


###################################################
### code chunk number 18: MSet
###################################################
getMeth(MSet.raw)[1:4,1:3]
getUnmeth(MSet.raw)[1:4,1:3]
getBeta(MSet.raw, type = "Illumina")[1:4,1:3]
getM(MSet.raw)[1:4,1:3]


###################################################
### code chunk number 19: qcReport-mdsplot2
###################################################
mdsPlot(MSet.norm, numPositions = 1000, sampGroups = pd$Sample_Group, 
        sampNames = pd$Sample_Name)


###################################################
### code chunk number 20: preprocessSwan
###################################################
Mset.swan <- preprocessSWAN(RGsetEx, MsetEx)


###################################################
### code chunk number 21: plotBetaType
###################################################
par(mfrow=c(1,2))
plotBetasByType(MsetEx[,1], main = "Raw")
plotBetasByType(Mset.swan[,1], main = "SWAN")


###################################################
### code chunk number 22: subset-mset
###################################################
mset <- MSet.norm[1:20000,]


###################################################
### code chunk number 23: dmpFinder-categorical
###################################################
table(pd$Sample_Group)
M <- getM(mset, type = "beta", betaThreshold = 0.001)
dmp <- dmpFinder(M, pheno=pd$Sample_Group, type="categorical")
head(dmp)


###################################################
### code chunk number 24: plot-dmps-categorical
###################################################
cpgs <- rownames(dmp)[1:4]
par(mfrow=c(2,2))
plotCpg(mset, cpg=cpgs, pheno=pd$Sample_Group)


###################################################
### code chunk number 25: set-seed
###################################################
set.seed(123)


###################################################
### code chunk number 26: sim-pheno
###################################################
continuousPheno <- rnorm(nrow(pd))


###################################################
### code chunk number 27: dmpFinder-continuous
###################################################
dmp <- dmpFinder(mset, pheno=continuousPheno, type="continuous")
dmp[1:3,]


###################################################
### code chunk number 28: filter-dmp
###################################################
dmp <- subset(dmp, abs(beta)>1)


###################################################
### code chunk number 29: plot-dmps-continuous
###################################################
cpgs <- rownames(dmp)[1:4]
par(mfrow=c(2,2))
plotCpg(mset, cpg=cpgs, type="continuous",
        pheno=continuousPheno, xlab="Phenotype 1")


###################################################
### code chunk number 30: manifest
###################################################
IlluminaHumanMethylation450kmanifest
head(getProbeInfo(IlluminaHumanMethylation450kmanifest, type = "I"), n = 3)
head(getProbeInfo(IlluminaHumanMethylation450kmanifest, type = "II"), n = 3)
head(getProbeInfo(IlluminaHumanMethylation450kmanifest, type = "Control"), n = 3)


###################################################
### code chunk number 31: sessionInfo
###################################################
toLatex(sessionInfo())

