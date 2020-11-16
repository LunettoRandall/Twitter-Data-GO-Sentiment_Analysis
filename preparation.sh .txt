#Download dataset

wget https://s3.amazonaws.com/hipicdatasets/tweetsbi.csv

#Create folder in tmp folder in HDFS

hdfs dfs -mkdir tmp/tweetsbi

#Upload tweetsbi.csv file to tweetsbi folder at tmp folder of HDFS:

hdfs dfs -put tweetsbi.csv tmp/tweetsbi/

#Troubleshoot to check if file uploaded to tmp folder in HDFS

hdfs dfs -ls tmp/tweetsbi

hdfs dfs -cat tmp/tweetsbi/tweetsbi.csv | tail -3


#Run the following HDFS command to make your beeline command works.hdfs dfs -chmod -R o+w tmp/



