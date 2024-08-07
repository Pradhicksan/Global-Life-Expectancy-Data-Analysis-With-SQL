USE global_life_expectancy_database;

SELECT *
FROM life_expectancy_duplicate;

# checking out the min and max life expectancy of countries
	SELECT Country, MIN(`Life expectancy`) AS maximum_expectancy,
	MAX(`Life expectancy`) AS minimum_expectancy,
	ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS expectancy_increase
	FROM life_expectancy_duplicate
	GROUP BY Country
	ORDER BY expectancy_increase DESC; #Could see that some 0 expectancy
    
# checking out the global expectancy trends over years
	SELECT `year`, ROUND(AVG(`Life expectancy`),2) AS global_average
    FROM life_expectancy_duplicate
    WHERE `Life expectancy` != 0
    GROUP BY `year`
    ORDER BY `year`;

# checking for correlation between GDP and average_expectancy
	SELECT country, ROUND(AVG(`Life expectancy`),2) AS life_expectancy,ROUND(AVG(GDP),2) AS gdp
    FROM life_expectancy_duplicate
	WHERE `Life expectancy` != 0
		AND GDP != 0
    GROUP BY country
    ORDER BY gdp DESC; # clearly could see a trend. Believing gdp per person would give an even more better idea
    
# comparing life expectancy in developed and developing countries
	SELECT `Status`, ROUND(AVG(`Life expectancy`),1) AS expectancy
    FROM life_expectancy_duplicate
    GROUP BY `Status`;

# comparing life expectancy and BMI
	SELECT country, ROUND(AVG(`BMI`),1) AS bmi, ROUND(AVG(`Life expectancy`),1) expectancy
    FROM life_expectancy_duplicate
    WHERE `Life expectancy` != 0
		AND GDP != 0
        AND BMI != 0
    GROUP BY country
    ORDER BY BMI;