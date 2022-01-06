
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



--  time = date_trunc('week', CURRENT_TIMESTAMP + interval '1 week') AND
  --     time  < date_trunc('week', CURRENT_TIMESTAMP)
  --
   --(time < date_trunc('week', CURRENT_TIMESTAMP + interval '1 week') and
     --  time >= date_trunc('week', CURRENT_TIMESTAMP)
      --)
 

  -- SOLUTION FOR QUERY in task 4 --




-- 'guitar' change with {variable}
SELECT instrument, brand, price FROM instruments WHERE instrument = 'guitar' AND is_rented = FALSE;

SELECT 'NUMBER OF ENSEMBLES LESSONS';

SELECT DATE_TRUNC('month',time) AS time, lesson_type AS type,
COUNT (id) AS count FROM lessons  
GROUP BY DATE_TRUNC('month', time) ORDER BY time;

-- 'Hilliary' change with {variable}
-- implemente in JAVA max gräns på 2 för varje student.
SELECT instrument_id, instrument, brand, price, is_rented, school_id  FROM instrument_rental  WHERE instrument = 'Hilliary' AND is_rented  = 'false';

-- insert into instrument_rental (instrument_id, instrument, brand , price, is_rented, school_id, start_date, end_date)
  -- values ('128', 'Thorsten', 'Danigel', '366 SEK', true, 1, '2021-12-02 09:42:58', '2021-01-12 20:34:36');
 -- values inhertied from instrument. 

             WITH  rented  as (
                 UPDATE instrument_rental SET is_rented = 'true',  
                 end_date = CURRENT_DATE WHERE instrument_id='408' returning * 
                 ) 
                    UPDATE instruments SET is_rented = 'true' 
                WHERE instrument_id IN (SELECT instrument_id FROM rented);


(SELECT DATE_TRUNC('month',time) AS time, 
COUNT (id) AS count FROM indivdual_lesson  
GROUP BY DATE_TRUNC('month', time) ORDER BY time;)
UNION ALL 
(
  ELECT DATE_TRUNC('month',time) AS time,  
  COUNT (id) AS count FROM ensembles_lesson
   GROUP BY DATE_TRUNC('month', time) ORDER BY time;
)

(SELECT DATE_TRUNC('month',time) AS time,   
COUNT (id) AS ind FROM indivdual_lesson  )         
             
UNION ALL
(
  SELECT DATE_TRUNC('month',time) AS time,
COUNT (id) AS ens FROM ensembles_lesson
GROUP BY DATE_TRUNC('month', time) ORDER BY time
)            
;
GROUP BY DATE_TRUNC('month', time) ORDER BY time)