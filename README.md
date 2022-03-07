# Crystal CS

## Overview
Project 10 repo, done only by Milton Osiel Candela Leal. Two approaches were taken on "Automotive_2.csv":
- R with .Rmd file "CS Case.Rmd"
- Python with .py file "nn.py"

The R markdown file consisted on "Data Preparation", "Filling missing values", "Classification model". Then, "training.csv" and "testing.csv" were exported so that they could be used in "nn.py", as there were a lot of samples and parallel training is not possible in R, and so I have used a GPU to speed up the training process via an Artificial Neural Network (ANN).
Even though an ANN was used, a Classification and Regression Trees (CART) model in R achieved similar accuracy (55%), so that suggest that model complexity was not the real problem, but data treatment, as few source variables were used (5):
- price
- yearOfRegistration
- powerPS
- monthOfRegistration
- brand

### Python files
- loss_plot.png
- accuracy_plot.png
- nn_results.png
- nn.py

### R files
- CS Case.Rmd
- CS-Case.pdf
- caseStudy.R

### Data files
- Automotize_2.csv (not included due to size = 27.5 and > 5 MB)
- processed.csv (not included due to size = 5.5 and > 5 MB)
- training.csv
- testing.csv

## Methodology
I was not quite sure how to obtain the target variable "predict whether a vehicle will be sold or not", I assummed that I could take variable **lastSeen** and determine, if it has a date, then it was sold, otherwise it was not sold yet. All other source variables were analyzed individually in the .Rmd file. Then, numerical NAs were removed (9999999 in high right-skewed histograms or 0 in high left-skewed histograms), afterwards, a classification model was trained in order to predict missing values in categorical features (using the created function **missing_cat_cols**.
Then, a **RandomForest** classifier was trained to estimate the importance of best variables, hence reducing the number of source variables and then creating **training.csv** and **testing.csv**.

## Results
Even though results were similar to both models (CART and ANN), some improvements could be done on creating combined features using dates (although I was not sure how to used them as I assumed that **lastSeen** was the determinant column to create the target variable. Also, random down sampling was used to balance the dataset, and so have reliable results when using *Accuracy* as a metric to determine a model's performance on predicting the target feature, this could be improved using another type of down sampling or using stratified cross validation to better use the huge amount of data provided.
