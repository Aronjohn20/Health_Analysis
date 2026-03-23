-- =====================================================
-- COVID-19 STATE-WISE DATA ANALYSIS (SQL)
-- =====================================================


-- ================================
-- EXPLORATORY DATA ANALYSIS
-- ================================

-- 1. State with Highest Confirmed Cases
SELECT State, MAX(Confirmed) AS max_confirmed
FROM covid_19_states
GROUP BY State
HAVING State != 'India'
ORDER BY max_confirmed DESC;


-- 2. State with Highest Deaths
SELECT State, MAX(Deceased) AS max_deceased
FROM covid_19_states
GROUP BY State
HAVING State != 'India'
ORDER BY max_deceased DESC;


-- 3. Total Recoveries in India
SELECT State, SUM(Recovered) AS total_recovered
FROM covid_19_states
GROUP BY State
HAVING State = 'India';


-- 4. Total Recoveries by Each State
SELECT State, SUM(Recovered) AS total_recovered
FROM covid_19_states
GROUP BY State
HAVING State != 'India';



-- ================================
-- TIME-BASED ANALYSIS
-- ================================

-- 5. Monthly Case Trends
SELECT MONTH(Date) AS covid_month, MAX(Confirmed) AS max_confirmed
FROM covid_19_states_cleaned
GROUP BY covid_month
ORDER BY covid_month;


-- 6. Month with Highest Confirmed Cases (State-wise)
SELECT covid_month, State, Confirmed
FROM (
    SELECT 
        EXTRACT(MONTH FROM Date) AS covid_month,
        State,
        Confirmed,
        RANK() OVER (
            PARTITION BY EXTRACT(MONTH FROM Date)
            ORDER BY Confirmed DESC
        ) AS rnk
    FROM covid_19_states_cleaned
    WHERE State != 'India'
) ranked
WHERE rnk = 1
ORDER BY covid_month;


-- 7. Month with Highest Recoveries (State-wise)
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



-- ================================
-- RATE-BASED ANALYSIS
-- ================================

-- 8. Recovery Rate by State
SELECT 
    State, 
    (SUM(Recovered) / SUM(Confirmed)) * 100 AS recovery_rate
FROM covid_19_states_cleaned
GROUP BY State
HAVING State != 'India'
ORDER BY recovery_rate DESC;


-- 9. Death Rate by State
SELECT 
    State, 
    (SUM(Deceased) / SUM(Confirmed)) * 100 AS death_rate
FROM covid_19_states_cleaned
GROUP BY State
HAVING State != 'India'
ORDER BY death_rate DESC;


-- 10. Total Tests Conducted by State
SELECT 
    State, 
    SUM(Tested) AS tests
FROM covid_19_states_cleaned
GROUP BY State
HAVING State != 'India'
ORDER BY tests DESC;



-- ================================
-- DATA CORRECTION
-- ================================

-- Fill missing Tested values using average ratio
WITH avg_calc AS (
    SELECT AVG(Confirmed * 1.0 / Tested) AS avg_ratio
    FROM covid_19_states_cleaned
    WHERE Tested IS NOT NULL AND Tested != 0
)

UPDATE covid_19_states_cleaned
SET Tested = Confirmed / (SELECT avg_ratio FROM avg_calc)
WHERE Tested IS NULL;
