
library('tidyverse')

a <- c(1,2,5.3,6,-2,4) # numeric vector
b <- c("one","two","three") # character vector
c <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE) #logical vector

# print these out and see what they behave like.
# see the c() function? Use it to find the 2 and 4 indices in list a

# make a data frame from the lists above, this is what we were working with yesterday

names(mydata) <- c("ID","Color","Passed") # variable names (column headers)
head(mydata)

# factors store nominal data
sign <- c(rep("red",20), rep("green", 30)) 
sign <- factor(sign) 

length(object) # number of elements or components
str(object)    # structure of an object 
class(object)  # class or type of an object
names(object)  # names

c(object,object,...)       # combine objects into a vector
cbind(object, object, ...) # combine objects as columns
rbind(object, object, ...) # combine objects as rows 

object     # prints the object

ls()       # list current objects
rm(object) # delete an object

newobject <- edit(object) # edit copy and save as newobject 
fix(object)               # edit in place

# make a column from the levels in the sign factor

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

### combine the labelled (all above 1.5 or beloew -1.5 this time) and colorized plots above into a final, subsetted plot



# tumor observation data 'breast-cancer-wisconsin.data.csv', read in as a csv named tumorObs
# use the str() function on this object, what information does this give us?
# which column is not like the others?
tumorObs$bare.nuclei <- as.integer(levels(tumorObs$bare.nuclei))[tumorObs$bare.nuclei]
# what does the above line of code do? How can we check it?

# make tumorObs a tibble


# 'tidy the data', basically reframe the data from multiple columns down to 3
# this is very useful for visualizing across all of the data.
tidy_tumorObs <- tumorObs %>% gather(key, values, clump.thickness:class)
head(tidy_tumorObs)

# here we need to tidy the data again, but leave out the class variable
# give this a shot, our columns should be id:class:key:value



# Here, I want you to create a geom_violin plot where x axis is class (discrete values 2, 4)
# and the y axis are the continuous, numeric values
# use facet_wrap(~key, scales = 'free_y', ncol=3) in your ggplot formula to plot 9 different
# individual plots per key value. Color by key value

## Now let's do something called 'clustering', using PCA
summary(prcomp(tumorObs, scale = TRUE))
biplot(prcomp(~ bare.nuclei + class, data = na.omit(tumorObs)))
