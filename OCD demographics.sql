-- 1. Count and Percentage of Male vs Female Patients & Display Average Obsession Score by Gender
SHOW tables;
SELECT Gender, 
count(`Patient ID`) as patient_count,
avg(`Y-BOCS Score (Obsessions)`) as avg_obs_score
FROM ocd_patient_dataset
GROUP BY 1
ORDER BY 2;

SELECT 
SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS count_female,
SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) AS count_male,

	-- Female %
	ROUND(SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END)/
	(SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) + SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) *100, 2))
	AS pct_female,
    
    -- Male %
    ROUND(SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END)/
    (SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) + SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) * 100, 2))
    AS pct_male
    
FROM ocd_patient_dataset;


-- 2. Count & Average Obsession Score by Ethnicity
SELECT Ethnicity,
COUNT(`Patient ID`) AS patient_count,
ROUND(AVG(`Y-BOCS Score (Obsessions)`), 2) AS avg_obs_score
FROM ocd_patient_dataset
GROUP BY 1
ORDER BY 2;

-- Count of Diagnoses Per Day & Per Month & Per Year
SET SQL_SAFE_UPDATES = 0;

UPDATE ocd_patient_dataset
SET `OCD Diagnosis Date` = STR_TO_DATE(`OCD Diagnosis Date`, '%d/%m/%Y');

ALTER TABLE ocd_patient_dataset
MODIFY `OCD Diagnosis Date` DATE;

	-- Per Day
SELECT date_format(`OCD Diagnosis Date`, '%d/%m/%Y') AS DATE,
COUNT(`Patient ID`) patient_count
FROM ocd_patient_dataset
GROUP BY 1
ORDER BY 1;

	-- Per Month
    SELECT date_format(`OCD Diagnosis Date`, '%m-%Y') AS MONTH,
    COUNT(`Patient ID`) AS patient_count
    FROM ocd_patient_dataset
    GROUP BY 1
    ORDER BY 1;
    
    -- Per Year
    SELECT date_format(`OCD Diagnosis Date`, '%Y') AS YEAR,
    COUNT(`Patient ID`) patient_count
    FROM ocd_patient_dataset
    GROUP BY 1
    ORDER BY 1;
    
-- Determine the Most Common Obsession Type & Average Obsession Score
SELECT `Obsession Type`,
COUNT(`Patient ID`) AS patient_count,
ROUND(AVG(`Y-BOCS Score (Obsessions)`),2) as obs_score
FROM ocd_patient_dataset
GROUP BY 1
ORDER BY 2;

-- Determine the Most Common Compulsion Type & Average Compulsion Score
SELECT `Compulsion Type`,
COUNT(`Patient ID`) AS patient_count,
ROUND(AVG(`Y-BOCS Score (Compulsions)`), 2) AS com_score
FROM ocd_patient_dataset
GROUP BY 1
ORDER BY 2;