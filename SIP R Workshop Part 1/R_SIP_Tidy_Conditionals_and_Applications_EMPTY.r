
library('tidyverse')

# set some variable equal to 10
x <- 10
# now, tell R to print x if and only if x >5
# watch for the CURLY BRACERS {}
if (x > 5) {
    print(x)
}
# in this case we will get an output equal to x
# you can change x and see how that effects this cell

# set some variable equal to 10
x <- 4
# now, tell R to print x if and only if x >5
# watch for the CURLY BRACERS {}
if (x > 5) {
    print(x)
} else {
    print('Sorry')
}
# this time we should print our *else* condition

x <- 10
# ifelse (conditional, output if true, output if false)
ifelse (x > 5, x,'Sorry')

#### now, write a function that uses 'ifelse' to multiply values below 10 by 2, and divide values above 10 by 2



geneExpression <- read.csv('geneExpression.csv')
head(geneExpression)

# Plot a scatter plot (geom_point) with the x axis as Gene Names and the y axis as log2FoldChange

# plot the figure, while hiding the gene names from the axis (too many to visualize!)
distPlot + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

#### What does each dot on this plot represent? ####

# add labels to your plot IF the genes log2FoldChange is above 6 or below -6
## FIRST copy your code from above, add 'label = X.' to your aes() in distPlot

## SECOND figure out the function that will only return values above 6 or below -6 (hint: abs(x) gives you the absolute)
# value of x ... 
# If the input satifies the condition, you should return the gene name > as.character(X.), else return '' (blank)

# take your function and plug in the ifelse portion into the label value --> label=(ifelse...)
distPlot <- distPlot + geom_text(aes(label=YOUR CODE HERE)), hjust=1.0, vjust=1)

distPlot + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

# color the distPlot by log2FoldChange value. Color values above 1 Red, and below -1 Blue. All other points Grey.
## FIRST copy your distPlot code from above, including geom_point()


## SECOND since we want to color the points, add an aes() to geom_point 
## log2FoldChange is the variable we want to look at, meanwhile the c() is telling R that we want to group the variable
## into different values. Fill this with the 4 bounds(upper and lower values) we need for our coloring job 
## (hint: Inf and -Inf = positive and negative infinity)


## THIRD we are using scale_color_manual() to specify which colors we want to use
## values = c() will be filled with values like this: '(Lower bound, upper Bound]' = 'color'
## brackets and quotes are intentional 


distPlot + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

cancerGenes <- read.delim('cancerGenes', header=FALSE)
head(cancerGenes)

# make a subet of the data that only includes genes that show up in the cancer genes list
filt_geneExpression <- subset(geneExpression, X. %in% cancerGenes$V1)
head(filt_geneExpression)

### combine the labelled (all above 1.5 or beloew -1.5 this time) and colorized plots above into a final, 
### subsetted plot


