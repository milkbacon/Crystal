# Case Study

df <- read.csv('Automotive_2.csv', colClasses = c('character', 'character', 'factor', 'factor', 'character',
                                                  'factor', 'factor', 'character', 'factor', 'character',
                                                  'factor', 'numeric', 'character', 'factor', 'factor',
                                                  'factor', 'character', 'integer', 'character', 'character'),
               na.strings = '')
df <- na.omit(df)

# (dateCrawled) Data is not relevant, should be removed.
df <- df[, -grep('dateCrawled', colnames(df))]

# (name) Information could be extracted, but would be removed.
df <- df[, -grep('name', colnames(df))]

# (seller) Factor variable, 2 levels but 99% of samples are "privat", so column should be removed.
df <- df[, -grep('seller', colnames(df))]

# (offerType) Remove numeric values, 99% of samples are "Angebot", so column should be removed.
# df <- df[-grep("[0-9.-]", df$offerType), ]
df <- df[, -grep('offerType', colnames(df))]

# (price) Outliers are considered 95%, so they should be removed.
df[,'price'] <- as.integer(df$price)
df <- df[df$price < quantile(df$price, 0.95),]

# (abtest) Removing levels with 0 samples.
df[, 'abtest'] <- droplevels(df$abtest)

# (vehicleType) Removing levels with 0 samples.
df[, 'vehicleType'] <- droplevels(df$vehicleType)

# (yearOfRegistration) Remove characters, blank spaces and outliers.
#df <- df[-grep("[^0-9.-]", df$yearOfRegistration), ]
#df <- df[df$yearOfRegistration != '', ]
#df <- df[(df$yearOfRegistration > 1900) & (df$yearOfRegistration < 2022),]
df[,'yearOfRegistration'] <- as.integer(df$yearOfRegistration)

# (gearbox) Removing levels with 0 samples.
df[, 'gearbox'] <- droplevels(df$gearbox)

# (powerPs) Converting to numeric, maybe 0 was considered as a NA value as for the histogram.
df[, 'powerPS'] <- as.integer(df$powerPS)
df <- df[df$powerPS < quantile(df$powerPS, 0.95),]
# df <- df[df$powerPS != 0, ]

# (model) Too many levels, may not be useful.
df <- df[, -grep('model', colnames(df))]

# (kilometer) Histogram looks skewed to the right, may not be useful.
df <- df[, -grep('kilometer', colnames(df))]

# (monthOfRegistration) Converting to integer, as outliers have been removed.
df[, 'monthOfRegistration'] <- as.integer(df$monthOfRegistration)

# (fuelType) Main classes are benizin and diesel, others could be removed.
df[, 'fuelType'] <- droplevels(df$fuelType)

# (brand) Too many levels, may not be useful.
df[, 'brand'] <- droplevels(df$brand)
df <- df[, -grep('brand', colnames(df))]

# (notRepairedDamage) Removing levels with 0 samples.
df[, 'notRepairedDamage'] <- droplevels(df$notRepairedDamage)

# (dateCreated) Not useful, should be removed.
df <- df[, -grep('dateCreated', colnames(df))]

# (nrOfPictures) All values are 0, should be removed.
df <- df[, -grep('nrOfPictures', colnames(df))]

# (postalCode) Not useful, should be removed.
df <- df[, -grep('postalCode', colnames(df))]

# (lastSeen) Not useful, should be removed.
df <- df[, -grep('lastSeen', colnames(df))]

library(caret)

set.seed(1002)

trainIndex <- createDataPartition(df$notRepairedDamage, p = 0.70, list = FALSE)
training <- df[trainIndex,]
testing <- df[-trainIndex,]

model <- train(notRepairedDamage ~ ., data = training, method = 'rpart')

pred <- predict(model, testing)

confusionMatrix(pred, testing$notRepairedDamage)

