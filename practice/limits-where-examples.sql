-- =============================================================================
-- LIMIT PRACTICE 
-- =============================================================================

-- EXAMPLE 1: LIMIT 100 - Show first 100 rows
SELECT *
FROM tutorial.us_housing_units
LIMIT 100;
-- Use case: Quick data exploration without loading entire table

-- EXAMPLE 2: LIMIT 15 - Show first 15 rows
SELECT *
FROM tutorial.us_housing_units
LIMIT 15;
-- Practice: Different LIMIT values for different needs

-- KEY TAKEAWAY: LIMIT controls HOW MANY rows returned

-- =============================================================================
-- WHERE PRACTICE 
-- =============================================================================

-- EXAMPLE 1: Filter by month
SELECT *
FROM tutorial.us_housing_units
WHERE month = 1;
-- Returns: Only January data (month = 1)
-- Use case: Analyzing seasonal patterns, filtering specific time periods

-- KEY TAKEAWAY: WHERE controls WHICH rows returned (based on conditions)

-- =============================================================================
-- COMBINING WHERE + LIMIT
-- =============================================================================

-- Example: Get first 10 January records
SELECT *
FROM tutorial.us_housing_units
WHERE month = 1
LIMIT 10;
-- First filters to January, then shows only first 10 results
