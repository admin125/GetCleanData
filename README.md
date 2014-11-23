---------------------Step 1 (merge the sets)----------------------------------------------------

 The run_analysis.R file loads and computes per (subject,activity),
 for each sensor output, the average of this output over a series of
 experiments.
 First, the script loads the training data  and the test data
 and combines them into one dataframe.
 Before proceeding it clears intermediate results.


------------------Step 2 and 4 (label the columns and select only std() and mean() ----------

 The script reads the column names into a vector, prefixes that vector with Subject and Activity
 and then assigns the vector to the names of the merged dataframe.
 It then finds the subset of column names that have, respectivily mean() or std() in their name
 and uses these to select only those columns/variables. (and also, Subject and Activity of course)


-----------------Step 3 (Use words instead of numbers in the Activity Column) ------------------

Since the activities are numbers in the df, the scripts modifies them from numbers to text"


------------------Step 5 (Create summarized data) -----------------------------------------------
 Script converts the dataframe to tbl_df so it easier to do computations,
 groups it by Subject,Activity and computes the mean over all the columns
 using the summarize_each function. 
 Finally, prefix the variable names with 'Avg_' since they are all average values.
 Print to console,
 Save to file
 Cleanup intermediate results and leave the result (res) in the environment.








