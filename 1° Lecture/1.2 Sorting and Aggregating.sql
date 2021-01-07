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
#sum, max, min, avg
select min(grade), max(grade), sum(sid),  round(avg(grade),2)
from exam
where date > "2007/12/25";

select min(grade), max(grade),  avg(grade)
from exam
where date > "2007/12/25";

#Don't run the follwoing query
select sid, min(grade)
from exam
where date > "2007/12/25";
#Do you think it will work? 
#Think about it *carefully*

#We can also apply functions to our aggregates
select sum(grade)
from exam;

select sum(distinct grade), 18+19+20+21+22+23+24+25+26+27+28+29+30 as control_grades
from exam;

#Count is slightly different from the other aggregates
#We count the items with non-NULL values
select count(grade)
from exam;

#Since we know that the PK of exam is the combination of sid and cid, we expect that there are no dubplicates among them
#Distinct works on every attribute inside the parenthesis in this case
select count(grade), count(distinct sid, cid) as Sixtyone
from exam;
#Ta-daa

#There is a trick to count into counting *every*  value
#We altready know that the natural left join of student and exam produces one NULL value (one student who hasn't passed any exam yet)
select count(*) as trickable, count(grade) as untrickable, count(distinct date) as justforfunbutnotreallynecessary
from student natural left join exam;
#Ta-daa pt.635478908

#And we can also perform operations on those funtions
select sum(grade)+1000
from exam;

select sum(grade-18)
from exam;























