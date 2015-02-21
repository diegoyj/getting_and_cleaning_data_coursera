<h1>Variables</h1>

<h2>Step 1</h2>
<ul>
   <li>'col_names': List of all features. It will be the columns names. 561rows x 2col </li>
   <li>'test_dataset': Testing table set. 2947rows x 561cols </li>
   <li>'test_activity_labels': Labels activity table. 2947rows x 1col</li>
   <li>'test_subject': Test subject table. 2947rows x 1col</li>
   <li>'train_dataset': Training table set. 7352rows x 561cols</li>
   <li>'train_activity_labels': Training labels. 7352rows x 1col</li>
   <li>'train_subject': Train subjects. 7352rows x 1col</li>
</ul>

<h2>Step 2</h2>
<ul>
   <li>'complete_dataset': this variable contains all the rows of the test and train data sets. 10299rows x 563cols</li>
</ul>

<h2>Step 3</h2>
<ul>
   <li>'index_mean_std': Store all the index that we want to select as columns</li>
   <li>'subset_mean_std': This is a subset of complete_dataset that has only the columns contained in index_mean_std</li>
</ul>

<h2>Step 4</h2>
<ul>
   <li>'activity_names': "Walking", "Walking upstairs", "Walking downstairs", "Sitting", "Standing", "Laying"</li>
</ul>

<h2>Step 5</h2>
<ul>
   <li>'aggrData': data with the average of each variable for each activity and each subject</li>
</ul>
