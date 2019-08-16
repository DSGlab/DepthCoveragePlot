#This script will create a series of coverage-length plots for contigs in a set of assemblies that are concatenated in the same table to evaluate assemblies and test for contamination.
#Contact: Marcus Dillon; dillmm6@gmail.com

#Set working directory. 
setwd("/Users/marcusdillon/workingdirectory/TurkeyPsyIsolates/assemblyreports/") 

#Import dataframe containing teh assembly information for all assemblies that you produced in the dataset.
df <-read.table("allcontigstats.txt", sep="\t", header=TRUE)
head(df)

#Open plyr from library for dataframe manipulation and pivoting.
library(plyr)

#Create a strain list for all strains analyzed in this dataset.
strainlist <- c("YA0001","YA0002","YA0010","YA0011","YA0012","YA0013","YA0014","YA0015","YA0016","YA0024","YA0025","YA0026","YA0027","YA0028","YA0030","YA0032","YA0033","YA0041","YA0045","YA0046","YA0050","YA0051","YA0055","YA0057","YA0058","YA0059","YA0062","YA0069","YA0070","YA0076","YA0078","YA0079","YA0080","YA0083","YA0085","YA0086","YA0089","YA0093","YA0595","YA0598","YA0599","YA0602","YA0637","YA0695","YA0697","YA0701","YA0719","YA0720","YA0721","YA0729","YA0733","YA0745","YA0757","YA0758","YA0759","YA0783","YA0788","YA0796","YA0797","YA0848","YA0849","YA0850","YA0851","YA0852","YA0853","YA0867","YA0868","YA0869","YA0870","YA0871")
print(strainlist)

#Loop through each strain, subset the dataframe to include only those contigs, and generate/save a coverage/length plot, colored based on the top blast hit.
for (item in strainlist) { #loop through each unique strain id in the table.
  print(item) 
  subsetdf <- subset(df, Strain == item)
  filename <- paste(item,".pdf", sep = "")
  pdf(filename)
  colorlist <- c("black", "darkred", "darkblue", "darkgoldenrod", "darkgreen", "darkgrey", "darkviolet","darkturquoise","darkslategrey","darkslateblue","darkseagreen","darksalmon","darkorchid","darkorange","darkolivegreen","darkmagenta","darkkhaki","darkcyan","coral","cadetblue","aquamarine","deeppink","cornflowerblue","red","deepskyblue") #twenty-five color list with good contrast. You could modify or use a pallette, but I found the early colors in the pallettes aren't great for samples with a lot of contamination.
  genuslist <- levels(droplevels(subsetdf$TopBlastHitGenusPseudoFirst)) #Create a list of all blast hit options.
  genuscountdf <- count(subsetdf, "TopBlastHitGenusPseudoFirst") #Create dataframe with the number of occurences of each, then sort it by number of occurences (descending), with Pseudomonas always at the top so that it will always be the same color.
  genuscountdf <- genuscountdf[with(genuscountdf, order(-freq)), ]
  focalgenus <- c("Pseudomonas")
  focalrows <- as.character(genuscountdf$TopBlastHitGenusPseudoFirst) %in% focalgenus
  genuscountdf <- rbind(genuscountdf[focalrows,], genuscountdf[!focalrows,])
  colorsdf <- data.frame(TopBlastHitGenusPseudoFirst = genuscountdf$TopBlastHitGenusPseudoFirst, color = colorlist[1:length(genuslist)]) #Create a dataframe where each hit genus is assigned a difference colour from the colour list.
  plot(subsetdf$ContigLengthLog, subsetdf$AverageCoverageLog, col=as.vector(colorsdf$color[match(subsetdf$TopBlastHitGenusPseudoFirst,colorsdf$TopBlastHitGenusPseudoFirst)]), main=item, xlab="Average Length (log)", ylab="Average Coverage (log)", pch=19, xlim=c(3, 6), ylim=c(0, 4)) #generate plot, and not that color has to be a vector.
  legend("topright", legend=as.character(colorsdf$TopBlastHitGenusPseudoFirst), col=as.vector(colorsdf$color), pch = 19, bty="n") #Generate legend and note that colour has to be a vector.
  dev.off()
}

#The command below can be implemented to array plots on the same worksheet, but there were too many plots in my dataset to make this practical.
#par(mfrow=c(1,3)) #rows, columns


