### LAB | Customer Analysis 4

- [X] Check the data types of the columns. Get the numeric data into dataframe called numerical and categorical columns in a dataframe called categoricals. (You can use np.number and np.object to select the numerical data types and categorical data types respectively)
- [X] Now we will try to check the normality of the numerical variables visually
- [X] Use seaborn library to construct distribution plots for the numerical variables
- [X] Use Matplotlib to construct histograms
Do the distributions for different numerical variables look like a normal distribution
- [X] For the numerical variables, check the multicollinearity between the features. Please note that we will use the column total_claim_amount later as the target variable.
- [X] Drop one of the two features that show a high correlation between them (greater than 0.9). Write code for both the correlation matrix and for seaborn heatmap. If there is no pair of features that have a high correlation, then do not drop any features
