## Description of the script

## read packages i.e. library(vegan)
inputFile <- "data/data.csv"
outputFile <- "data/results.csv"

##read input
inputData <- read.csv(inputFile)

## get number of samples in data
sampleNumber <- nrow(inputData)

## generate results
results <-someOtherFunction(inputFile, sampleNumber)

## write results
write.table(results, outputFile)
