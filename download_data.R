# stackoverflow:
# http://stackoverflow.com/questions/3053833/using-r-to-download-zipped-data-file-extract-and-import-data
# data located here
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(url, dest="dataset.zip", mode="wb")
unzip ("dataset.zip", exdir = "./")

