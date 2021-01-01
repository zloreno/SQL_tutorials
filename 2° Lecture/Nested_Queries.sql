#What if I want to extract the date of the first exam?
select min(date)
from exam;
#Well this is easy

#What about the grade associated to it?
select grade
from exam
where date = "2005-04-20";
#Ta daa
#Sure, now try not to copy paste that bad boi
#Howboutdat

#This does not work because min (or any other aggregates) are allowed in the select or in the having clause
select grade 
from exam
where date = min(date);

#Taac
select grade
from exam
where date = ( select min(date)
						 from exam);

#It is crucial the shape of the output of the nested query
#We have 4 cases:
#1. one single attribute, one single value
#2. one single attribute, many values
#3. many attributes, one single value each
#4. many attributes, many values

#The previous example clarifies the first (and simplest) case
#Now we go a bit deep (dunno, for me, a novice) in the second case: one attribute, many values
#There are magic words here that we can use: ALL and ANY
select grade
from exam
where date =  ALL ( select date
								  from exam);
                                  
#ALL in this case, as you may have guessed, implies that the date must be equal to every date of the table "Exam",
#which is impossible (as shown in the output).
#The query in and of itself doesn't make a lot of sense, and I aplogize for my professor's massive creativity,
#however, the important thing is that you understand what it means

#Now we get more creative, it took some time but we got there
select *
from student 
where sid <> ALL (  select sid
								from exam);
#What do you think this means?

#Clearly the "=" can be changed and used as we prefer
select grade
from exam
where date >=  ALL ( select date
								  from exam);
#Here we have the last exam ever taken

select grade
from exam
where date <=  ALL ( select date
								  from exam);
#This is the first exam ever taken
#Holy shit it's a 29

#We have seen "ALL", how about  ANY?
select grade
from exam
where date =  ANY ( select date
								  from exam);
#Returns every single grade, since now we need that the date is equal to ANY (mind = blown) date present in the table exam
#Once again, I aplogize for my professor's massive creativity
select *
from student 
where sid = ANY (  select sid
								from exam);
#What do you think this means?
#50 shades of the same query over here am I right?


#A little bit of logics and alternative syntax on MySQL
#1.  v = ANY (Q2) -> v belongs to Q2 aka v in Q2
#2.  v <> ALL (Q2) -> v does not belong to Q2 aka v not in Q2

#1.  v = ANY (Q2) -> v belongs to Q2 aka v in Q2
select *
from student 
where sid = ANY (  select sid
								from exam);
#Is the same as
select *
from student 
where sid in (  select sid
								from exam);

#2.  v <> ALL (Q2) -> v does not belong to Q2 aka v not in Q2
select *
from student 
where sid <> ALL (  select sid
								from exam);
#Is the same as
select *
from student 
where sid not in (  select sid
								from exam);
