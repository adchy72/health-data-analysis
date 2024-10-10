How many unique users exist in the logs dataset?
SELECT COUNT (DISTINCT id)
FROM health.user_logs;
count
554
Note: For question 2-8, I created a temporary table:

Step 1: Firstly, I ran a code DROP TABLE IF EXISTS statement to clear out any previously created tables:

DROP TABLE IF EXISTS user_measure_count;
Step 2: Next, I created a new temporary table using the results of the query below:

CREATE TEMP TABLE user_measure_count AS
SELECT 
  id,
  COUNT(*) AS measure_count,
  COUNT (DISTINCT measure) AS unique_measures
FROM health.user_logs
GROUP BY 1;
Question 2

How many total measurements do we have per user on average?
SELECT
  ROUND (AVG(measure_count), 2) AS mean_value
FROM user_measure_count;
mean_value
79.23
Question 3

What about the median number of measurements per user?
SELECT 
   PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY measure_count) AS median_value 
FROM user_measure_count;
median_value
2
Question 4

How many users have 3 or more measurements?
SELECT COUNT(*)
FROM user_measure_count
WHERE measure_count >= 3;
count
209
Question 5

How many users have 1,000 or more measurements?
SELECT COUNT(*)
FROM user_measure_count
WHERE measure_count >= 1000;
count
5
Question 6

Have logged blood glucose measurements?
SELECT 
  COUNT(DISTINCT id)
FROM health.user_logs
WHERE measure = 'blood_glucose';
count
325
Question 7

7. Have at least 2 types of measurements?
SELECT 
  COUNT(*)
FROM user_measure_count
WHERE unique_measures >= 2;
count
204
Question 8

Have all 3 measures - blood glucose, weight and blood pressure?
SELECT
  COUNT(*)
FROM user_measure_count
WHERE unique_measures = 3;
count
50
Question 9

What is the median systolic/diastolic blood pressure values?
SELECT
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY systolic) AS median_systolic,
  PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY diastolic) AS median_diastolic
FROM health.user_logs
WHERE measure = 'blood_pressure';
median_systolic	median_diastolic
126	79
