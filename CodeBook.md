Cook Book for Tidying of Data Set
=================================

These are the steps that were followed to create the tidy data set:

- Load the list of all of the indices and labels for the features in the dataset from the "features.txt" file
- Iterate over the feature list and create a new list of the ones that we care about, which are the means and standard deviations. We determine which features are the means by picking all featured that have a label containing the string "mean()" and all standard deviations by choosing ones whose labels contain the string "std()"
- Load all of the activity labels located in the "activity_labels.txt" file and make a dictionary of activity IDs to labels
- The raw data was loaded from both the training set and the test data set by loading the files "train/subject_train.txt", "train/X_train.txt", "train/y_train.txt", "test/subject_test.txt", "test/X_test.txt", "test/y_test.txt" and merged together into one table
- The raw data was grouped by both Subject and Activity and the averages for each of the features for every unique combination of Subject and Activity was calculated
- A final tidy data set is created from the list of combinations of Subject/Activity and the averages
- Finally, The labels for the activity IDs was added to each row in the tidy data set