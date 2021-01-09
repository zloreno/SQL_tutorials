#1. Id of the students who got at least one 30
select distinct sid
from exam
where grade = 30;

#2. Id, Name and City of origin of the students who got at least one 30
select distinct Sid, Name, City
from exam natural join student 
where grade = 30;

#3. The birthdate of the youngest student
select max(birthdate)
from student;

select *
from student
where birthdate = (select max(birthdate)
								from student);
                                
select *
from student s join (select max(birthdate) as youngest
								 from student) j 
on s.birthdate=j.youngest;

#4. The GPA of the student with ID = 107
select sum(grade*credits)/sum(credits), e.sid, Name
from exam e join course c on e.cid=c.courseid
		 join student s on e.sid=s.sid
where e.sid=107;

#5. The GPA of each course
select avg(grade), title
from exam join course on exam.cid=course.courseid
group by title;

#6. The number of Credits acquired by each student
select sum(credits), Name, Sid
from student s natural join exam e
		 join course c on c.courseid = e.cid
group by s.sid;

#7. The (weighted) GPA of each student
select sum(grade*credits)/sum(credits), e.sid, Name
from exam e join course c on e.cid=c.courseid
		 join student s on e.sid=s.sid
group by e.sid;

#8. Students who passed at least 2 exams [a. just the Id b. also the Name]
select s.sid, Name
from student s natural join exam e
		 join course c on c.courseid=e.cid
group by s.sid
having count(grade)>1;

#9. Students who passed less than 5 exams [a. just the Id b. also the Name]
select s.sid, Name
from student s natural join exam e
		 join course c on c.courseid=e.cid
group by s.sid
having count(grade)<5;

#10. Students who passed exactly 4 exams [a. just the Id b. also the Name]
select s.sid, Name
from student s natural join exam e
		 join course c on c.courseid=e.cid
group by s.sid
having count(grade)=4;

#11. For each student, the number of passed exams (including those with 0 exams!)
select Name, count(grade)
from student s left join exam e on s.sid=e.sid
group by s.sid;

#12. Students with a GPA that is above 24.5
select Name, avg(grade)
from student natural join exam
group by student.sid
having avg(grade)>24.5
order by avg(grade) desc;

#13. The “regular” students, i.e., those with a delta of maximum 3 points between their worst and best grade
select Name, min(grade) as Minimum, max(grade) as Maximum
from student natural join exam
group by student.sid
having (max(grade) - min(grade))<4
order by avg(grade) desc;

#14. The (weighted) GPA of each student who passed at least 5 exams (statistically meaningful)
select sum(grade*credits)/sum(credits), e.sid, Name
from exam e join course c on e.cid=c.courseid
		 join student s on e.sid=s.sid
group by e.sid
having count(grade)>4
order by sum(grade*credits)/sum(credits) desc;

#15.0 The (weighted) GPA for each year of each student who passed at least 5 exams
select sum(grade*credits)/sum(credits), e.sid, Name, Year
from exam e join course c on e.cid=c.courseid
		 join student s on e.sid=s.sid
group by e.sid, Year
having count(grade)>4
order by sum(grade*credits)/sum(credits) desc;

#15.1 The (weighted) GPA for each year of each student who passed at least 5 exams overall
select sum(grade*credits)/sum(credits), e.sid, Name
from exam e join course c on e.cid=c.courseid
		 join student s on e.sid=s.sid
group by e.sid
having count(grade)>4
order by sum(grade*credits)/sum(credits) desc;

#15.2 The (weighted) GPA for each year of each student who passed at least 2 exams
select sum(grade*credits)/sum(credits), e.sid, Name, Year
from exam e join course c on e.cid=c.courseid
		 join student s on e.sid=s.sid
group by e.sid, Year
having count(grade)>1
order by sum(grade*credits)/sum(credits) desc;

#16. Students who never got more than 21
select Name, sid
from student natural join exam
group by student.sid
having max(grade)<22;

#17. Id and name of the students who passed exams for a total amount of at least 20 credits and never got a grade below 28
select Name, sid
from student s natural join exam e
		 join course c on e.cid=c.courseid
group by s.sid
having min(grade)>27 and sum(credits)>19 ;

#18. Students who got the same grade in two or more exams
select Name, sid, grade
from student s natural join exam e
group by s.sid, grade
having count(grade)>1;

#Or

