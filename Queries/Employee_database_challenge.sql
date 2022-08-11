-- Retirement Titles table for employees who are born between January 1, 1952 and December 31, 1955
DROP TABLE IF EXISTS retirement_titles CASCADE;
SELECT DISTINCT ON (e.emp_no) ti.emp_no,
    e.first_name,
    e.last_name,
    ti.title,
    ti.from_date,
    ti.to_date
INTO retirement_titles
FROM employees AS e
JOIN titles AS ti
ON e.emp_no = ti.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no, ti.to_date DESC;


-- Unique Titles table that contains the employee number, first and last name, and most recent title.
DROP TABLE IF EXISTS unique_titles CASCADE;

SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title
INTO unique_titles
FROM retirement_titles AS rt
WHERE rt.to_date = '9999-01-01'
ORDER BY rt.emp_no, rt.to_date DESC;

-- Group retirement count by title
DROP TABLE IF EXISTS retiring_titles CASCADE;

SELECT COUNT(ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY ut.count DESC;

-- Use Dictinct with Orderby to remove duplicate rows
DROP TABLE IF EXISTS mentorship_eligibilty CASCADE;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    ti.title
INTO mentorship_eligibilty
FROM employees AS e
INNER JOIN dept_emp as de
ON e.emp_no = de.emp_no
INNER JOIN titles as ti
ON e.emp_no = ti.emp_no
WHERE ti.to_date = ('9999-01-01')
AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
ORDER BY e.emp_no ASC;
