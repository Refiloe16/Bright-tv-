 -- =============================================================
--    Bright_TV — Demographic Viewership Analysis
--    Tables : User_Profiles, Viewership
--    Notes  : RecordDate2 is UTC → converted to SAST (UTC+2)
--             Duration 2  is HH:MM:SS string → converted to minutes
--             Blank/NULL Gender, Race, Province → labelled 'Unknown'
-- =============================================================

---running all tables with a limit of 100---
select * 
from `workspace`.`default`.`bright_tv_user_profile` 
limit 100;







 ---combining two tables--
 select*
 from `workspace`.`default`.`bright_tv_user_profile` as a 
 left join `workspace`.`default`.`bright_tv_viewership` as b
 on a.UserID=b.UserID0;





---changing time stamp---
 select RecordDate2,
 from_utc_timestamp(RecordDate2,'Africa/Johannesburg') as sast_timestamp
 from `workspace`.`default`.`bright_tv_viewership`;





  ---checking the date range---
  ---mini dat eis 2016/01/01 and max date is 2016/03,31 (3 months)---
 select min(recorddate2) as min_date,
        max(recorddate2) as latest_date
from `workspace`.`default`.`bright_tv_viewership`;






---checking the provinces in the dataset---
---(none is unidentified)---
 select distinct(province) 
 from `workspace`.`default`.`bright_tv_user_profile`;




 ---total count of 11 provinces---
 select count(distinct province) as Number_of_provinces 
 from `workspace`.`default`.`bright_tv_user_profile`;






 ---checking avg time spent on tv per province---
 ---(none is unidentified)---
 select 
        avg(
            HOUR(a.`Duration 2`) * 60
          + MINUTE(a.`Duration 2`)
          + SECOND(a.`Duration 2`) / 60.0
        ) as avg_time_spent
from `workspace`.`default`.`bright_tv_viewership` as a
left join `workspace`.`default`.`bright_tv_user_profile` as b
on a.UserID0=b.UserID;






 ---checking for null values---
 select userid,
         CASE
            WHEN IFNULL(Gender,0) IS NULL THEN 'Unknown'
            ELSE (Gender)
        END AS gender,
        CASE
            WHEN IFNULL(Race,0) IS NULL THEN 'Unknown'
            ELSE (Race)
        END AS race,
        CASE
            WHEN IFNULL(Province,0) IS NULL THEN 'Unknown'
            ELSE (Province)
        END AS province
from `workspace`.`default`.`bright_tv_user_profile`;



---changing sast date to data type---
SELECT
    CAST(from_utc_timestamp(RecordDate2,'Africa/Johannesburg') as date) as sast_date,
    typeof(CAST(from_utc_timestamp(RecordDate2,'Africa/Johannesburg') as date)) AS data_type
FROM `workspace`.`default`.`bright_tv_viewership`
limit 10;
 SELECT
    Gender,
    LENGTH(Gender)          AS char_length,
    typeof(Gender)          AS data_type,
    Gender IS NULL          AS is_null,
    Gender = 'None'         AS is_none_string
FROM workspace.default.bright_tv_user_profile
WHERE Gender IS NULL
   OR TRIM(Gender) IN ('None', 'none', '', 'null')
LIMIT 20;




SELECT USERID,
        COALESCE(GENDER,'Unknown') AS GENDER,
        COALESCE(RACE,'Unknown') AS RACE,
        COALESCE(PROVINCE,'Unknown') AS PROVINCE
FROM `workspace`.`default`.`bright_tv_user_profile`;





-------------------------------------------------------------------------------------------------------------------

SELECT count(distinct userid0) as unique_viewers,
       COUNT(*) as total_sessions,
       ROUND(AVG(
            HOUR(`duration 2`) * 60
          + MINUTE(`duration 2`)
          + SECOND(`duration 2`) / 60.0
        ), 1) AS avg_session_mins,
       from_utc_timestamp(RecordDate2,'Africa/Johannesburg') as sast_datetime,
       CAST(from_utc_timestamp(RecordDate2,'Africa/Johannesburg') as date) as sast_date,
       date_format(from_utc_timestamp(RecordDate2,'Africa/Johannesburg'),'MMMM') as month_name,
       date_format(from_utc_timestamp(RecordDate2,'Africa/Johannesburg'),'EEEE') as day_of_week,
       hour(from_utc_timestamp(RecordDate2,'Africa/Johannesburg')) as hour_of_day,
       CASE 
            WHEN hour(from_utc_timestamp(to_timestamp(RecordDate2,'dd/MM/yyyy HH:mmm'),'Africa/Johannesburg')) BETWEEN 6 AND 11 THEN 'morning'
            WHEN hour(from_utc_timestamp(to_timestamp(RecordDate2,'dd/MM/yyyy HH:mmm'),'Africa/Johannesburg')) BETWEEN 12 AND 17 THEN 'afternoon'
            WHEN hour(from_utc_timestamp(to_timestamp(RecordDate2,'dd/MM/yyyy HH:mmm'),'Africa/Johannesburg')) BETWEEN 18 AND 23 THEN 'evening'
            ELSE 'night'
            END AS time_of_day,
       CASE
           WHEN TRIM(a.Gender) = 'None' THEN 'Unknown'
    ELSE INITCAP(TRIM(a.Gender))
