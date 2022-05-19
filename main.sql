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

select sum(is_purchase), sum(is_home_try_on), count(user_id), sum(number_of_pairs) from warby_parker;

select (select 1.0 * sum(is_purchase) from warby_parker where number_of_pairs = '3 pairs') / (select sum(is_purchase) from warby_parker where number_of_pairs = '5 pairs') as '3 vs 5';

select 1.0 * (sum(is_purchase)) / (count(number_of_pairs)) from warby_parker where number_of_pairs like '5%';

usage_funnel as (select question, 
count(*) as 'total'
from survey
group by question),

funnel_with_lag as (select 
question,
total,
lag(total, 1, 0) over(
  order by question
) as lagged
from usage_funnel)

select 
question,
total,
lagged,
1.0 * total / lagged as stayed_on_rate
from funnel_with_lag;