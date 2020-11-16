#Create tweetsbi table in HIVE

CREATE EXTERNAL TABLE IF NOT EXISTS tweetsbi (
tweet_id string,
ts string,
msg string,
country string,
sentiment int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ","
LOCATION "/user/rlunett/tmp/tweetsbi"
TBLPROPERTIES ('skip.header.line.count' = '1');


#Troubleshoot query to view some data:

select * from tweetsbi LIMIT 3;


#Create Hive tables for Tableau

drop table if exists tweets_top_countries;

CREATE TABLE IF NOT EXISTS tweets_top_countries
AS SELECT country, sentiment, count(sentiment) as cnt
from tweetsbi
where country is not null AND country != "" AND country != "null"
group by country, sentiment
order by cnt DESC;


#Troubleshoot query to view some data:

SELECT * FROM tweets_top_countries ORDER BY cnt DESC LIMIT 2;


#Create top 10 countries who tweets mostly by executing the following 4
HiveQLs. NOTE: sentiment value is (0: Negative, 1: Neutral, 2: Positive):


CREATE VIEW IF NOT EXISTS top10
AS SELECT country, sum(cnt) as cnt2
FROM tweets_top_countries
group by country
ORDER BY cnt2 DESC LIMIT 10;

DROP TABLE IF EXISTS tweets_top10_countries;


CREATE TABLE IF NOT EXISTS tweets_top10_countries
AS SELECT
country, sentiment, cnt
FROM tweets_top_countries LEFT SEMI JOIN top10
ON tweets_top_countries.country = top10.country;


#Troubleshoot query to view some data:

SELECT * FROM tweets_top10_countries ORDER BY cnt DESC;


#Create a csv file using script

INSERT OVERWRITE DIRECTORY '/user/rlunett/tmp/'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT * FROM tweets_top10_countries
WHERE sentiment is NOT NULL
ORDER BY cnt DESC;


