
print('Hello, World!')

# variable naming, printing
helloVariable <- 'Hello, World!'
print(helloVariable)

# simple math
2 * 2
3 + 3
2 ** 3
20 / 2
20.54321 / 2

# Booleans
1>2 # False
500 == 500 # True

# simple function
quickFxn <- function(x) {return(((x+2)/3))} # notice the curly braces
quickFxn(7) # (7+2)/3

######## Warm Up!! ##########

# print out 'My name is ______' [fill in the blank!]


# write a function that returns the square of the input (x), use it [will be two lines of code, refer to the example]



# Notice again that in R we assign variable names using '<-' instead of '=' for the most part
carsData <- mtcars
# The 'head' function prints out the top 5-10 lines from your data or file, useful for getting a preview
head(carsData)

# TRY the same above, this time lets use the data set called 'iris' [instead of 'mtcars'], name your variable myFlowers

# you should see the first 6 rows, with 5 columns: Sepal Length, Sepal Width, Petal Length, Petal Width, Species

# Call on specific columns by following your data variable with '$' immediately after (NO space) and hit'TAB'

head(carsData$mpg)

# Remember to use Tab Complete here; no need to remember all the column names!

head(carsData$hp)
gearValues <- carsData$gear
gearValues

# if you want, go ahead and try this with some of the myFlowers columns

# Another useful tool for looking at individual data points is table:
table(carsData$disp)
print('Counts the occurences of values within the data')
table(carsData$cyl)

# notice how useful this is when you have fewer possible values for your data....

# We are generating lists of data, and these lists have indexes!! By putting your index in brackets after the variable
# or function, you can look at only this index

head(carsData$mpg)[3]
gearValues[4]

# TRY find the value of the fourth row in the Petal.Length column from your myFlowers data (output should be 1.5)



# The same principle applies to columns and rows in data
carsData[10] # Just the number returns a the labelled column
carsData[10, ] # A comma following your index returns the labelled row
carsData[, 10] # A comma before your id returns the un labelled column data in a numerical format

# You can combine these indexes to look at even more specific segments of the data
carsData[1, ]
carsData[1, 5:11]
carsData[1, 5]

########### TRY and repeat the exercise above using the 
# myFlowers data, find the value of the fourth row in the column Petal.Length (the 3rd column....)
# the output should be 1.5:


# Can quickly and easily assess certain properties of the data 
print('Mean MPG')
mean(mtcars$mpg)
print('MPG Standard Deviation')
sd(mtcars$mpg)
print('Median MPG')
median(mtcars$mpg)

#  1 - What is the mean of all the values in the 'cyl' column?

#  2 - What is the sum of all the values in the 1st row?

#  3 - What is the sd of Petal Widths in the myFlowers data


# attaching our data allows us to call only the variable names when we are plotting
attach(carsData)

# simply calling plot(x variable, y variable) will generate a nice scatter plot
# plot(x variable, y variable, y label, x label, main label)
plot(wt, mpg, ylab = 'Miles Per Gallon', xlab = 'Weight', main = 'MPG vs. Weight')

# Plot another pair of variables with the appropriate plot title and axis labels. Do these appear related?


pairs(~mpg+disp+drat+wt,data=carsData, 
   main="Car Data Scatterplot Matrix")

# plot(x variable, y variable, y label, x label, main label)
plot(wt, mpg, ylab = 'Miles Per Gallon', xlab = 'Weight', main = 'MPG vs. Weight')
# the 'abline' function adds any type of straight line to an existing plot.
# In this case add in the line generated from the 'lm' function, or 'linear model', which carries out regression for us


# line(linear model(mpg and wt), color = red)
abline(lm(mpg~wt), col="red") # regression line (y~x)

# If nothing shows up, try switching the order of variables in lm()


########## Final Section Practice #############

# 1 - attach the myFlowers data set

# run the cell after writing this line

# 2 - plot Petal.Width in (hint: hist())

# 3 - plot the mean of the Petal.Width data over this, color this line red
abline(v = )

# This cell contains some other basic plot commands for you to mess around with:

boxplot(hp, main = 'Box and Whisker plot of horsepower')

hist(cyl, col='lightblue')

plot(density(hp), main = 'Distribution of Car Horsepower', col = 'lightgreen')

# library(package) loads in the extra tools for use
library(tidyverse)

# read in the txt file as delimeted data, name in geneExpression
geneExpression <- read.delim('concatDE_gene_count.txt')

# make sure R knows that the values in the log2FoldChange column are numbers, floats specifcally
geneExpression$log2FoldChange <- as.numeric(levels(geneExpression$log2FoldChange))[geneExpression$log2FoldChange]

# convert the geneExpression data from a data frame to a special Tidyverse object: tibble
geneExpression <- as.tibble(geneExpression)

head(geneExpression)

'NAs in data before cleanup'
# applies a function to each column of the tibble. In this case, sum the number of times is.na is true!
map(geneExpression, ~sum(is.na(.)))

# save geneExpression as the tibble with all the NA's dropped using the na.omit function
geneExpression <- na.omit(geneExpression)

'After'
########### check the NA count one more time to be sure #############
map(geneExpression, ~sum(is.na(.)))

# 1 - How many Genes are left in the data after cleanup?

# 2 - What do you EXPECT the mean and median of the log2FoldChange column to be?

# 3 - Calculate these values. Do they match your expectations?


# refer to the first cell of this notebook for some guidance
# go ahead and test your function here to make sure it works



# tidyverse functions use the special %>% notation to denote the use of a function, more on this later
geneExpression <- geneExpression %>% mutate(log2FoldChange=(signChange(log2FoldChange)))

# check that your results make sense:
head(geneExpression)

### NOTE; if you run this cell multiple times, you will continually change your data, make sure you end up with
### with the desired results.

### Save our new, clean dataframe as a comma seperated text file
write_csv(geneExpression, path = 'geneExpression.csv')

# all uses of the ggplot tool will follow this rough outline

# name your plot, define the ggplot function with your data name, and the aesthetic (aes()) values

densityPlot <- ggplot(geneExpression, aes(x=log2FoldChange)) + geom_density(fill = 'lightblue') 
# ggplot's different graphs are all stored as different 'geoms', we will call on geom_density

# we can also add in the mean we calculated earlier, though in this case it should be fairly obvious

densityPlot <- densityPlot + geom_vline(xintercept = mean(geneExpression$log2FoldChange), color = 'pink')
# simply call on the plot variable to produce the image, ggplot also has many built in themes 
densityPlot + theme_minimal()

# notice that you can add a third feature to the aes() function, try size, color, alpha, fill, shape
cars1 <- ggplot(carsData) + 
# aes() can contain 'color' and 'fill' variables to add another dimension to your visualization
geom_point(aes(x=wt, y=hp, color=factor(cyl)), position = 'jitter') + 
geom_smooth(aes(x=wt, y=hp), alpha = .05, color='grey')

cars1 + ggtitle('Horsepower vs. Weight') + 
xlab('Weight') + ylab('Horsepower') + theme_minimal()

#### Plot 1

#### Plot 2
