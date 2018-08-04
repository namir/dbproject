/**
* @author Namir Hassan
* @date 4/30/18
* @summary This project is a simple database for a company, Softy, Inc.
* It keeps track of programmers and the task to which they are assigned to.
* All relative data is kept for the programmer, supervisor, and the meta data.
*/

drop table Task cascade constraints;
drop table Works_On cascade constraints;
drop table Programmer cascade constraints;
drop table Programming_Languages cascade constraints;
drop table Works_On cascade constraints;
drop table ProficientIn cascade constraints;
drop table LanguagesUsed cascade constraints;
drop table ProgrammerLanguageTask cascade constraints;
drop procedure list_programmers;
drop procedure retire;
drop procedure terminate_task;
drop trigger change_active_status;

CREATE TABLE Task (
        tname CHAR(16) not null, --taskname
        Starting_date DATE not null, --starting date
        Completion_date DATE, --completion date
        isActive CHAR (2),
        constraint task_pk PRIMARY KEY (tname)
);

Create table Programming_Languages (
        Name CHAR (16) not null,
        Compiled CHAR(2) not null,
        isActive Char(2) not null,
        constraint pl_pk PRIMARY KEY (Name)
);

Create table Programmer (
        ID number(6) not null,
        Name CHAR(15) not null,
        Gender CHAR(2),
        Annual_Salary number(9,2),
        DOB DATE,
        Job_Title CHAR(16) not null,
        lname CHAR(16),
        isActive Char(2),
        SID number(6) not null,
       constraint p_sal_pos check (Annual_Salary >= 0),
        constraint p_pk PRIMARY KEY (ID),
        constraint pro_lang_name_fk FOREIGN KEY (lname) references Programming_Languages(Name)
);
Create table Works_On (
        Tname CHAR(16),
        PID number(6),
        constraint workson_pk PRIMARY KEY(Tname, PID),
        constraint Tname_fk_workson FOREIGN KEY(Tname) references Task(tname),
        constraint PID_fk_workson FOREIGN KEY (PID) references Programmer(ID)
);
Create table ProficientIn (
        lname CHAR (16) null,
        PID number (6) not null,
        Examination_date DATE,
        constraint proficientin_pk PRIMARY KEY (lname, PID),
        constraint PID_fk_proficientin FOREIGN KEY (PID) references Programmer(ID),
        constraint lname_fk_proficientin FOREIGN KEY (lname) references Programming_Languages (Name)
);
Create table LanguagesUsed (
        tname CHAR (16) not null,
        lname CHAR (16) not null,
        constraint LanguagesUsed_pk PRIMARY KEY (lname, tname),
        constraint lname_fk_languagesused FOREIGN KEY (lname) references Programming_Languages(Name),
        constraint tname_fk_languagesused FOREIGN KEY (tname) references Task (tname)
);



CREATE OR REPLACE TRIGGER change_active_status
        AFTER insert or update or delete on task
        for each row
--WHEN (TO_DATE(SYSDATE, 'MM-DD-YYYY') > new.Completion_Date)

BEGIN
        UPDATE TASK 
        SET isActive = 'Y'
        where sysdate > Completion_date;
END;


/**
* If language is not active, then deleting tuples from LanguagesUsed 
*/

insert into Task 
(tname, Starting_date, Completion_date, isActive)
 values 
 ('Wire Framework', 
 to_date('09-23-2017', 'MM-DD-YYYY'), 
 to_date('02-12-2018', 'MM-DD-YYYY'), 
 'N');

 insert into Task 
(tname, Starting_date, Completion_date, isActive)
 values 
 ('Network Server', 
 to_date('09-09-1997', 'MM-DD-YYYY'), 
 to_date('02-05-2001', 'MM-DD-YYYY'), 
 'N');

 insert into Task 
(tname, Starting_date, Completion_date, isActive)
 values 
 ('Mobile App', 
 to_date('01-06-2011', 'MM-DD-YYYY'), 
 to_date('10-29-2016', 'MM-DD-YYYY'), 
 'N');

 insert into Task 
