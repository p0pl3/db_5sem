select id,
       first_name,
       middle_name,
       last_name,
       degree,
       age,
       AVG(age) over (PARTITION BY degree)
from employee;

select id,
       first_name,
       middle_name,
       last_name,
       salary,
       degree,
       SUM(salary) over (PARTITION BY degree)
from employee;

select id,
       first_name,
       middle_name,
       last_name,
       degree,
       count(*) over (PARTITION BY degree)
from employee;

select id,
       first_name,
       middle_name,
       last_name,
       salary,
       degree,
       max(salary) over (PARTITION BY degree)
from employee;

select id,
       first_name,
       middle_name,
       last_name,
       salary,
       degree,
       min(salary) over (PARTITION BY degree)
from employee;


-----


select id,
       first_name,
       middle_name,
       last_name,
       degree,
       row_number() over (PARTITION BY degree)
from employee as e;

select id,
       first_name,
       middle_name,
       last_name,
       salary,
       rank() over (order by salary desc )
from employee as e;

select id,
       first_name,
       middle_name,
       last_name,
       salary,
       dense_rank() over (order by salary desc )
from employee as e;

select id,
       first_name,
       middle_name,
       last_name,
       salary,
       ntile(4) over (order by salary desc )
from employee as e;


-------

select id,
       description as   current_description,
       user_transport_id,
       lag(description) over (partition by user_transport_id)
from "order";

select id,
       description as    current_description,
       user_transport_id,
       lead(description) over (partition by user_transport_id)
from "order";


select id,
       first_name,
       salary,
       degree,
       age,
       first_value(age) over (partition by degree order by age RANGE BETWEEN
           UNBOUNDED PRECEDING AND
           UNBOUNDED FOLLOWING)
from employee as e;

select id,
       first_name,
       salary,
       degree,
       age,
       last_value(age) over (partition by degree order by age RANGE BETWEEN
           UNBOUNDED PRECEDING AND
           UNBOUNDED FOLLOWING)
from employee as e;