USE US_household_income;

SELECT *
FROM household_income_statistics;

# renaming the id column
ALTER TABLE household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

# checking for null values
	# checking for duplicates
    SELECT *
    FROM (SELECT id, state_name,
		  ROW_NUMBER() OVER(PARTITION BY id) AS repition
          FROM household_income_statistics) AS repition_tagged_table
	WHERE repition > 1; # no duplicates found in data
