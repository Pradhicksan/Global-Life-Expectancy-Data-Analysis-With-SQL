USE global_life_expectancy_database;
# Cleaning the Data 

# Having a glance at the data
	SELECT * 
	FROM global_life_expectancy_database.life_expectancy_duplicate;

# Dealing with Duplicates
    # country and year together are used to identify if there are duplicates
		SELECT CONCAT(Country, Year), COUNT(CONCAT(Country, Year)) AS duplicated
		FROM life_expectancy_duplicate
		GROUP BY CONCAT(Country, Year)
		HAVING duplicated>1; # Running the query, could see that there are three duplicates
        
    # removing duplicates
		DELETE FROM life_expectancy_duplicate
        WHERE Row_ID IN (SELECT Row_ID
						 FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, `Year`)) AS duplicated
							   FROM life_expectancy_duplicate) AS duplicates_labelled_data # rownumber given based on concatenated country, year column
						 WHERE duplicates_labelled_data.duplicated >1);

# dealing with  null values
	# dealing with null values in status column
		SELECT DISTINCT(country)
        FROM life_expectancy_duplicate
        WHERE life_expectancy_duplicate.`status` = 'Developing'; # countries that are developing
        
		# UPDATE life_expectancy_duplicate
        # SET status = 'Developing'
        # WHERE country IN (SELECT DISTINCT(country)
						   #FROM life_expectancy_duplicate
						   #WHERE life_expectancy_duplicate.`status` = 'Developing') 
        -- This code doesn't work because in update statements, can't update the same table which is also in the subquery
        -- So creating something called Common Table Expression (CTE), which creates and stores a table temporarily until 
        -- the next query is executed
        
        WITH developing_countries AS(SELECT DISTINCT country
									FROM life_expectancy_duplicate
									WHERE status = 'Developing')
		# Filling 'Developing' string
		UPDATE life_expectancy_duplicate
        SET status = 'Developing'
        WHERE country IN (SELECT * 
						  FROM developing_countries );
		
        # Filling 'Developed' string
		WITH developed_countries AS(SELECT DISTINCT country
									FROM life_expectancy_duplicate
									WHERE status = 'Developed')
                                    
		UPDATE life_expectancy_duplicate
        SET status = 'Developed'
        WHERE country IN (SELECT * 
						  FROM developed_countries );
	# Dealing with blank spaces in Life expectancy column
		SELECT country, `year`
        FROM life_expectancy_duplicate
        WHERE `Life expectancy` = '';
        
        # Filling blanks with average of previous year and the next year
        WITH exp_adj AS (SELECT l1.country,L1.`year`, l1.`Life expectancy`, l2.`Life expectancy` AS `leading`,  l3.`Life expectancy` AS `lagging`
						 FROM life_expectancy_duplicate AS l1
						 JOIN life_expectancy_duplicate AS l2
							 ON l2.country = l1.country
							 AND l1.`year` = l2.`year`-1 # leading column
						 JOIN life_expectancy_duplicate AS l3
							 ON l3.country = l1.country
							 AND l1.`year` = l3.`year`+1
						 WHERE l1.`Life expectancy`= '')
		UPDATE life_expectancy_duplicate
        JOIN exp_adj AS e
			ON e.country = life_expectancy_duplicate.country
        SET life_expectancy_duplicate.`Life expectancy` = (`leading`+ `lagging`)/2
        WHERE life_expectancy_duplicate.`Life expectancy` = '';
        
    

