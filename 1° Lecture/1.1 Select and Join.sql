select *
from course
where year > 2;

#joining a multitude of tables
select * 
from course, exam
where courseid = cid;

select * 
from course, exam, student
where course.courseid = exam.cid 
	and exam.sid=student.sid;
    
#Now we are abbreviating stuff, we're the cool kids
#Using aliases is not necessary and serves no purpose aside abbreviating code
select * 
from course as c, exam as e, student as s
where c.courseid = e.cid 
	and e.sid=s.sid;
    
#Whatabout a self join?
#A self join is, once again, the cartesian product with itself
#Now we look for every student who took two different exams on the same date
#Poor fuck

#Oh and since we are cool kids we can even avoid writing the as when we rename tables
#Yo

#Nerd note, what you are *actually* doing, when using aliases, you are using variables
select e1.*
from exam e1, exam e2
where e1.sid = e2.sid 
	and e1.Date = e2.Date
    and e1.cid <> e2.cid;
#<> or != mean "not equal"
#Whereas <> is accepted everywhere, != may not be accepted everywhere

#Very solid explainations overe here 

#Antoher way of putting this is:
select e1.*
from exam e1 join exam e2 on(e1.sid = e2.sid 
	and e1.Date = e2.Date
    and e1.cid <> e2.cid);
#Basically by putting the "where" in the  on clause

#To be precise, this is an inner join, and as so we can rename it (and the result won't change)
select e1.*
from exam e1 inner join exam e2 on(e1.sid = e2.sid 
	and e1.Date = e2.Date
    and e1.cid <> e2.cid);
#Nobody ACTUALLY writes it, it's still an inner join regardless
#It's the same as the "as" when we feel cool and rename the tables    



#However the previosuly mentioned methods 
#didn't gave us the right glimpse of how a "correct" join is performed
#The previous one was supposed to be the right way, but is ugly af
#And the previous one, even though it is more clean an beatutiful, is not "the right way" of doing so



#To perform a join like a pro we will do like this
select e.sid
from student s join exam e on s.sid=e.sid;

#I guess that this join represents every student that has ever passed an exam

#The following one will extract every student that has got more than 29 on an exam
select distinct e.sid 
from student s join exam e on s.sid=e.sid
where grade >29;

#The following will perform a natural join
select * 
from student s natural join exam e
where grade > 28;


#Just to recap
select * 
from course, exam, student
where course.courseid = exam.cid 
	and exam.sid=student.sid;
    
#Becomes
select * 
from course join exam on course.courseid = exam.cid 
	join student on exam.sid=student.sid;

#Or
select * 
from course c join exam e on c.courseid = e.cid 
	join student s on e.sid=s.sid;

#Before we mentioned inner joins
#Now we do outer ones (I know, mind blown)
#In outer join we mention every touple every time, 
#meaning that we will associate the values in common, 
#and we'll recognize the times when we don't have a match, inserting NULL values

#We can either have, as mods, left or right or fully
#This mod will determine which table's leftovers we'll insert in the result table

#Ex. 
# A left inner join B
#Values of A which have a match with values of B
#PLUS values of A which don't
#Keep in mind that A is the table "on the left", so in this case has the priviledged treatment
#In this case the equivalent B's attributes (columns) of A's tuples will be filled with NULL values

select *
from student s left join exam e on s.sid=e.sid;
#Here we have every student associated to every exam, 
#plus those who didn't pass any exam yet (if we have any)

#This can be exploited to look for students who haven't pass their exams yet
#We now know that grade is a column that is null when a student hasn't pass any exam yet, so...
select *
from student s left join exam e on s.sid=e.sid
where grade is null;
#Way to go Sean!
#Any other attribute on the exam side would have worked, give it a shot



#Ex.
# A right inner join B
#You can easily guess which table will receive the priviledged treatment
#Hence which will be the final output of the query

select *
from course c right join exam e on c.courseid = e.cid;
#Here we have every course that has ever held an exam (I think, I'm not that smart)



#Ex.
# A full inner join B
#Now this is easy as well huh?
select *
from course c right join exam e on c.courseid = e.cid
union 
select *
from course c left join exam e on c.courseid = e.cid;
#In this instance it doens't make a lot of sense, but just to get the syntaxys straight
#MySQL doesn't support the syntax "full join", but it supports "left join", "right join", and "union"
#so behave like Bob the Builder, roll up your sleeves and in the spirit on Nike, JustDoIt!
