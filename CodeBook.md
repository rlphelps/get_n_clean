Data Set Code Book
Getting and Cleaning Data, John's Hopkins Coursera R Course
Author
Ron Phelps
Feb 28th, 2016

Original Data Source
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones[1]

Data Source Variables Description:  See original data source description files
						features.txt and features_info.txt

Data Source Files				All files can be downloaded at the url listed 							above in a 60MB zipped file. 

						When all the files are extracted, there will be 						one main dir, 'UCI HAR Dataset' and two 								subdirectories – 'test' and 'train'. 

In the main dir are four files:	activity_labels.txt
						features_info.txt
						features.txt
						README.txt

						File descriptions follow below


						The test and train subdirectories each have 							three data files and one more subdirectory 							titled 'Inertial Signals'. Data in the 								intertial signals directories was not used in 							this data reduction and anlysis

						File descriptions follow below 

'UCI HAR Dataset' dir files		

	activity_labels.txt		Numerical tags for each type of activity that 							the subjects performed. Six total.

	features_info.txt			Description of the measurements made while each
						subject performed each activity. 

	features.txt			A listing of each type of measurement made with 						descriptive names. 561 total. Each subject 							performing one of the six activities will 							generate 561 measurements.


test directory data files

	subject_test.txt			Single column of numerical ids for a random 							subset of the 30 subjects performing tests

						2497 lines 
						9 subjects total
						Ids: 2,4,9,10,12,13,18,20,24

	X_test.txt				Table of measurements (features) 

						2497 lines each line has 561 columns of 								measurements 
	
	y_test.txt				Single column list of activities performed for 							each of the rows in X_test.txt identified by 							numerical values 1-6.
						1 WALKING
						2 WALKING_UPSTAIRS
						3 WALKING_DOWNSTAIRS
						4 SITTING
						5 STANDING
						6 LAYING

train directory data files

	subject_train.txt			Single column of numerical ids for a random 							subset of the 30 subjects performing tests
						7352 lines
						21 subjects total  
						Ids:11,25,26,27,15,14,17,16,19,23,30,22,28,
						29,1,3,5,7,6,8,21

	X_train.txt				Table of measurements (features)
						7352 lines each line has 561 columns of 								measurements 21 subjects total
	
	y_train.txt				Single column list of activities performed for 							each of the rows in X_train.txt identified by 							numerical values 1-6.
						1 WALKING
						2 WALKING_UPSTAIRS
						3 WALKING_DOWNSTAIRS
						4 SITTING
						5 STANDING
						6 LAYING


[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International 
Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