select Name
from student s natural join exam e
group by s.sid 
having count(distinct grade) <> count(e.cid);

#19. Students who never got the same grade twice
select distinct Name, sid
from student s natural join exam e
where sid in (select sid
								from student s natural join exam e
								group by s.sid, grade
								having count(grade)>1);

#20. Students who always got the very same grade in all their exams
select Name
from student s natural join exam e
group by s.sid 
having count(distinct grade) = count(e.cid);

#21. The name of the youngest student
select Name
from student
where birthdate = (select min(birthdate) 
								from student);

#22. Students who got all possible different grades
select Name
from student s natural join exam e
group by s.sid
having count(distinct grade) = 13;

#23. Students who never passed any exam
select Name
from student 
where sid not in  (  select sid
								from exam);

#24. Students who never got an 18
select Name
from student 
where sid not in ( select sid
								from exam
                                where grade = 18);

#25. Code and Title of the courses with the minimum number of credits
select Title, courseid, credits
from course
where credits = (select min(credits)
							from course);

#26. Code and Title of the courses of the first year with the minimum number of credits
select Title, courseid, credits, Year
from course
where year = 1 and 
credits = (select min(credits)
				from course
				where year=1);

#27. Code and Title of the courses with the minimum number of credits of each year                            
select Title, Year, Credits
from course
where (credits, year) in (select min(credits), year
												from course
												group by year)
order by year, credits ;

#28. Id and Name of the students who passed more exams from the second year than exams from the first year
select count(grade), Name, Year
from student s NATURAL JOIN exam e
join course c on e.cid=c.courseid
group by year, s.sid;

#29. The student(s) with best weighted GPA
select sum(grade*credits)/sum(credits) as Weighted, e.sid, Name
from exam e join course c on e.cid=c.courseid
		 join student s on e.sid=s.sid
group by e.sid;
having max(sum(grade*credits)/sum(credits));


#30. The course with the worst GPA
select avg(grade) GPA, Title
from course c join exam e on c.courseid = e.cid
group by title
having avg(grade) <= ALL ( select avg(grade) 
												from course c join exam e on c.courseid = e.cid
												group by title);
#31. Students with a GPA that is at least 2 points above the overall college GPA
create view WeightedGPAPerStudent (Weighted, SId, FullName) as 
					select sum(grade*credits)/sum(credits), e.sid, Name
					from exam e join course c on e.cid=c.courseid
							 join student s on e.sid=s.sid
					group by e.sid ;

select SId, Fullname, Weighted
from WeightedGPAPerStudent
where Weighted - 2 >= (select  avg(weighted)
										from WeightedGPAPerStudent)
order by weighted desc;	

#32. For each student, their best year in terms of GPA
#33. The most “regular” students, i.e., those with the minimum delta between their worst and best grade
#34. Students with a weighted GPA that is above the “average weighted GPA” of all the students
create view WeightedGPAPerStudent (Weighted, SId, FullName) as 
					select sum(grade*credits)/sum(credits), e.sid, Name
					from exam e join course c on e.cid=c.courseid
							 join student s on e.sid=s.sid
					group by e.sid ;

select SId, Fullname, Weighted
from WeightedGPAPerStudent
where Weighted >= (select  avg(weighted)
										from WeightedGPAPerStudent)
order by weighted desc;	

#35. Students who got all their grades in strictly non-decreasing order over time
#sub 1
#Those who failed to get increasing grades over time
select distinct e1.sid
from exam e1 join exam e2 on e1.sid=e2.sid
where e1.date < e2.date and 
			e1.grade > e2.grade;

#And now select the others
select *
from student
where sid NOT IN (select distinct e1.sid
								from exam e1 join exam e2 on e1.sid=e2.sid
								where e1.date < e2.date and 
											e1.grade > e2.grade);

# If we were to select a minimum number of exams to be passed, than it would be done like this:
select *
from student
where sid NOT IN (select distinct e1.sid
								from exam e1 join exam e2 on e1.sid=e2.sid
								where e1.date < e2.date 
                                and e1.grade > e2.grade)
	and sid IN (select sid
						from exam
                        group by sid 
                        having count(*)>1);

#Or 
select *
from student s
where sid NOT IN (select distinct e1.sid
								from exam e1 join exam e2 on e1.sid=e2.sid
								where e1.date < e2.date 
                                and e1.grade > e2.grade)
	and 2 <=   (select count(*)
						from exam
                        where sid=s.sid);


