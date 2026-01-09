-- =============================================================================
-- SQL PRACTICE: Day 1 - Basic Queries
-- =============================================================================
-- Author: Namrata Chauhan
-- Date: January 9, 2025
-- Purpose: Learning SQL fundamentals - SELECT, WHERE, filtering, logical operators
-- Lessons: Mode Analytics SQL Tutorial (Lessons 1-6)
-- =============================================================================

-- LEARNING OBJECTIVES FOR DAY 1:
-- 1. Understand SELECT statement structure
-- 2. Filter data using WHERE clause
-- 3. Use comparison operators (>, <, =, !=, >=, <=)
-- 4. Combine conditions with AND, OR, NOT
-- 5. Practice with healthcare-relevant scenarios

-- =============================================================================
-- SECTION 1: BASIC SELECT STATEMENTS
-- =============================================================================

-- QUERY 1: Select all columns from a table
-- Concept: Using * wildcard to retrieve all data
-- Use case: Initial data exploration
SELECT *
FROM patients
LIMIT 10;

-- Explanation: 
-- * means "all columns"
-- LIMIT 10 restricts to first 10 rows (prevents overwhelming output)
-- In real work: Always use LIMIT when exploring large tables


-- QUERY 2: Select specific columns
-- Concept: Choosing only relevant fields
-- Use case: Building focused reports, improving query performance
SELECT 
    patient_id,
    first_name,
    last_name,
    date_of_birth,
    gender,
    blood_type
FROM patients
LIMIT 25;

-- Explanation:
-- Lists exact columns needed (better performance than SELECT *)
-- Each column on separate line (improves readability)
-- Comma after each column except the last one


-- QUERY 3: Select with column aliasing
-- Concept: Renaming columns for clarity
-- Use case: Creating user-friendly reports
SELECT 
    patient_id AS id,
    first_name || ' ' || last_name AS full_name,
    YEAR(CURRENT_DATE) - YEAR(date_of_birth) AS age_calculated
FROM patients
LIMIT 20;

-- Explanation:
-- AS keyword creates aliases (new display names)
-- || concatenates (combines) text fields
-- Can perform calculations in SELECT (derived columns)


-- =============================================================================
-- SECTION 2: FILTERING WITH WHERE - COMPARISON OPERATORS
-- =============================================================================

-- QUERY 4: Filter by age (greater than)
-- Concept: Comparison operators for numerical filtering
-- Use case: Identifying elderly patients for geriatric programs
SELECT 
    patient_id,
    first_name,
    last_name,
    age,
    diagnosis
FROM patient_records
WHERE age >= 65;

-- Explanation:
-- >= means "greater than or equal to"
-- Only returns rows where condition is TRUE
-- Other operators: >, <, <=, =, !=


-- QUERY 5: Filter by exact diagnosis match
-- Concept: Filtering text/categorical data
-- Use case: Finding all patients with specific condition for clinical study
SELECT 
    patient_id,
    first_name,
    last_name,
    diagnosis,
    admission_date
FROM patient_records
WHERE diagnosis = 'Type 2 Diabetes';

-- Explanation:
-- Text values must be in 'single quotes'
-- = checks for exact match (case-sensitive in some databases)
-- Use for categorical data: diagnosis, gender, treatment type


-- =============================================================================
-- SECTION 3: LOGICAL OPERATORS - AND (ALL conditions must be true)
-- =============================================================================

-- QUERY 6: Multiple conditions with AND
-- Concept: Combining filters (stricter criteria)
-- Use case: Identifying high-risk patient subgroup
SELECT 
    patient_id,
    age,
    gender,
    diagnosis,
    bmi
FROM patient_records
WHERE age > 60 
    AND gender = 'Female'
    AND diagnosis = 'Hypertension';

-- Explanation:
-- AND requires ALL conditions to be TRUE
-- If ANY condition is FALSE, row is excluded
-- Results in FEWER rows (stricter filter)
-- Indentation improves readability


-- QUERY 7: AND with date range
-- Concept: Filtering by date boundaries
-- Use case: Analyzing admissions in specific time period
SELECT 
    patient_id,
    admission_date,
    discharge_date,
    diagnosis,
    length_of_stay
FROM hospital_admissions
WHERE admission_date >= '2024-01-01' 
    AND admission_date <= '2024-12-31'
    AND length_of_stay > 7;

