Description: This script produces a color coded depth coverage plot for all strains in a dataset based on the blast results for the assembly. 

Contact: Marcus Dillon, dillmm6@gmail.com

Input File: The "allcontigstats.txt" file will require the following columns, with each row representing one contig from one strain: 

1)Strain: The strain name for the contig. This is used to sort each strain into a single plot.
2)Contig: The contig name/number.
3)ContigLengthLog: The log transformed length of the contig.
4)AverageCoverageLog: The log transformed average coverage of the contig.
5)TopBlastHitGenusPseudoFirst: The name of the top blast hit for coloration. Here, I've labelled all contigs as pseudomonas if there was a pseudomonas hit in any of the top ten subject sequences.
