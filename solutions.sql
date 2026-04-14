
-- Challenge 1 - Who Have Published What At Where?
-- write an SQL `SELECT` query that joins various tables to figure out what titles each author has published at which publishers. Your output should have at least the following columns:
-- `AUTHOR ID` - the ID of the author
-- `LAST NAME` - author last name
-- `FIRST NAME` - author first name
-- `TITLE` - name of the published title
--`PUBLISHER` - name of the publisher where the title was published
--your output should be the same as the total number of records in Table `titleauthor`.

--DROP TABLE tab1;

/*
CREATE TEMP TABLE tab1 AS SELECT 
	ta.au_id   AS "AUTHOR ID",
	a.au_lname AS "LAST NAME",
	a.au_fname AS "FIRST NAME",
	t.title    AS "TITLE",
	p.pub_name AS "PUBLISHER"

FROM titleauthor as ta
JOIN authors as a on ta.au_id = a.au_id
JOIN titles as t on ta.title_id = t.title_id
JOIN publishers as p on t.pub_id=p.pub_id;
*/


SELECT * FROM tab1;


/*
Challenge 2 - Who Have Published How Many At Where?

Elevating from your solution in Challenge 1, query how many titles each author has published at each publisher. Your output should look something like below:

![Challenge 2 output](./images/challenge-2.png)

_Note: the screenshot above is not the complete output._

To check if your output is correct, sum up the `TITLE COUNT` column. The sum number should be the same as the total number of records in Table `titleauthor`.

_Hint: In order to count the number of titles published by an author, you need to use the SQL `COUNT` function. Also, check out 
`GROUP BY` because you will count the rows of different groups of data. Refer to the references and learn by yourself. 
These features will be formally discussed in the Temp Tables and Subqueries lesson._
*/
 
 
SELECT 
"AUTHOR ID",
"LAST NAME",
"FIRST NAME",
"PUBLISHER",
count(*) AS numbers
FROM tab1
GROUP BY
"AUTHOR ID",
"LAST NAME",
"FIRST NAME",
"PUBLISHER"
ORDER BY numbers DESC;

/*
Who are the top 3 authors who have sold the highest number of titles? Write a query to find out.

Requirements:

- Your output should have the following columns:
  - `AUTHOR ID` - the ID of the author
  - `LAST NAME` - author last name
  - `FIRST NAME` - author first name
  - `TOTAL` - total number of titles sold from this author
- Your output should be ordered based on `TOTAL` from high to low.
- Only output the top 3 best selling authors.
*/

SELECT 
a."AUTHOR ID",
a."LAST NAME",
a."FIRST NAME",

sum(c.qty) as "TOTAL"

FROM tab1 as a
JOIN titles as b on a."TITLE" = b."title"
JOIN sales as c on b.title_id = c.title_id

GROUP BY "AUTHOR ID"
ORDER BY "TOTAL" DESC
LIMIT 3;





 
/*

Challenge 4 - Best Selling Authors Ranking

Now modify your solution in Challenge 3 so that the output will display all 23 authors instead of the top 3.
Note that the authors who have sold 0 titles should also appear in your output (ideally display `0` 
instead of `NULL` as the `TOTAL`). Also order your results based on `TOTAL` from high to low.

*/
SELECT 
a.au_id,
a.au_lname,
a.au_fname,
COALESCE(sum(d.qty), 0) as "TOTAL"
FROM authors as a
LEFT JOIN titleauthor as b on a.au_id = b.au_id
LEFT JOIN titles as c on b."title_id" = c."title_id"
LEFT JOIN sales as d on c.title_id = d.title_id

GROUP BY a.au_id
ORDER BY "TOTAL" DESC;




