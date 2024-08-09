USE us_household_income;

SELECT *
FROM household_income;

# Exploring area of land, water in each states
	SELECT State_Name, SUM(ALand) AS land_area, SUM(AWater) AS water_area
	FROM household_income
	GROUP BY State_Name
	ORDER BY land_area DESC;
    
    # top 10 states by land area
    SELECT State_Name, SUM(ALand) AS land_area, SUM(AWater) AS water_area
	FROM household_income
	GROUP BY State_Name
	ORDER BY land_area DESC
    LIMIT 10;
    
	# top 10 states by water area
    SELECT State_Name, SUM(ALand) AS land_area, SUM(AWater) AS water_area
	FROM household_income
	GROUP BY State_Name
	ORDER BY water_area DESC
    LIMIT 10;

# Exploring mean, medean of income of states
	SELECT hi.State_Name, AVG(his.Mean) AS mean, AVG(his.Median) AS median
    FROM household_income AS hi
    JOIN household_income_statistics AS his
		ON hi.id = his.id
	GROUP BY State_Name
    ORDER BY mean DESC
    LIMIT 10; # states with top 10 median household incomes
    
	SELECT hi.State_Name, AVG(his.Mean) AS mean, AVG(his.Median) AS median
    FROM household_income AS hi
    JOIN household_income_statistics AS his
		ON hi.id = his.id
	GROUP BY State_Name
    ORDER BY mean 
    LIMIT 10; # states with Bottom 10 median household incomes
    
    # checking for the correlation between type of place and the mean median of income
	SELECT hi.`Type`,COUNT(`Type`), AVG(his.Mean) AS mean, AVG(his.Median) AS median
    FROM household_income AS hi
    JOIN household_income_statistics AS his
		ON hi.id = his.id
	GROUP BY `Type`
    ORDER BY mean; 
    
    # cities and house hold income
    SELECT hi.State_Name, hi.City, AVG(his.Mean) AS mean, AVG(his.Median) AS median
    FROM household_income AS hi
    JOIN household_income_statistics AS his
		ON hi.id = his.id
	WHERE his.Mean >0 
		AND his.Median > 0
	GROUP BY `City`, hi.State_Name
    ORDER BY median DESC
    LIMIT 10; #cities with top household income
    


