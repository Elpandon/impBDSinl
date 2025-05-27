 SELECT DISTINCT IntegerValue FROM SampleData   
 ORDER BY IntegerValue DESC    
 Limit 1 OFFset 1;


WITH Ranked AS (    
SELECT IntegerValue,     
ROW_NUMBER() OVER (ORDER BY IntegerValue DESC) AS rango    
FROM SampleData    
)    
SELECT IntegerValue FROM Ranked    
WHERE rango = 2;