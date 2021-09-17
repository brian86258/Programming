/*
1412. Find the Quiet Students in All Exams
Table: Student
student_id is the primary key for this table.
student_name is the name of the student.
+---------------------+---------+
| Column Name         | Type    |
+---------------------+---------+ 
| student_id          | int     |
| student_name        | varchar |
+---------------------+---------+

Table: Exam
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| exam_id       | int     |
| student_id    | int     |
| score         | int     |
+---------------+---------+
(exam_id, student_id) is the primary key for this table.
Student with student_id got score points in exam with id exam_id.

A "quite" student is the one who took at least one exam and didn't score neither the high score nor the low score.
Write an SQL query to report the students (student_id, student_name) being "quiet" in ALL exams.
Don't return the student who has never taken any exam. Return the result table ordered by student_id.
The query result format is in the following example.
*/


/*
Find silent student,
1, record the high/low score students
2, find all middle score student for each test
3, selet these middle score student not in previosut list,join to get informaiton
*/
with max_min_table
as(
	select *, 
		min(score)
		over(partition by exam_id)
		as MIN_score
		,
		max(score)
		over(partition by exam_id)
		as Max_score
	from exam
), hi_lo_table
as(
	select distinct student_id
	from max_min_table 
	where score = min_score or score = max_score
)
select distinct m.student_id, student_name
from max_min_table m
join student s on m.student_id = s.student_id
where min_score < score and score < max_score and m.student_id not in (select * from hi_lo_table);

