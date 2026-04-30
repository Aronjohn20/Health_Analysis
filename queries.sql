-- Create cleaned table with positivity rate
CREATE OR REPLACE TABLE covid_19_states_cleaned AS
SELECT 
  Date, State, Confirmed, Recovered, Deceased, Tested,
  (Confirmed / Tested) * 100 AS positivity_rate
FROM covid_19_states;


-- Create cleaned table with daily values using lag (data transformation)
CREATE OR REPLACE TABLE covid_19_states_cleaned AS
SELECT
    Date,
    State,

    Confirmed,
    COALESCE(
        Confirmed - LAG(Confirmed) OVER (PARTITION BY State ORDER BY Date),
        Confirmed
    ) AS daily_confirmed,

    Recovered,
    COALESCE(
        Recovered - LAG(Recovered) OVER (PARTITION BY State ORDER BY Date),
        Recovered
    ) AS daily_recovered,

    Deceased,
    COALESCE(
        Deceased - LAG(Deceased) OVER (PARTITION BY State ORDER BY Date),
        Deceased
    ) AS daily_deceased,

    Tested,
    (Confirmed / Tested) * 100 AS positivity_rate
FROM covid_19_states;



-- Get total confirmed, recovered, and deceased cases excluding India
SELECT 
    SUM(daily_confirmed) AS total_confirmed, 
    SUM(daily_recovered) AS total_recovered, 
    SUM(daily_deceased) AS total_deceased 
FROM covid_19_states_cleaned 
WHERE State!='India';

------------------------------------------------------------

-- Find maximum daily confirmed cases per state
SELECT State, MAX(daily_confirmed) AS max_confirmed
FROM covid_19_states_cleaned
GROUP BY State 
HAVING State!='India'
ORDER BY max_confirmed DESC;

------------------------------------------------------------

-- Find maximum daily deaths per state
SELECT State, MAX(daily_deceased) AS max_deceased
FROM covid_19_states_cleaned
GROUP BY State 
HAVING State!='India'
ORDER BY max_deceased DESC;

------------------------------------------------------------

-- Get total confirmed cases for India
SELECT State, SUM(Confirmed) 
FROM covid_19_states_cleaned 
GROUP BY State 
HAVING State='India';

------------------------------------------------------------

-- Get total recoveries per state excluding India
SELECT State, SUM(daily_recovered) AS total_rec 
FROM covid_19_states_cleaned 
GROUP BY State 
HAVING State!='India'
ORDER BY total_rec DESC;

------------------------------------------------------------

-- Calculate overall recovery rate per state
SELECT State, 
       (SUM(daily_recovered)/SUM(daily_confirmed))*100 AS recovery_rate 
FROM covid_19_states_cleaned 
GROUP BY State 
HAVING State!='India' 
ORDER BY recovery_rate DESC;

------------------------------------------------------------

-- Calculate overall death rate per state
SELECT State, 
       (SUM(daily_deceased)/SUM(daily_confirmed)) * 100 AS death_rate 
FROM covid_19_states_cleaned 
GROUP BY State 
HAVING State!='India' 
ORDER BY death_rate DESC;

------------------------------------------------------------

-- Calculate monthly death rate per state
SELECT 
    State,
    MONTH(Date) AS month,
    (SUM(daily_deceased) * 1.0 / SUM(daily_confirmed)) * 100 AS death_rate
FROM covid_19_states_cleaned
WHERE State != 'India'
GROUP BY State, MONTH(Date)
ORDER BY State, month;

------------------------------------------------------------

-- Calculate monthly confirmed, recovered, deceased and rates using cumulative data
SELECT 
    State,
    YEAR(Date) AS year,
    MONTH(Date) AS month,

    MAX(Confirmed) - MIN(Confirmed) AS monthly_confirmed,
    MAX(Recovered) - MIN(Recovered) AS monthly_recovered,
    MAX(Deceased) - MIN(Deceased) AS monthly_deceased,

    ((MAX(Recovered) - MIN(Recovered)) * 1.0 /
     NULLIF(MAX(Confirmed) - MIN(Confirmed), 0)) * 100 AS recovery_rate,

    ((MAX(Deceased) - MIN(Deceased)) * 1.0 /
     NULLIF(MAX(Confirmed) - MIN(Confirmed), 0)) * 100 AS death_rate

FROM covid_19_states_cleaned
WHERE State != 'India'
GROUP BY State, YEAR(Date), MONTH(Date)
ORDER BY State, year, month;

------------------------------------------------------------

-- Find state with highest daily confirmed cases per month
SELECT covid_month, State, daily_confirmed
FROM (
    SELECT 
        EXTRACT(MONTH FROM Date) AS covid_month,
        State,
        daily_confirmed,
        RANK() OVER (
            PARTITION BY EXTRACT(MONTH FROM Date) 
            ORDER BY daily_confirmed DESC
        ) AS rnk
    FROM covid_19_states_cleaned
    WHERE State != 'India'
) ranked
WHERE rnk = 1
ORDER BY covid_month;

------------------------------------------------------------

-- Find state with highest recoveries per month
SELECT covid_month, State, Recovered
FROM (
    SELECT 
        EXTRACT(MONTH FROM Date) AS covid_month,
        State,
        Recovered,
        RANK() OVER (
            PARTITION BY EXTRACT(MONTH FROM Date) 
            ORDER BY Recovered DESC
        ) AS rnk
    FROM covid_19_states_cleaned
    WHERE State != 'India'
) ranked
WHERE rnk = 1
ORDER BY covid_month;
