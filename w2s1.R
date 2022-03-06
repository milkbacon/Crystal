## Week 2 Session 1 (GGplot and Esquisse)

df <- read.csv('bank-full.csv')
head(df)

hist(df$age)
pie(table(df$housing))
boxplot(df$age~df$marital, col = 1:3, ylab = 'age', main = 'Boxplot civil status', xlab = NULL)

# GGplot

library(ggplot2)

g1 <- ggplot(df) + 
     geom_histogram(aes(x=age), color='black', fill='white', binwidth=5) +
     ggtitle('Age distribution (red line=average age)') +
     xlab('Frequency') + 
     ylab('Age') + 
     geom_vline(aes(xintercept = mean(age), color = 'red')) +
     scale_x_continuous(breaks = seq(0, 100, 5)) + 
     geom_text(x = 45, y = 7500, label = 'Average', color = 'red', size = 6) +
     theme(legend.position = 'topleft')
g1

# Correlation plots

# library(psych)
library(dplyr)

df_2 <- df %>% select(duration, age, balance)
pairs(df_2, col = 'red', main = 'Scatterplot for many variables')

library(corrplot)
cor_mat <- cor(df[,c(1, 6, 12)])
cor_mat
# chart.Correlation(df[,c(1,6,12)], histogram=TRUE, pch=19)
corrplot(cor_mat, type = 'upper', order = 'hclust', name = 'RdYlBu')

M = cor(mtcars)
corrplot(M, order = 'hclust', addrect = 2)

library(GGally)

GGally::ggpairs(df[,c(1, 3, 6, 12)], mapping = aes(color = marital))

library(esquisse)
esquisse::esquisser()

esquisse::esquisser(df, viewer='browser')

# Cosvis

cosvis <- read.csv('Covid data-12 october 2020.csv')

cosvis$dateRep <- as.POSIXct(cosvis$dateRep, format = '%Y-%m-%d')
cosvis <- cosvis %>% remove_empty('cols')
cosvis[,'Month_Name'] <- month.abb[cosvis$month]

cosvis[cosvis < 0] <- 0
head(cosvis)


library(plotly)

fig <- plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length)
fig

fig <- plot_ly(data = cosvis, ~total_cases, y = ~continent)
fig
