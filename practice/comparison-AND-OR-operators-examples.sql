-- =============================================================================
-- PRACTICE EXAMPLES: COMPARISON OPERATORS, AND, OR
-- =============================================================================
-- Author: Namita Singh
-- Date: January 10, 2025
-- Source: Mode Analytics SQL Tutorial - Lessons on WHERE, Comparison, AND, OR
-- Purpose: Hands-on practice with filtering and logical operators
-- =============================================================================

-- These are my practice queries from Mode Analytics tutorial.
-- Covering comparison operators (=, !=, >, <, >=, <=) and logical operators (AND, OR).
-- Includes both numerical and text comparisons, plus arithmetic in SQL.

-- =============================================================================
-- PART 1: NUMERICAL COMPARISONS
-- =============================================================================

-- EXAMPLE 1: Greater Than (>)
-- Question: Where West Region produced more than 30,000 housing units
-- Concept: > excludes the number itself (31+ shown, not 30)
SELECT *
FROM tutorial.us_housing_units
WHERE west > 30;
-- Returns: Only rows where west is 31, 32, 40, 50... (NOT 30 exactly)
-- Healthcare analogy: Find patients over 65 (66, 67, 68... not 65 itself)


-- EXAMPLE 2: Greater Than (>) - Different threshold
-- Question: Did West Region ever produce more than 50,000 housing units?
-- Concept: Same operator, different value - testing if condition ever met
SELECT *
FROM tutorial.us_housing_units
WHERE west > 50;
-- If results returned = YES, West exceeded 50k at least once
-- Healthcare analogy: Did any patient have BMI > 40 (severe obesity)?


-- EXAMPLE 3: Less Than or Equal To (<=)
-- Question: Did South Region ever produce 20,000 or fewer housing units?
-- Concept: <= INCLUDES the number itself (20 and below)
SELECT *
FROM tutorial.us_housing_units
WHERE south <= 20;
-- Returns: 10, 15, 18, 19, 20 (20 IS included!)
-- Comparison: < would exclude 20, <= includes it
-- Healthcare analogy: Pediatric patients age <= 18 (includes 18-year-olds)


-- =============================================================================
-- PART 2: TEXT/STRING COMPARISONS (Alphabetical Order)
-- =============================================================================

-- EXAMPLE 4: Not Equal To (!=) with Text
-- Concept: != excludes exact matches
SELECT *
FROM tutorial.us_housing_units
WHERE month_name != 'January';
-- Returns: February, March, April... December (everything EXCEPT January)
-- Alternative syntax: <> works the same as !=
-- Healthcare analogy: All patients who are NOT diabetic


-- EXAMPLE 5: Greater Than (>) with Text - Alphabetical comparison
-- Concept: SQL compares text ALPHABETICALLY (like a dictionary)
-- 'January' in alphabet: A-D-F come before J, J-M-N-O-S come after J
SELECT *
FROM tutorial.us_housing_units
WHERE month_name > 'January';
-- Returns: July, June, March, May, November, October, September
-- EXCLUDES: January (equal, not greater), April, August, December, February
-- Why? J-u-l-y comes after J-a-n-u-a-r-y alphabetically
-- Healthcare analogy: Patients whose last name > 'Smith' (Taylor, Williams...)


-- EXAMPLE 6: Greater Than (>) with Single Letter
-- Concept: Comparing to single letter 'J'
SELECT *
FROM tutorial.us_housing_units
WHERE month_name > 'J';
-- Returns: July, June (both start with J-u which > J alone), March, May, November, October, September
-- EXCLUDES: January (J-a < J alone in comparison), plus A-D-F months
-- Complex rule: Longer strings starting with same letter are "greater"


-- EXAMPLE 7: Equal To (=) with Text - Exact match
-- Question: Show only rows for February
-- Concept: = requires EXACT match (case-sensitive in some databases)
SELECT *
FROM tutorial.us_housing_units
WHERE month_name = 'February';
-- Returns: ONLY February rows (exact match)
-- Note: 'February' ≠ 'february' ≠ 'FEBRUARY' in case-sensitive databases
-- Healthcare analogy: diagnosis = 'Type 2 Diabetes' (exact, not 'Diabetes')


