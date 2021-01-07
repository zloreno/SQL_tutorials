#Now let's try and do something real nice
#Let's try ang get the number of exams passed by every student, and their avg (easy avg, not weighted)
select name,  count(grade), avg(grade), min(grade), max(grade)
from student natural join exam
where sid=101;
#This as a model for the overall table we want to obtain

#Group by 	(grouping)
#Having 		(selection over groups)

#Group by is a clause aimed at clustering touples into homogeneous sets and computes aggregates on such clusters
select count(*)
from exam
group by sid;

#We have 11 rows, *coincidentally* (wink wink) the same as
select count(distinct sid)
from exam;
#*wink wink*

#Genererally we cannot use aggregation and simple (dunno the actual technical name) functions such as in this case
select avg(sid), sid
from exam;

#However, with group by we can extract some tricks by selecting the attribute by which we are grouping (as it is suposed to be the same within the group)
select avg(grade), sid
from exam
group by sid;

#The fun begins when you join two tables and group by a specific attribute, 
#as we can select attributes which are functionally determined by the attribute that is defining the groups
#One example is the name if we group by the student id
select avg(grade), name
from exam natural join student
group by sid;

select name,
			min(grade) as lowest_score, max(grade) as higherst_score, avg(grade) as gpa,
			min(date) as starting_date, max(date) as graduation_date,
            count(*) as exams_passed
from exam natural join student
group by sid;

#What if I wnated to extract every student that has passed at least 5 exams?
#"Having" joined the chat
select Name,
			min(grade) as Lowest_Score, max(grade) as Higherst_score, avg(grade) as GPA,
			min(date) as Starting_Date, max(date) as Graduation_Date,
            count(*) as Exams_Passed
from exam natural join student
group by sid
having count(*)>5
order by exams_passed desc;

#We can group by a multitude of attributes, but I'll let you explore that
#Check if the order is relevant



#Before leaving for the next topic (nested queries), let's try to do differently a query computed previously
#Who didn't pass any exam yet?
select Name, count(*), count(distinct grade)
from exam natural right join student
group by sid;
#Still Sean
#Come on Sean




































