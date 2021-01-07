#A view provides users with a virtual vision of tables
#Can either be:
#1. Simple (select and project over one single table)
#2. Complex (simple, but over a multitude of tables with join and aggregate)

#Glad to hear that this disruptive creativity is not something systemic and it's just something of my professor

#Let's look at it
create view ExamsPerYearPerStudent (Passed, FullName, AcademicYear ) as 
					select count(grade), Name, Year
					from student s NATURAL JOIN exam e
					join course c on e.cid=c.courseid
					group by year, s.sid;

select *
from ExamsPerYearPerStudent;
#Powerful huh?
#Now go nuts about it

#Students who passed more than one exam on the same day
select sid, date, count(*)
from exam
group by sid, date
HAVING count(*)>1;





















