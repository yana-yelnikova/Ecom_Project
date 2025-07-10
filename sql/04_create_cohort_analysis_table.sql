%sql
CREATE OR REPLACE TABLE workspace.default.cohort_analysis AS -- Creates or replaces a table named 'cohort_analysis' in the 'workspace.default' schema
SELECT * FROM _sqldf; -- Selects all columns and rows from '_sqldf' (which holds the result of the immediately preceding query) to populate the new table