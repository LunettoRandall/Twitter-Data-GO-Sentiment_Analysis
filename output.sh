#Download the output file “000000_0” to “top10country.csv”

hdfs dfs -get tmp/000000_0 top10country.csv



#Troubleshoot to view content of file, use Shell pipeline
cat top10country.csv | tail -n 2


#Download copy of file to local disk

scp rlunett@129.150.64.74:/home/rlunett/top10country.csv .