(tname, Starting_date, Completion_date, isActive)
 values 
 ('Virtual Reality', 
 to_date('12-01-2018', 'MM-DD-YYYY'), 
 to_date('07-09-2023', 'MM-DD-YYYY'), 
 'Y');

 insert into Task 
(tname, Starting_date, Completion_date, isActive)
 values 
 ('Simulation', 
 to_date('01-21-2018', 'MM-DD-YYYY'), 
 to_date('01-20-2020', 'MM-DD-YYYY'), 
 'Y');

 insert into Programming_Languages 
 (Name, Compiled, isActive)
 values 
 ('C++', 'Y', 'Y');

  insert into Programming_Languages 
 (Name, Compiled, isActive)
 values 
 ('Scala', 'N', 'Y');

  insert into Programming_Languages 
 (Name, Compiled, isActive)
 values 
 ('Java', 'Y', 'Y');

  insert into Programming_Languages 
 (Name, Compiled, isActive)
 values 
 ('GO', 'N', 'Y');

  insert into Programming_Languages 
 (Name, Compiled, isActive)
 values 
 ('CSharp', 'Y', 'Y');

 insert ALL
 into Programmer  (ID, Name, Gender, Annual_Salary, DOB, Job_Title, SID) values 
 ('23', 'Namir', 'M', '900000', to_date('09/09/1997', 'MM/DD/YYYY'), 'Security Eng', '1')
 into Programmer (ID, Name, Gender, Annual_Salary, DOB, Job_Title, SID) values 
 ('63', 'Jenifa', 'F', '800000', to_date('12/04/1963', 'MM/DD/YYYY'), 'Designer', '1')
 into Programmer (ID, Name, Gender, Annual_Salary, DOB, Job_Title, SID) values 
 ('98', 'Brett', 'M', '100000', to_date('04/20/1998', 'MM/DD/YYYY'), 'DevOps', '1')
 into Programmer (ID, Name, Gender, Annual_Salary, DOB, Job_Title, SID) values 
 ('97', 'Cory', 'M', '200000', to_date('09/25/1997', 'MM/DD/YYYY'), 'Backend Eng', '1')
 into Programmer (ID, Name, Gender, Annual_Salary, DOB, Job_Title, SID) values 
 ('99', 'Kevin', 'M', '500000', to_date('12/09/1997', 'MM/DD/YYYY'), 'Frontend Eng', '1')
 SELECT * from dual;

insert into Works_On (Tname, PID) values ('Network Server', '23');
insert into Works_On (Tname, PID) values ('Virtual Reality', '99');
insert into Works_On (Tname, PID) values ('Virtual Reality', '23');
insert into Works_On (Tname, PID) values ('Wire Framework', '97');
insert into Works_On (Tname, PID) values ('Simulation', '97');
insert into Works_On (Tname, PID) values ('Virtual Reality', '98');
insert into Works_On (Tname, PID) values ('Mobile App', '63');

insert into ProficientIn (lname, PID, Examination_date) values ('GO', '23', to_date('30-04-2016', 'DD-MM-YYYY'));
insert into ProficientIn (lname, PID, Examination_date) values ('GO', '97', to_date('29-01-2017', 'DD-MM-YYYY' ));
insert into ProficientIn (lname, PID, Examination_date) values ('Java', '23', to_date('23-11-2012',  'DD-MM-YYYY'));
insert into ProficientIn (lname, PID, Examination_date) values ('Java', '98', to_date('13-07-2012', 'DD-MM-YYYY' ));
insert into ProficientIn (lname, PID, Examination_date) values ('Java', '63', to_date('20-04-2002', 'DD-MM-YYYY' ));
insert into ProficientIn (lname, PID, Examination_date) values ('Scala', '23', to_date('10-10-2016', 'DD-MM-YYYY' ));
insert into ProficientIn (lname, PID, Examination_date) values ('CSharp', '98', to_date('09-12-2007', 'DD-MM-YYYY' ));
insert into ProficientIn (lname, PID, Examination_date) values ('CSharp', '97', to_date('01-06-2005', 'DD-MM-YYYY' ));
insert into ProficientIn (lname, PID, Examination_date) values ('C++', '99', to_date('02-10-1999', 'DD-MM-YYYY'));
insert into ProficientIn (lname, PID, Examination_date) values ('C++', '63', to_date('09-02-2001', 'DD-MM-YYYY'));


