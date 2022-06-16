--    Temporary Table that joins 3 tables and specific columns with specific conditions
--    This temp table will be used as the starting point for performing A/B testing
with warby_parker as (
select distinct q.user_id, 
h.user_id is not null as 'is_home_try_on',
h.number_of_pairs, 
p.user_id is not null as 'is_purchase'
from quiz as 'q'
left join home_try_on as 'h'
on h.user_id = q.user_id
left join purchase as 'p'
on p.user_id = h.user_id
)

--    Single value that is the calculation of the total number of purchases from people who decided from 3 pairs of glasses 
--    divided by the total number of purchases from people who decided from 5 pairs of glasses
select (select 1.0 * sum(is_purchase) from warby_parker where number_of_pairs = '3 pairs') / (select sum(is_purchase) from warby_parker where number_of_pairs = '5 pairs') as '3 vs 5';

--    Temporary Table that displays the total number of users that reached each question
usage_funnel as (select question, 
count(*) as 'total'
from survey
group by question),

--    Temp Table that displays the table "usage_funnel" and adds a window function that lags the total number of 
--    users that reached each question by 1 row
--    This temp table is a setup for our final query
funnel_with_lag as (select 
question,
total,
lag(total, 1, 0) over(
  order by question
) as lagged
from usage_funnel)

--    displays the same data from the last temp table as well as the rate of users that moved from one question to the next    
select 
question,
total,
lagged,
1.0 * total / lagged as stayed_on_rate
from funnel_with_lag;