END AS gender,

CASE
    WHEN TRIM(a.Race) = 'None' THEN 'Unknown'
    ELSE INITCAP(TRIM(a.Race))
END AS race,

CASE
    WHEN TRIM(a.Province) = 'None' THEN 'Unknown'
    ELSE TRIM(a.Province)
END AS province,
      NULLIF(a.age,0) as exact_age,
               CASE
            WHEN a.Age IS NULL OR a.Age = 0  THEN 'Unknown'
    WHEN a.Age BETWEEN 0  AND 17     THEN '1. 0-17  (Kids & Youth)'
    WHEN a.Age BETWEEN 18 AND 24     THEN '2. 18-24  (Young Adult)'
    WHEN a.Age BETWEEN 25 AND 34     THEN '3. 25-34  (Adult)'
    WHEN a.Age BETWEEN 35 AND 49     THEN '4. 35-49  (Mid Adult)'
    WHEN a.Age BETWEEN 50 AND 64     THEN '5. 50-64  (Mature Adult)'
    ELSE                                  '6. 65+    (Senior)'
        END AS age_band,
       channel2 as channel,
       (
            HOUR(`duration 2`) * 60
          + MINUTE(`duration 2`)
          + SECOND(`duration 2`) / 60.0
        ) as duration_mins
from bright_tv_user_profile as a
left join bright_tv_viewership as b
on a.userid=b.userid0
where `duration 2` is not null
and (
            HOUR(`duration 2`) * 60
          + MINUTE(`duration 2`)
          + SECOND(`duration 2`) / 60.0
        ) > 0
and (
            HOUR(`duration 2`) * 60
          + MINUTE(`duration 2`)
          + SECOND(`duration 2`) / 60.0
        ) > 0.5
group by userid0,
         day_of_week,
         hour_of_day,
         time_of_day,
         month_name,
         from_utc_timestamp(RecordDate2,'Africa/Johannesburg'),
         CASE
           WHEN TRIM(a.Gender) = 'None' THEN 'Unknown'
    ELSE INITCAP(TRIM(a.Gender))
END,

CASE
    WHEN TRIM(a.Race) = 'None' THEN 'Unknown'
    ELSE INITCAP(TRIM(a.Race))
END,

CASE
    WHEN TRIM(a.Province) = 'None' THEN 'Unknown'
    ELSE TRIM(a.Province)
END,
        CASE 
            WHEN hour(from_utc_timestamp(to_timestamp(RecordDate2,'dd/MM/yyyy HH:mmm'),'Africa/Johannesburg')) BETWEEN 6 AND 11 THEN 'morning'
            WHEN hour(from_utc_timestamp(to_timestamp(RecordDate2,'dd/MM/yyyy HH:mmm'),'Africa/Johannesburg')) BETWEEN 12 AND 17 THEN 'afternoon'
            WHEN hour(from_utc_timestamp(to_timestamp(RecordDate2,'dd/MM/yyyy HH:mmm'),'Africa/Johannesburg')) BETWEEN 18 AND 23 THEN 'evening'
            ELSE 'night'
            END,
            CASE
            WHEN a.Age IS NULL OR a.Age = 0  THEN 'Unknown'
    WHEN a.Age BETWEEN 0  AND 17     THEN '1. 0-17   (Kids & Youth)'
    WHEN a.Age BETWEEN 18 AND 24     THEN '2. 18-24  (Young Adult)'
    WHEN a.Age BETWEEN 25 AND 34     THEN '3. 25-34  (Adult)'
    WHEN a.Age BETWEEN 35 AND 49     THEN '4. 35-49  (Mid Adult)'
    WHEN a.Age BETWEEN 50 AND 64     THEN '5. 50-64  (Mature Adult)'
    ELSE                                  '6. 65+    (Senior)'
        END, 
        age,
        channel2,
        `duration 2`
ORDER BY total_sessions DESC,
         sast_date ASC;
