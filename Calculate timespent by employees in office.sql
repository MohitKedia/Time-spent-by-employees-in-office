##Calculate timespent by employees in office

show databases;
use mohitdb;
CREATE TABLE employee(
  EmpID INT,
  Action_ varchar(10),
  Created TIMESTAMP);
  

INSERT INTO employee VALUES ('1','In ','2019-04-01 12:00:00');
INSERT INTO employee VALUES ('1','Out','2019-04-01 15:00:00');
INSERT INTO employee VALUES ('1','In ','2019-04-01 17:00:00');
INSERT INTO employee VALUES ('1','Out','2019-04-01 21:00:00');
INSERT INTO employee VALUES ('1','In ','2019-04-01 22:00:00');
INSERT INTO employee VALUES ('1','Out','2019-04-01 23:00:00');
INSERT INTO employee VALUES ('2','In ','2019-04-01 10:00:00');
INSERT INTO employee VALUES ('2','Out','2019-04-01 13:00:00');
INSERT INTO employee VALUES ('2','In ','2019-04-01 15:00:00');
INSERT INTO employee VALUES ('2','Out','2019-04-01 18:00:00');


select * from employee

WITH Out_ as 
(select empid,action_,created,created_lag from
(Select empid,action_,created,lag(created)OVER(PARTITION by empid order by created) created_lag
from employee) as A
where action_ = 'Out')

select empid,sum(hour(created)-hour(created_lag)) as timespent
from Out_
group by 1
order by 1