-- Explanation:
-- Dates in 'YYYY-MM-DD' format (standard SQL format)
-- Can combine date filters with other conditions
-- Useful for time-based analysis


-- =============================================================================
-- SECTION 4: LOGICAL OPERATORS - OR (AT LEAST ONE condition must be true)
-- =============================================================================

-- QUERY 8: Multiple conditions with OR
-- Concept: Alternative criteria (more permissive)
-- Use case: Finding patients with any chronic condition
SELECT 
    patient_id,
    diagnosis,
    treatment_plan
FROM patient_records
WHERE diagnosis = 'Type 2 Diabetes' 
    OR diagnosis = 'Hypertension'
    OR diagnosis = 'Heart Disease'
    OR diagnosis = 'Chronic Kidney Disease';

-- Explanation:
-- OR requires AT LEAST ONE condition to be TRUE
-- If ANY condition is TRUE, row is included
-- Results in MORE rows (permissive filter)


-- QUERY 9: Combining AND with OR (using parentheses)
-- Concept: Complex filtering logic
-- Use case: Identifying elderly patients with specific high-risk conditions
SELECT 
    patient_id,
    age,
    diagnosis,
    admission_date
FROM patient_records
WHERE age >= 65
    AND (diagnosis = 'Heart Disease' 
         OR diagnosis = 'Stroke'
         OR diagnosis = 'Pneumonia');

-- Explanation:
-- Parentheses () control order of operations
-- First: Evaluate (diagnosis = X OR diagnosis = Y OR diagnosis = Z)
-- Then: AND that result with age >= 65
-- Without parentheses, logic would be different!


-- =============================================================================
-- SECTION 5: ADDITIONAL OPERATORS
-- =============================================================================

-- QUERY 10: NOT operator (exclusion)
-- Concept: Excluding specific values
-- Use case: Analyzing all admissions except routine/minor cases
SELECT 
    patient_id,
    diagnosis,
    admission_type
FROM patient_records
WHERE diagnosis != 'Common Cold'
    AND diagnosis != 'Routine Checkup'
    AND admission_type != 'Outpatient';

-- Explanation:
-- != means "not equal to" (can also use <>)
-- Excludes rows matching the condition
-- Useful for removing irrelevant/noise data


-- =============================================================================
-- KEY TAKEAWAYS FROM DAY 1
-- =============================================================================

-- 1. SELECT specifies WHICH COLUMNS to retrieve
-- 2. FROM specifies WHICH TABLE to query
-- 3. WHERE filters WHICH ROWS to include
-- 4. LIMIT restricts NUMBER OF RESULTS (always use when testing!)

-- 5. COMPARISON OPERATORS:
--    = (equal), != or <> (not equal)
--    > (greater), < (less), >= (greater/equal), <= (less/equal)

-- 6. LOGICAL OPERATORS:
--    AND = ALL conditions must be TRUE (stricter, fewer results)
--    OR = AT LEAST ONE condition TRUE (permissive, more results)
--    NOT = EXCLUDE matching rows

-- 7. BEST PRACTICES:
--    - Use LIMIT when testing queries on large tables
--    - Indent AND/OR conditions for readability
--    - Use parentheses () when combining AND and OR
--    - Add comments to explain what each query does
--    - Format queries consistently (columns on separate lines)

-- =============================================================================
-- PRACTICE NOTES & QUESTIONS
-- =============================================================================

-- What I learned today:
-- - SQL basics: SELECT, FROM, WHERE, LIMIT
-- - How to filter numerical and text data
-- - Difference between AND (strict) and OR (permissive)
-- - Importance of parentheses in complex conditions

-- Questions to explore tomorrow:
-- - How to join multiple tables? (Day 2 topic: JOINs)
-- - How to calculate totals/averages by group? (Day 2 topic: GROUP BY)
-- - How to handle NULL values in WHERE clause?

-- =============================================================================
-- NEXT STEPS
-- =============================================================================

-- Day 2 Goals:
-- 1. Learn SQL JOINs (INNER, LEFT, RIGHT) - combining multiple tables
-- 2. Learn GROUP BY and aggregate functions (COUNT, SUM, AVG, MIN, MAX)
-- 3. Practice with real healthcare dataset (Medicare or NHANES)
-- 4. Write 10 more queries with JOINs and aggregations

-- =============================================================================
-- END OF DAY 1 QUERIES
-- =============================================================================
