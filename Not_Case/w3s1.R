
# modeltime works best  in tibble format.

library(tidyverse)
library(dplyr)
library(tidy)

# Tidy data:
# Each variable in a column.
# Each observation on its row.

# Import > Tidy > (Tranform > Visualise > Model) > Communicate

# x %>% f == f(x)
# x %>% f %>% g %>% h == h(g(f(x)))

df <- data.frame(x = c(3, 5, 8, 13, 15), y = c(30, 25, 15, 21, 14))
df %>% lm(y ~ x, data=.)

a <- c(3, 5, -8, 13, 15)
a %>% data.frame(x = ., is_negative = . < 0)
a %>% data.frame(x = ., y = abs(.))
a %>% data.frame(x = sin(.), y = cos(.))

f <- . %>% log %>% exp

f <- function(x){
     y <- log(x)
     z <- exp(y)
     z
}

data.frame(x, y) %>% {
     plot(y ~ x, data = .)
     abline(lm(y ~ x, data = .))
}

cars %>% head(7)
cars %>% tail(5)
cars %>% summary

#                          M/F          M              Male           F              Female
df$variable <- recode(df$variable, 'first_version.1' = 'Vers1', 'first_version.2' = 'Vers2')

# transform() numerical to categorical

mpg <- transforming(mpg, cyl = factor(cyl), drv = factor(drv),
                    fl = factor(fl), class = factor(class))

dat <- within(dat, {
     speed_cat <- factor(speed_cat, labels = c('high speed', 'low speed'))
})

# diplyr
# Filter: Pick observations by their values. (Rows)
# Select: Pick observations by their names. (Columns)
# Mutate: Create new variables with functions of existing variables.
# Summarise: Collapse many values down to a single summary.
# Arrange: Reorder the rows. (In conjunction with group_by())
# left_join, right_join, inner_join, full_join.

df.1 <- filter(df, var1 == 'Albania')
df.2 <- select(df, -var1, -var3)

df.1 <- df %>% 
     filter(var1 == 'Albania') %>%
     select(-var2, -var3)

# tidyr
# gather: turn columns into rows.
# spread: turn rows into columns.
# separate: character column into multiple columns.
# unite: multiple character columns into a single column.

separate(repData, into = c('year', 'month', 'day'), sep = '_', convert = TRUE)
# 2021-05-23-01-34-07

library(tidyverse)
library(lubridate)
library(nycflights13)

today()
now()

ymd('2022-12-31')
mdy('December 31st, 2022')
dmy('1-Jan-2022')

ymd_hms('2022-12-31 23:58:59')

Time.df %>% mutate(arrival_time = make_datetime(year, month, day, hour, minute))

year()
month()
mday()
wday()
# label = True to return abbreviated name of the month or day of the week
# abbr = FALSE to return the full name.
floor_date(vector.date, 'week')
round_date()
ceiling_date()

eralda.age <- today() - ymd(19950101)
as.duration(eralda.age)

dseconds()
dminutes()
dhours()
ddays(0:7)
dweeks(7)
dyears(c(1,2))

seconds(10)

next_year <- today() + years(1)


