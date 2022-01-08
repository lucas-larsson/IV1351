
--SOLUTION FOR QUERY ONE--
SELECT 'NUMBER OF ENSEMBLES LESSONS';
SELECT DATE_TRUNC('month',time) AS time, 
COUNT (id) AS count FROM ensembles_lesson  
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'NUMBER OF INDIVDUAL LESSONS';
SELECT DATE_TRUNC('month',time) AS time, 
COUNT (id) AS count FROM indivdual_lesson  
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'NUMBER OF GROUP LESSONS';
SELECT DATE_TRUNC('month',time) AS time, 
COUNT (id) AS count FROM group_lesson 
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'NUMBER OF TOTAL LESSONS';
SELECT DATE_TRUNC('month',time) AS time, 
COUNT (id) AS count FROM lessons 
GROUP BY DATE_TRUNC('month', time) ORDER BY time;


--SOLUTION FOR QUERY 2 --
SELECT 'AVG OF ENSEMBLES LESSEON';
SELECT DATE_TRUNC('month',time) AS time, 
ROUND((CAST (COUNT(id)AS DECIMAL)/12)::DECIMAL,2)  
AS AVG FROM ensembles_lesson 
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'AVG OF INDIVDUAL LESSEON';
SELECT DATE_TRUNC('month',time) AS time, 
ROUND((CAST (COUNT(id)AS DECIMAL)/12)::DECIMAL,2)  
AS AVG FROM indivdual_lesson 
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'AVG OF GROUP LESSEON';
SELECT DATE_TRUNC('month',time) AS time, 
ROUND((CAST (COUNT(id)AS DECIMAL)/12)::DECIMAL,2)  
AS AVG FROM group_lesson GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'AVG OF LESSEON';
SELECT DATE_TRUNC('month',time) AS time, 
ROUND((CAST (COUNT(id)AS DECIMAL)/12)::DECIMAL,2)  
AS AVG FROM lessons GROUP BY DATE_TRUNC('month', time) ORDER BY time;

-- SOLUTION FOR QUERY 3 --

-- this query retuers a tabel with a columen of instructuers who has worked over 2 lessons per current month
-- and only lists true or false  --
SELECT name(instructure), id, count(*) > 2  as over_limit from lessons 
where extract(YEAR FROM time ) = extract(YEAR FROM now())
      and extract(MONTH FROM time) = extract(MONTH FROM now())
group by instructure,id  order by over_limit DESC;

-- this query retuers a tabel with a columen of instructuers who has worked over 2 lessons per current month
-- and list how many over the limit(2) they have worked --
SELECT name(instructure), id,count(*) - 2 as given_lessons from lessons 
  WHERE date_trunc('month', time)=date_trunc('month',current_timestamp)  
  group by instructure,id  order by given_lessons DESC;


  -- WITH report AS (
  --  SELECT P.*, COUNT(*) OVER (PARTITION BY instructure) AS count FROM lessons P 
  --  WHERE date_trunc('month', time)=date_trunc('month',current_timestamp)  
  --  )
  --  SELECT * FROM report WHERE count >1;

      -- SOLUTION FOR QUERY 4 --

      SELECT * WHERE time >= date_trunc('week', CURRENT_TIMESTAMP + interval '1 week') and
       time  < date_trunc('week', CURRENT_TIMESTAMP)
      from ensembles_lesson;

select name(instructure) 
    WHERE (time >= date_trunc('week', CURRENT_TIMESTAMP + interval '1 week') and
       time  < date_trunc('week', CURRENT_TIMESTAMP))
    from ensembles_lesson order by time ASC, genre ASC;
-----------------

SELECT * FROM (
SELECT max_places, booked_places,instructure,instrument,genre,time,

CASE
 WHEN max_places = booked_places 
 THEN 'full booked'
 
 WHEN max_places - booked_places =< 2 
 THEN '1-2 seats left' 
 
 ELSE 'there is more than 2 places' 
 
 End AS place_avaliability From ensembles_lesson)
 ensembles_lesson WHERE 
 extract ('week' FROM time )= 
 extract( 'week'from CURRENT_TIMESTAMP+ INTERVAL '1 week')
  
  ORDER BY time ASC, genre;



  -- SOLUTION FOR QUERY in task 4 --




-- 'guitar' change with {variable}


SELECT 'NUMBER OF ENSEMBLES LESSONS';

SELECT DATE_TRUNC('month',time) AS time, lesson_type AS type,
COUNT (id) AS count FROM lessons  
GROUP BY DATE_TRUNC('month', time) ORDER BY time;


-- for checking rented instrunmenrt 
SELECT instrument_id, instrument, brand, price, is_rented, school_id  FROM instrument_rental  WHERE instrument = {instrument} AND is_rented  = 'false';


 -- for renting 
  WITH  rented  as (
                 UPDATE instrument_rental SET is_rented = TRUE, school_id ='52675', 
                 start_date = CURRENT_DATE, end_date = CURRENT_DATE + INTERVAL '1 year' WHERE instrument_id=  '150' returning * 
                 ) 
                    UPDATE instruments SET is_rented = TRUE
                WHERE instrument_id IN (SELECT instrument_id FROM rented);

-- for rent termination
             WITH  rented  as (
                 UPDATE instrument_rental SET is_rented = FALSE,  
                 end_date = CURRENT_DATE WHERE instrument_id= {id} returning * 
                 ) 
                    UPDATE instruments SET is_rented = FALSE
                WHERE instrument_id IN (SELECT instrument_id FROM rented);



                INSERT INTO rental_archive (instrument_id, instrument, brand , price, student_id) 
                SELECT instrument_id, instrument, brand , price, school_id FROM instrument_rental;





-- high grade 3 
INSERT INTO lessons_archive ( school_id, lesson_type, price)
SELECT school_id, lesson_type, price FROM lessons
WHERE extract(DAY FROM time) = extract(DAY FROM now());


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