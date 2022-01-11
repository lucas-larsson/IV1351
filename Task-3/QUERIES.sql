
--SOLUTION FOR QUERY ONE--
SELECT 'NUMBER OF ENSEMBLES LESSONS';
SELECT DATE_TRUNC('month',time) AS time, 
COUNT (id) AS count FROM ensembles_lesson  
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'NUMBER OF INDIVDUAL LESSONS';
SELECT DATE_TRUNC('month',time) AS time, 
COUNT (id) AS count FROM individual_lesson  
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'NUMBER OF GROUP LESSONS';
SELECT DATE_TRUNC('month',time) AS time, 
COUNT (id) AS count FROM group_lesson 
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'NUMBER OF TOTAL LESSONS';
SELECT DATE_TRUNC('month',time) AS time, 
COUNT (id) AS count FROM lessons 
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

--------------------------------------------------------------------


--SOLUTION FOR QUERY 2 --


SELECT 'AVG OF ENSEMBLES LESSEON';
SELECT DATE_TRUNC('year',time) AS time, 
ROUND((CAST (COUNT(id)AS DECIMAL)/12)::DECIMAL,2)  
AS AVG FROM ensembles_lesson 
GROUP BY DATE_TRUNC('year', time) ORDER BY time;

SELECT 'AVG OF INDIVDUAL LESSEON';
SELECT DATE_TRUNC('year',time) AS time, 
ROUND((CAST (COUNT(id)AS DECIMAL)/12)::DECIMAL,2)  
AS AVG FROM individual_lesson 
GROUP BY DATE_TRUNC('year', time) ORDER BY time;

SELECT 'AVG OF GROUP LESSEON';
SELECT DATE_TRUNC('year',time) AS time, 
ROUND((CAST (COUNT(id)AS DECIMAL)/12)::DECIMAL,2)  
AS AVG FROM group_lesson 
GROUP BY DATE_TRUNC('year', time) ORDER BY time;

SELECT 'AVG OF LESSEON';
SELECT DATE_TRUNC('year',time) AS time, 
ROUND((CAST (COUNT(id)AS DECIMAL)/12)::DECIMAL,2)  
AS AVG FROM lessons 
GROUP BY DATE_TRUNC('year', time) ORDER BY time;
-- SOLUTION FOR QUERY 3 --
--------------------------------------------------------------------

    -- this query retuers a tabel with a columen of instructuers who 
    -- has worked over x lessons per current month

   WITH time_report AS (
       select instructor, count (id)
       from lessons  
       WHERE date_trunc('month', time)=date_trunc('month',current_timestamp)
       group by instructor order by count DESC
    )
    SELECT * FROM time_report WHERE count > x;

--------------------------------------------------------------------

                      -- SOLUTION FOR QUERY 4 --


SELECT * FROM (
SELECT max_places, booked_places,instructor,instrument,genre,time,

CASE
 WHEN max_places = booked_places 
 THEN 'full booked'
 
 WHEN max_places - booked_places <= 2 
 THEN '1-2 seats left' 
 
 ELSE 'there is more than 2 places' 
 
 End AS place_avaliability From ensembles_lesson)
 ensembles_lesson WHERE 
 extract ('week' FROM time )= 
 extract( 'week'from CURRENT_TIMESTAMP+ INTERVAL '1 week')
  
  ORDER BY time ASC, genre;

          -- high grade 3 
INSERT INTO lessons_archive ( student_id, lesson_type, price)
    SELECT student_id, lesson_type, price FROM lessons
    WHERE extract(DAY FROM time) = extract(DAY FROM now());


--------------------------------------------------------------------

        -- SOLUTION FOR QUERY in task 4 --


-- for checking rented instrunmenrt 
SELECT instrument_id, instrument, brand, price, is_rented, student_id  
FROM instrument_rental  
WHERE instrument = ? 
AND is_rented  = 'false';


 -- for renting 
  WITH  rented  as (
                 UPDATE instrument_rental 
                 SET 
                 is_rented = TRUE,
                 student_id ='52675', 
                 start_date = CURRENT_DATE,
                 end_date = CURRENT_DATE + INTERVAL '1 year' 
                 WHERE instrument_id=  '150' returning * 
                 ) 
                    UPDATE instruments SET is_rented = TRUE
                WHERE instrument_id IN (SELECT instrument_id FROM rented);

-- for rent termination


                
        INSERT INTO rental_archive (instrument_id, instrument, brand , price, student_id, start_date, end_date)
                SELECT instrument_id, instrument, brand , price, student_id , start_date, current_date 
                FROM instrument_rental                     WHERE instrument_id =?;
             
    WITH  rented  as (
                 UPDATE instrument_rental 
                 SET 
                 is_rented = FALSE,
                 end_date = CURRENT_DATE,
                 student_id = null, 
                  WHERE instrument_id= ? returning * 
                 ) 
                    UPDATE instruments SET is_rented = FALSE
                WHERE instrument_id IN (SELECT instrument_id FROM rented);




                