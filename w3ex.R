
library(dplyr)

df <- read.csv('Data.csv')
df_2 <- data.frame(Country = c('Austria', 'Greece', 'Italy', 'France', 'Spain', 'Germany'),
                   Pop = c(9006398, 10423054, 60461826, 65273511, 46754778, 83783942),
                   GDP = c(432.894, 194.376, 1848.222, 2551.451, 1247.464, 3780.553),
                   LifeEx = c(82.05, 82.8, 84.01, 83.13, 83.99, 81.88))

# Country	Pop	     GDP	     LifeEx
# Austria	9006398	432.894	82.05
# Greece	10423054	194.376	82.8
# Italy	60461826	1848.222	84.01
# France	65273511	2551.451	83.13
# Spain	46754778	1247.464	83.99
# Germany	83783942	3780.553	81.88

df <- inner_join(df, df_2, by = 'Country')

model1 <- with(df, lm(Salary ~ Age))
with(df, plot(Salary ~ Age))

df <- mutate(group_by(df, Country), avgSalary = mean(Salary, na.rm = TRUE))

df <- df %>% 
     group_by(Country) %>%
     mutate(avgSalary = mean(Salary, na.rm = TRUE)) %>%
     ungroup

library(caTools)

set.seed(123)
split <- sample.split(dataset$Country, SplitRatio = 0.8)

training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

table(data_bank$housing)
table(data_bank$marital, data_bank$job)
data_bank$housing <- ifelse(data_bank$housing == 'yes', 1, 0)

data_bank %>%
     group_by(marital, job) %>%
     summarize(mean(duration)) %>%
     arrange(job)

data_bank %>%
     group_by(marital, job) %>%
     summarize(mean(duration)) %>%
     arrange(marital)

library(tidyverse)

data_bank.2 <- data_bank %>%
     select(-contact, -poutcome) %>%
     group_by(marital) %>%
     mutate(day.balance = round(balance/duration, 2)) %>%
     summarize(min_day.balance = min(day.balance)) %>%
     ungroup
