<h1>Course Project - Getting and Cleaning Data</h1>

The goal is to prepare tidy data that can be used for later analysis.

A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

<h2>Files in this repo:</h2>

<b>CodeBook.md:</b> describes the variables, the data, and any transformations or work that you performed to clean up the data.<br/>
<b>readme.md:</b> is a brief description of this repo. <br/>
<b>run_analisys.R:</b> is the script that performs the operations to clean the data set.<br/>

<h2>run_analisys.R</h2>

For running this script we will assume that the files containing the data are in the working directory.<br/>
This script does the following:<br/>

<ol>
<li>Defines the files names and the paths in the working directory.</li>
<li>Read the files and store the data in values.
    <ul> <li>Read the files as data frames with the function <code>read.table()</code></li>
    </ul>
</li>
<li>Merges the training and the test sets to create one data set stored in complete_dataset.
    <ul><li>Add the columns names to the full dataset.</li>
        <liAdd a column in complete_dataset with the activity labels of train and test sets stored in test_activity_labels.</li>
        <li>Add a column in complete_dataset with the data in subject of train and test variable.</li>
    </ul>
</li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement. 
    <ul><li> Extract the columns numbers with the pattern "mean()" and "std()"</li>
    </ul>
</li>
<li>Uses descriptive activity names to name the activities in the data set</li>
<li>From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  <ul><li>Use the function aggregate to split the data into different subsets.</li>
  </ul>
</li>

</ol>

<h2> Dependencies</h2>
When using the script you will need to import two packages: dplyr and data.table </br>