-- EXAMPLE 8: Less Than (<) with Text - TRICKY ALPHABETICAL
-- Question: Month names starting with "N" or earlier letter in alphabet
-- Concept: Lowercase 'o' comparison (case matters in SQL!)
SELECT *
FROM tutorial.us_housing_units
WHERE month_name < 'o';
-- Returns: April, August, December, February, January, July, June, March, May, November, October
-- EXCLUDES: September (S > o)
-- Why October included? Capital 'O' in October < lowercase 'o' (ASCII: 79 < 111)
-- This is confusing! Better practice: WHERE LOWER(month_name) < 'o'
-- Healthcare analogy: Last names A-M (before 'N')


-- =============================================================================
-- PART 3: ARITHMETIC IN SQL (Calculations in SELECT)
-- =============================================================================

-- EXAMPLE 9: Basic Addition (+)
-- Concept: Create new calculated column using arithmetic
SELECT year,
       month,
       west,
       south,
       west + south AS south_plus_west
FROM tutorial.us_housing_units;
-- Creates new column = west + south (doesn't modify original data)
-- AS south_plus_west names the calculated column
-- Healthcare analogy: emergency_admits + planned_admits AS total_admissions


-- EXAMPLE 10: Complex Arithmetic (Multiple operations)
-- Concept: Order of operations (PEMDAS) - Multiplication before Add/Subtract
SELECT year,
       month,
       west,
       south,
       west + south - 4 * year AS nonsense_column
FROM tutorial.us_housing_units;
-- Calculation: west + south - (4 * year)
-- Example: 150 + 200 - (4 * 2020) = 350 - 8080 = -7730
-- Called "nonsense" because result has no real-world meaning!
-- Key lesson: Order matters! 4*year happens FIRST (multiplication priority)
-- Healthcare analogy: (age * 2) + (BMI * 1.5) - 100 AS risk_score


-- EXAMPLE 11: Adding Multiple Columns
-- Question: Calculate sum of all four regions
-- Concept: Multiple additions in one expression
SELECT year,
       month,
       west,
       south,
       midwest,
       northeast,
       west + south + midwest + northeast AS usa_total
FROM tutorial.us_housing_units;
-- Adds four columns together for total
-- Healthcare analogy: morning_dose + afternoon_dose + evening_dose + night_dose


-- EXAMPLE 12: Division (/) for Average
-- Concept: Parentheses control order - add first, then divide
SELECT year,
       month,
       west,
       south,
       (west + south) / 2 AS south_west_avg
FROM tutorial.us_housing_units;
-- CORRECT: (west + south) / 2 = add first, divide by 2
-- WRONG: west + south / 2 = divides only south by 2, then adds west!
-- Parentheses are CRITICAL for averages
-- Healthcare analogy: (systolic_bp + diastolic_bp) / 2 AS mean_arterial_pressure


-- EXAMPLE 13: Arithmetic in WHERE Clause
-- Question: Where West > (Midwest + Northeast combined)
-- Concept: Can use calculations in WHERE for filtering!
SELECT year,
       month,
       west,
       south,
       midwest,
       northeast
FROM tutorial.us_housing_units
WHERE west > (midwest + northeast);
-- Compares west column to SUM of midwest + northeast
-- Only shows rows where west is greater than that combined total
-- Healthcare analogy: WHERE total_cholesterol > (hdl + ldl)


-- EXAMPLE 14: Complex Percentage Calculation - THE HARDEST!
-- Question: Calculate percentage each region represents, year 2000+
-- Concept: (Part / Total) * 100 = Percentage
SELECT year,
       month,
       west / (west + south + midwest + northeast) * 100 AS west_pct,
       south / (west + south + midwest + northeast) * 100 AS south_pct,
       midwest / (west + south + midwest + northeast) * 100 AS midwest_pct,
       northeast / (west + south + midwest + northeast) * 100 AS northeast_pct
FROM tutorial.us_housing_units
WHERE year >= 2000;
-- Formula breakdown:
-- Total = west + south + midwest + northeast
-- West % = (west / total) * 100
-- Example: 150/(150+200+120+130)*100 = 150/600*100 = 25%
-- All percentages add to 100%!
-- >= 2000 filters to year 2000 and later (includes 2000)
-- Healthcare analogy: Patient percentage by diagnosis type


-- =============================================================================
-- KEY TAKEAWAYS: COMPARISON OPERATORS
-- =============================================================================

-- NUMERICAL:
-- >   Greater than (excludes the number: 65 > 50 yes, 50 > 50 no)
-- <   Less than (excludes: 30 < 40 yes, 40 < 40 no)
-- >=  Greater or equal (includes: 65 >= 65 yes!)
-- <=  Less or equal (includes: 30 <= 30 yes!)
-- =   Equal to (exact match)
-- !=  Not equal (also: <>)

-- TEXT (ALPHABETICAL):
-- Works like dictionary order
-- 'Apple' < 'Banana' (A comes before B)
-- Case sensitivity matters!
-- Use ILIKE for case-insensitive matching

-- ARITHMETIC:
-- + - * / work in SELECT and WHERE
-- Order of operations: Parentheses → Multiply/Divide → Add/Subtract
-- Use AS to name calculated columns
-- Always ask: "Does this calculation have real-world meaning?"


-- =============================================================================
-- PART 4: AND OPERATOR (All conditions must be TRUE)
-- =============================================================================

-- EXAMPLE 1: Basic AND - Two conditions
-- Concept: AND = BOTH conditions must be TRUE (strict filter)
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2012 
  AND year_rank <= 10;
-- Returns: Only songs from 2012 that are ALSO in top 10
-- If year = 2012 but rank = 15 → EXCLUDED (second condition fails)
-- If year = 2011 but rank = 5 → EXCLUDED (first condition fails)
-- BOTH must be TRUE!
-- Healthcare analogy: age >= 65 AND gender = 'Female' (elderly women only)


-- EXAMPLE 2: AND with Three Conditions + ILIKE (Pattern Matching)
-- Concept: Multiple AND conditions + wildcard pattern matching
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2012
  AND year_rank <= 10
  AND "group_name" ILIKE '%feat%';
-- Returns: 2012 top-10 songs with collaborations ("feat" in name)
-- ALL THREE must be TRUE: 2012 + top 10 + contains "feat"
-- ILIKE = case-insensitive LIKE
-- %feat% = contains "feat" anywhere (% = wildcard for any characters)
-- Matches: "Rihanna feat. Calvin Harris", "Eminem Feat. Dr. Dre", "FEATURED"
-- Healthcare analogy: age >= 65 AND diagnosis ILIKE '%diabetes%' AND city = 'Melbourne'


-- EXAMPLE 3: AND with ILIKE Pattern - Specific artist search
-- Question: Top-10 hits where Ludacris is part of the group
-- Concept: Filtering by rank AND pattern in text field
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank <= 10
  AND "group_name" ILIKE '%ludacris%';
-- Returns: Top-10 songs from ANY year featuring Ludacris
-- No year filter = searches all years
-- ILIKE '%ludacris%' matches:
--   "Ludacris", "Ludacris feat. Usher", "Taio Cruz ft. Ludacris"
-- Case insensitive: LUDACRIS, Ludacris, ludacris all match
-- Healthcare analogy: priority_level <= 3 AND diagnosis ILIKE '%cancer%'


-- =============================================================================
-- KEY CONCEPTS: ILIKE and Wildcards
-- =============================================================================

-- ILIKE vs LIKE vs =
-- ILIKE: Case-INsensitive pattern matching ('Text' = 'text' = 'TEXT')
-- LIKE:  Case-sensitive pattern matching ('Text' ≠ 'text')
-- =:     Exact match only (no wildcards)

-- Wildcard Patterns:
-- '%text%'   = Contains "text" anywhere
-- 'text%'    = Starts with "text"
-- '%text'    = Ends with "text"
-- '%te%xt%'  = Contains "te" then later "xt"


-- =============================================================================
-- KEY TAKEAWAYS: AND OPERATOR
-- =============================================================================

-- AND Logic:
-- ALL conditions must be TRUE
-- If ANY condition is FALSE → entire row excluded
-- Results in FEWER rows (stricter than OR)

-- Visual:
-- Condition 1: TRUE  ✅
-- Condition 2: TRUE  ✅  → Result: SHOW ✅
-- Condition 3: TRUE  ✅

-- Condition 1: TRUE  ✅
-- Condition 2: FALSE ❌  → Result: HIDE ❌
-- Condition 3: TRUE  ✅

-- Use cases:
-- - Finding specific subsets (elderly females, 2012 top-10 hits)
-- - Combining numerical and text filters
-- - Pattern matching with additional criteria


-- =============================================================================
-- PART 5: OR OPERATOR (At least ONE condition must be TRUE)
-- =============================================================================

-- EXAMPLE 1: Basic OR - Two conditions
-- Concept: OR = AT LEAST ONE condition TRUE (permissive filter)
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank = 5 
   OR artist = 'Gotye';
-- Returns: Songs that are rank 5 (any artist) OR by Gotye (any rank) OR both!
-- If rank = 5 and artist = Adele → INCLUDED (first condition TRUE)
-- If rank = 12 and artist = Gotye → INCLUDED (second condition TRUE)
-- If rank = 5 and artist = Gotye → INCLUDED (both TRUE!)
-- If rank = 8 and artist = Drake → EXCLUDED (both FALSE)
-- Healthcare analogy: age >= 80 OR diagnosis = 'Heart Failure' (high-risk patients)


-- EXAMPLE 2: OR Inside Parentheses with AND - CRITICAL CONCEPT!
-- Concept: Parentheses group OR conditions when combining with AND
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year = 2013
  AND ("group_name" ILIKE '%macklemore%' OR "group_name" ILIKE '%timberlake%');
-- CORRECT logic: year = 2013 AND (Macklemore OR Timberlake)
-- Returns: 2013 songs featuring Macklemore OR Timberlake
-- Parentheses are CRITICAL! Without them:
--   year = 2013 AND Macklemore OR Timberlake
--   = (2013 AND Macklemore) OR Timberlake
--   = 2013 Macklemore songs + ALL Timberlake songs (any year!) WRONG!
-- Healthcare analogy: admission_year = 2024 AND (diagnosis = 'Diabetes' OR diagnosis = 'Hypertension')


-- EXAMPLE 3: OR with Pattern Matching - Practice question
-- Question: Top-10 songs featuring Katy Perry OR Bon Jovi
-- Concept: Multiple patterns combined with OR, filtered by rank with AND
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE year_rank <= 10
  AND ("group_name" ILIKE '%katy perry%' OR "group_name" ILIKE '%bon jovi%');
-- NOTE: Original had typo - "group" should be "group_name" in second OR
-- Returns: Top-10 songs from any year with either artist
-- Parentheses ensure: (top 10) AND (Katy Perry OR Bon Jovi)
-- Healthcare analogy: priority <= 3 AND (diagnosis ILIKE '%diabetes%' OR diagnosis ILIKE '%heart disease%')


-- EXAMPLE 4: BETWEEN with OR - Multiple date ranges
-- Question: Songs with "California" in title from 1970s OR 1990s
-- Concept: BETWEEN for ranges, OR for multiple time periods, parentheses for grouping
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE song_name LIKE '%California%'
  AND (year BETWEEN 1970 AND 1979 OR year BETWEEN 1990 AND 1999);
-- BETWEEN is inclusive: 1970 AND 1979 includes both 1970 and 1979
-- BETWEEN X AND Y = same as: >= X AND <= Y
-- Returns: California songs from 1970-1979 OR 1990-1999 (excludes 1980s, 2000s)
-- Parentheses prevent: (California AND 70s) OR (90s any song) - WRONG!
-- Note: LIKE is case-sensitive; ILIKE would be better
-- Healthcare analogy: diagnosis ILIKE '%diabetes%' AND (year BETWEEN 2000 AND 2005 OR year BETWEEN 2015 AND 2020)


-- EXAMPLE 5: OR with Before/After Pattern - Excluding middle period
-- Question: Dr. Dre songs before 2001 OR after 2009
-- Concept: <= and >= to create "not in middle range" filter
SELECT *
FROM tutorial.billboard_top_100_year_end
WHERE "group_name" ILIKE '%dr. dre%'
  AND (year <= 2000 OR year >= 2010);
-- Returns: Dr. Dre songs from 2000 and earlier OR 2010 and later
-- EXCLUDES: 2001-2009 (the middle decade)
-- Timeline: [...1999, 2000] ✅ | [2001-2009] ❌ | [2010, 2011...] ✅
-- Use case: Comparing early vs late career, excluding transition period
-- Healthcare analogy: (enrollment_year <= 2009 OR enrollment_year >= 2020) - exclude transition


-- =============================================================================
-- KEY TAKEAWAYS: OR OPERATOR
-- =============================================================================

-- OR Logic:
-- AT LEAST ONE condition must be TRUE
-- If ALL conditions are FALSE → row excluded
-- Results in MORE rows (more permissive than AND)

-- Visual:
-- Condition 1: TRUE  ✅
-- Condition 2: FALSE ❌  → Result: SHOW ✅ (one TRUE is enough!)

-- Condition 1: FALSE ❌
-- Condition 2: FALSE ❌  → Result: HIDE ❌ (all FALSE)

-- AND vs OR Comparison:
-- AND = Stricter (all must be TRUE) → Fewer results
-- OR  = Permissive (one TRUE enough) → More results

-- CRITICAL RULE: Use parentheses when combining AND + OR
-- CORRECT: WHERE year = 2013 AND (artist = 'A' OR artist = 'B')
-- WRONG:   WHERE year = 2013 AND artist = 'A' OR artist = 'B'

-- Common OR Patterns:
-- Multiple values: status = 'Active' OR status = 'Pending'
-- Range exclusion: year <= 2000 OR year >= 2010
-- Pattern matching: name ILIKE '%smith%' OR name ILIKE '%jones%'
-- With BETWEEN: (year BETWEEN X AND Y OR year BETWEEN A AND B)


-- =============================================================================
-- COMPREHENSIVE SUMMARY: COMPARISON + AND + OR
-- =============================================================================

-- COMPARISON OPERATORS:
-- Numbers: >, <, >=, <=, =, !=
-- Text: Works alphabetically (like dictionary)
-- Arithmetic: Can calculate in SELECT and WHERE

-- LOGICAL OPERATORS:
-- AND: ALL conditions must be TRUE (strict)
-- OR:  AT LEAST ONE condition TRUE (permissive)
-- Parentheses: Group OR conditions when combining with AND

-- PATTERN MATCHING:
-- ILIKE: Case-insensitive (recommended for text searches)
-- LIKE:  Case-sensitive
-- %:     Wildcard (any characters)

-- BEST PRACTICES:
-- 1. Use semicolons (;) to end statements (professional standard)
-- 2. Add parentheses when mixing AND/OR to control logic
-- 3. Use ILIKE instead of LIKE for case-insensitive searches
-- 4. Always ask: "Does my calculation have real-world meaning?"
-- 5. Test complex queries on small samples first (use LIMIT)
-- 6. Comment your code to explain WHAT and WHY


-- =============================================================================
-- HEALTHCARE EXAMPLES REFERENCE
-- =============================================================================

-- High-risk patients (elderly OR severely ill):
-- WHERE age >= 80 OR diagnosis = 'Critical';

-- Specific year + multiple diagnoses:
-- WHERE admission_year = 2024 AND (diagnosis = 'Diabetes' OR diagnosis = 'Hypertension');

-- Historical comparison (exclude middle period):
-- WHERE study_year <= 2010 OR study_year >= 2020;

-- Pattern matching with multiple criteria:
-- WHERE (last_name ILIKE '%smith%' OR last_name ILIKE '%jones%') AND age >= 65;

-- Percentage calculation:
-- SELECT diagnosis,
--        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patients) AS percentage
-- FROM patients
-- GROUP BY diagnosis;


-- =============================================================================
-- NEXT LEARNING STEPS
-- =============================================================================

-- Day 2 Goals:
-- 1. Learn SQL JOINs (INNER, LEFT, RIGHT, FULL) - combining multiple tables
-- 2. Learn GROUP BY and aggregate functions (COUNT, SUM, AVG, MIN, MAX)
-- 3. Practice with real healthcare datasets
-- 4. Build portfolio project combining all skills

-- Skills Mastered Today:
-- ✅ SELECT with filtering (WHERE)
-- ✅ Comparison operators (numerical and text)
-- ✅ Arithmetic in SQL (calculations)
-- ✅ AND operator (all conditions)
-- ✅ OR operator (at least one condition)
-- ✅ Pattern matching (ILIKE, wildcards)
-- ✅ BETWEEN for ranges
-- ✅ Parentheses for logic grouping


-- =============================================================================
-- END OF PRACTICE SESSION - COMPARISON, AND, OR
-- =============================================================================
-- Total examples practiced: 22 (14 comparison + 3 AND + 5 OR)
-- Time invested: ~2 hours
-- Concepts mastered: Filtering, logical operators, arithmetic, pattern matching
-- Ready for: JOINs (combining multiple tables)
-- =============================================================================
