USE us_household_income;

SELECT *
FROM household_income;

# checking and removing duplicates
	# checking for duplicates
    SELECT *
    FROM (SELECT row_id, state_code,
		  ROW_NUMBER() OVER(PARTITION BY id) AS repition
          FROM household_income) AS repition_tagged_table
	WHERE repition > 1; # repition found in data
    
    # removing duplicates
    DELETE FROM household_income
    WHERE row_id IN(SELECT row_id
					FROM (SELECT row_id,
						  ROW_NUMBER() OVER(PARTITION BY id) AS repition
						  FROM household_income) AS repition_tagged_table
						  WHERE repition > 1);

# checking the distinct names in state_name
	SELECT DISTINCT(State_Name)
    FROM household_income;# could see that some columns, Georgia is mis-spelled
    
    UPDATE household_income
    SET State_Name = 'Georgia'
    WHERE State_Name = 'georia';

# Checking for empty columns
	SELECT * 
    FROM household_income
    WHERE State_Name = '' OR
		  State_ab = '' OR
          row_id= '' OR
          id = '' OR
          County= '' OR
          City = '' OR
          Place = '' OR
          `Type` = '' OR
          `Primary` = '' OR
          Zip_Code = '' OR
          Area_Code = '' OR
          ALand = '' OR
          AWater = '' OR
          Lat = '' OR
          Lon = ''; # Could see a empty string in place column
          
          # updating the string
          UPDATE household_income
          SET Place = 'Autaugaville'
          WHERE County = 'Autauga County'
			AND City = 'Vinemont';
# Having a look at the Type column
	SELECT DISTINCT(`TYPE`), COUNT(`TYPE`)
	FROM household_income
    GROUP BY `TYPE`;
    
    # updating boroughs with borough
	UPDATE household_income
	SET `TYPE` = 'Borough'
	WHERE `TYPE` = 'Boroughs';
		

    