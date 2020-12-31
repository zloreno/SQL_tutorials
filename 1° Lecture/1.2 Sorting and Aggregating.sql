#Sorting
#Important because you may need to export another system's output, which won't have a human sorting it 

#Here we'll just select the list of unique names of students who got at least once more than 28 on an exam,
#and we'll sort
select distinct name 
from student natural join exam 
where grade >27
order by name;

#On a descending order, we simply say:
select name, title, grade
from student s natural join exam e
join course c on c.courseid = e.cid
where grade >27
order by name desc, title, grade desc;
#Taac
#Here we stepped up our game and we decided to order (descending order) the name
#Then among the same name based on the title (aka, the name of the exam)
#Then based on the grade 
#Overkill you ask me?
#Absolutely yes


#When was the first exam *ever*?
select date 
from exam
order by date
LIMIT 1;

#Seems smart, but it isn't
#It won't work on Oracle as it's a proprietary piece of code
#On top of this, it doesn't recognizes ties among values 
#if i.e., you have n touples with values equal to the maximum/minimum in one category
#There are better (universal) ways of doing so


#Aggregation
select min(grade), max(grade),  round(avg(grade),2)
from exam
where date > "2007/12/25";

select min(grade), max(grade),  avg(grade)
from exam
where date > "2007/12/25";

#Now let's try and do something real nice
#Let's try ang get the number of exams passed by every student, and their avg (easy avg, not weighted)
select name,  count(grade), avg(grade), min(grade), max(grade)
from student natural join exam
where sid=101;
#This as a model for the overall table we want to obtain, and we'll obtain it tomorrow























