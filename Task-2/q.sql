
--SOLUTION FOR QUERY ONE--
SELECT 'NUMBER OF ENSEMBLES LESSONS';
SELECT DATE_TRUNC('month',time) AS time, COUNT (id) AS count FROM ensembles_lesson  GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'NUMBER OF INDIVDUAL LESSONS';
SELECT DATE_TRUNC('month',time) AS time, COUNT (id) AS count FROM indivdual_lesson  GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'NUMBER OF GROUP LESSONS';
SELECT DATE_TRUNC('month',time) AS time, COUNT (id) AS count FROM group_lesson GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'NUMBER OF TOTAL LESSONS';
SELECT DATE_TRUNC('month',time) AS time, COUNT (id) AS count FROM lessons GROUP BY DATE_TRUNC('month', time) ORDER BY time;


--SOLUTION FOR QUERY --
SELECT 'AVG OF ENSEMBLES LESSEON';
SELECT DATE_TRUNC('month',time) AS time, ROUND((CAST (COUNT(id)AS DECIMAL)/30)::DECIMAL,2)  AS AVG FROM ensembles_lesson GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'AVG OF INDIVDUAL LESSEON';
SELECT DATE_TRUNC('month',time) AS time, ROUND((CAST (COUNT(id)AS DECIMAL)/30)::DECIMAL,2)  AS AVG FROM indivdual_lesson GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'AVG OF GROUP LESSEON';
SELECT DATE_TRUNC('month',time) AS time, ROUND((CAST (COUNT(id)AS DECIMAL)/30)::DECIMAL,2)  AS AVG FROM group_lesson GROUP BY DATE_TRUNC('month', time) ORDER BY time;

SELECT 'AVG OF LESSEON';
SELECT DATE_TRUNC('month',time) AS time, ROUND((CAST (COUNT(id)AS DECIMAL)/30)::DECIMAL,2)  AS AVG FROM lessons GROUP BY DATE_TRUNC('month', time) ORDER BY time;