insert into LanguagesUsed (lname, tname) values ('Scala', 'Network Server');
insert into LanguagesUsed (lname, tname) values ('C++', 'Mobile App');
insert into LanguagesUsed (lname, tname) values ('C++', 'Network Server');
insert into LanguagesUsed (lname, tname) values ('CSharp', 'Virtual Reality');
insert into LanguagesUsed (lname, tname) values ('Java', 'Mobile App');
insert into LanguagesUsed (lname, tname) values ('CSharp', 'Wire Framework');
insert into LanguagesUsed (lname, tname) values ('Java', 'Virtual Reality');
insert into LanguagesUsed (lname, tname) values ('Scala', 'Simulation');
insert into LanguagesUsed (lname, tname) values ('Java', 'Mobile App');
insert into LanguagesUsed (lname, tname) values ('Scala', 'Simulation');




/* q1 */
SELECT tname, To_char(Completion_date, 'DD-MON-YYYY') as CompletionDate, 
Floor ((Completion_date - sysdate)) as Since
from Task
where isActive = 'Y'
order by (Completion_date - sysdate);



/* q2 */
/**
Find the IDs and names of all programmers who are assigned to a task that is to terminate some time in the year 2018; present the result in ascending order of programmer ID.
*/
SELECT programmer.ID, programmer.name 
from programmer, task
where task.completion_date > to_date('31-12-2017', 'DD-MM-YYYY')
        AND task.completion_date < to_date('01-01-2019', 'DD-MM-YYYY');




/**
For each programming language used in at least one active task, 
display its name, the most senior programmer(s) in terms of proficiency, and 
the date that was achieved.
*/
/*
SELECT distinct LanguagesUsed.lname, Programmer.Name, TO_CHAR(MAX(sysdaye - Examination_date), 'DD-MM-YYYY') 
FROM ProficientIn, LanguagesUsed
WHERE LanguagesUsed.lname = ProficientIn.lname AND
*/
SELECT distinct Programmer.Name, TO_CHAR(Examination_date, 'DD-MM-YYYY') as Since
FROM Programmer, (select * 
        from ProficientIn
        Right join LanguagesUsed on ProficientIn.lname = LanguagesUsed.lname
        --Where LanguagesUsed.lname = ProficientIn.lname 
        Order by (sysdate - Examination_date) DESC
        ) sq1
    where sq1.PID = Programmer.ID;

/**
For each programming language, display the id's and names of programmer supervisor pairs whenever both the programmer and his/her supervisor are proficient in that language. Do not list a programmer who is his/her own supervisor 
*/

select Programmer.ID, Programmer.SID, n1.lname
from Programmer, ProficientIn n1, ProficientIn n2
where n1.lname = n2.lname 
AND n1.PID = Programmer.ID
AND n2.PID = Programmer.SID;

/** Terminate a task. Take its name as input */

CREATE OR REPLACE PROCEDURE terminate_task (n IN CHAR)
as
BEGIN
        update Task
        set isActive = 'N',
            Completion_date = To_Date(sysdate, 'DD-MM-YYYY')
        where tname = n;
END;

/**
Handlee a programmer who is leaving or retiring. Take his/her ID. */

CREATE OR REPLACE PROCEDURE retire(pid IN number)
AS
cursor c1 is select * from Works_On;
BEGIN 
        FOR numbers in c1 LOOP
                update Programmer
                set Programmer.isActive = 'N'
                where ID = pid;
        END LOOP;
END;

/**
Given an already terminated task name as input, display the names of all programmers who were assigned to this task and the number of days they worked. Print a message if the task does not exist. 
*/

CREATE OR REPLACE PROCEDURE list_programmers(task_name CHAR)
AS 
DECLARE 
proname CHAR (16);

BEGIN
        FOR numbers in Works_On LOOP
                select Name
                from Programmer
                where numbers.PID = ID;
        END LOOP;
END;

