
-- Delivarable 1 create retirement title, remove duplicate rows

checking CSV tables before starting
SELECT * FROM employees; -- Returns 400k rows
SELECT * FROM titles;-- Returns 433k rows

-- create a table of retirement titles with defined birth dates
SELECT e.emp_no,
       e.first_name,
       e.last_name,
       t.title,
       t.from_date,
       t.to_date
 INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER by e.emp_no ASC;

-- cheking the new created table
SELECT * FROM retirement_titles;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title

INTO unique_titles
FROM retirement_titles as rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- cheking the new created table
SELECT * FROM unique_titles;

-- create count of retiring tables
SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;


-- cheking the new created table
SELECT * FROM retiring_titles;

----------------------------------
-- Delivarable 2 - Create Mentor list

-- create a table of retirement titles with defined birth dates
SELECT DISTINCT ON (e.emp_no) e.emp_no,
       e.first_name,
       e.last_name,
       e.birth_date,
       de.from_date,
       de.to_date,
       t.title
 INTO mentorship_eligibilty
FROM employees as e
  INNER JOIN dept_emp as de
  ON (e.emp_no = de.emp_no)
  INNER JOIN titles as t
  ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER by e.emp_no ASC, de.emp_no DESC;

-- cheking the new created table
SELECT * FROM mentorship_eligibilty;
