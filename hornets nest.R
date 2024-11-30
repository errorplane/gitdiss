#I manually gathered the number of mentioned popping up on google for an association
#between various religions and the term "hornet." I did this by counting the number of
#results fo "Xreligion" AND "hornet" and dividing that total by the results for 
#just "Xreligion" alone.

avmormon <- 474000/43100000
"'mormon' OR 'latter day saint'"
avprotestant <- 444000/87400000
avcatholic <- 550000/370000000
#"'protesant' OR 'evangelical'"
avbuddhist <- 398000/106000000
avhindu <- 597000/310000000
avjewish <- 864000/356000000
avmuslim <- 1200000/609000000

#the mormon average is obviously larger, but is it statistically significant?

#here I make a data frame with the totals. This time, I subtract the hornet
#results to have the second value approxmiate all the search results which 
#have nothing to do with hornets

mormon <- c(474000, (43100000-474000))
"'mormon' OR 'latter day saint'"
protestant <- c(444000, (87400000-444000))
#"'protesant' OR 'evangelical'"
catholic <- c(550000, (370000000-550000))
buddhist <- c(398000, (106000000-398000))
hindu <- c(597000, (310000000-597000))
jewish <- c(864000, (356000000-864000))
muslim <- c(1200000, (609000000-1200000))


rel <- data.frame(mormon, protestant, catholic, buddhist, hindu, jewish, muslim)
rel <- t(rel)
colnames(rel) <- c("Hornet Results", "Non-Hornet Results")

chi <- chisq.test(rel)
chi

#The chi-squareed test shows basically a p-value of 0.

#adding the av numbers so I can add it to a bar chart

av <- (c(avmormon, avprotestant, avcatholic, avbuddhist, avhindu, avjewish, avmuslim))

library(tidyverse)
library(ggplot2)

avchart <- data.frame("Religion" = (c("Mormon", "Protestant", "Catholic", "Buddhist", "Hindu", "Jewish", "Muslim")), "Hornet.Association.Score" = av)

p <- ggplot(data = avchart, aes(x=Religion, y=Hornet.Association.Score, "fill")) +  
  geom_bar(stat = "identity") 

setwd("C:/Users/scott/OneDrive/University of Oxford/Dissertation/Chapter 1")
p
ggsave("hornet.png", plot = last_plot(), scale = 1)

write.csv(rel, file = "avhornetchart.csv")
