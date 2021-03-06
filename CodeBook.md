######filename: CodeBook.md
######repo: morenog/DSU3Ass

# Codebook for Course Project - Getting and Cleanng Data

### Data Set
** Name:**
Human Activity Recognition Using Smartphones Data Set.

**Abstract:**
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waistmounted smartphone with embedded inertial sensors.

**Information:**
The experiments have been carried out with a group of 30 volunteers within an age bracket of 1948
years.  Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS,
SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its
embedded accelerometer and gyroscope, we captured 3axial linear acceleration and 3axial
angular velocity at a constant rate of 50Hz. The experiments have been videorecorded
to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
The sensor signals (accelerometer and gyroscope) were preprocessed by applying noise filters and then sampled in fixedwidth sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth lowpass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
** Check the README.txt file in the data directory for further details about this dataset**

** Attribute Information:**
For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment.

** Citation Request:**
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. ReyesOrtiz.
Human Activity Recognition on Smartphones using a Multiclass HardwareFriendly
Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). VitoriaGasteiz, Spain. Dec 2012

### Data Output

**Data Transormations:**
The run_analysis.R script:
- Combines the data from the train and test data sets, to form one data set.
- Only utilises the mean and sd meausrements {...-mean()-X, ...-mean()-Y, ...-mean()-Z, ...-sd()-X, ...-sd()-Y, ...-sd()-Z }
- Generates a text file tidydata.txt containing a tidy data set with the average of each variable for each activity and each subject.

**TidyData.txt** Data description
- **SubjectID** A numeric integer value identifying the Subject. Range from 1 to 30.
- **ActivityClass** A text label identifying the activity {WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING}
- **variable** A text label of the variable in question (refer to the **features_info.txt** file in the data set directory for more information )
- **mean** A numeric value which is the mean of the variable in question per activity per subject.

###### end of file.