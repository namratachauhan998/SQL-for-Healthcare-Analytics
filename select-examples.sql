-- =============================================================================
-- PRACTICE EXAMPLES FROM MODE ANALYTICS TUTORIAL
-- =============================================================================
-- Author: Namrata Chauhan
-- Date: January 9, 2025
-- Source: Mode Analytics SQL Tutorial - SELECT and Column Aliasing Lessons
-- Purpose: Hands-on practice with basic SQL syntax
-- =============================================================================

-- These are my raw practice queries while learning SQL fundamentals.
-- They show my learning progression from simple to more complex queries.

-- =============================================================================
-- PROGRESSION 1: Learning SELECT with specific columns
-- =============================================================================

-- PRACTICE 1: Selecting specific columns
-- Learned: How to choose only the columns I need
SELECT year,
       month,
       west
FROM tutorial.us_housing_units;

-- =============================================================================
-- PROGRESSION 2: Understanding SELECT * (all columns)
-- =============================================================================

-- PRACTICE 2: Select all columns (multi-line format)
SELECT *
FROM tutorial.us_housing_units;

-- PRACTICE 3: Same query, one-line format
-- Learned: SQL doesn't care about line breaks
SELECT * FROM tutorial.us_housing_units;

-- PRACTICE 4: Repeating to build muscle memory
SELECT *
FROM tutorial.us_housing_units;

-- =============================================================================
-- PROGRESSION 3: Learning Column Aliases (AS keyword)
-- =============================================================================

-- PRACTICE 5: Single column with quoted alias
-- Learned: AS renames columns, quotes allow spaces in names
SELECT west AS "West Region"
FROM tutorial.us_housing_units;

-- PRACTICE 6: Multiple columns with underscore aliases
-- Learned: Underscores avoid needing quotes
SELECT west AS West_Region,
       south AS South_Region
FROM tutorial.us_housing_units;

-- =============================================================================
-- PROGRESSION 4: Selecting multiple columns (no aliases)
-- =============================================================================

-- PRACTICE 7: Selecting many columns with clean formatting
-- Learned: Professional multi-line formatting, one column per line
SELECT year,
       month,
       month_name,
       west,
       midwest,
       south,
       northeast
FROM tutorial.us_housing_units;

-- =============================================================================
-- PROGRESSION 5: Combining everything - Multiple columns + Aliases
-- =============================================================================

-- PRACTICE 8: All columns renamed with professional aliases
-- Learned: Can alias every column, creates report-ready output
SELECT year AS "Year",
       month AS "Month",
       month_name AS "Month Name",
       west AS "West",
       midwest AS "Midwest",
       south AS "South",
       northeast AS "Northeast"
FROM tutorial.us_housing_units;

-- =============================================================================
-- KEY TAKEAWAYS FROM PRACTICE
-- =============================================================================

-- 1. SELECT * = all columns (good for exploration)
-- 2. SELECT column1, column2 = specific columns (better for focused analysis)
-- 3. AS keyword = rename columns for display (doesn't change database)
-- 4. Quoted aliases = "Column Name" (allows spaces, capitals)
-- 5. Underscore aliases = Column_Name (no quotes needed)
-- 6. Multi-line formatting = easier to read and maintain
-- 7. One-line formatting = okay for very simple queries

-- CONCEPTS MASTERED:
-- ✅ SELECT syntax
-- ✅ FROM clause
-- ✅ Column selection
-- ✅ Column aliasing
-- ✅ Professional SQL formatting

-- =============================================================================
-- END OF PRACTICE SESSION
-- =============================================================================
