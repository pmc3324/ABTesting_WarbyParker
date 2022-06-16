# ABTesting_WarbyParker


Thanks to Codecademy for supplying the cleaned data from Warby Parker,

I conducted A/B testing on whether trying on 3 or 5 pairs of glasses at home brought more purchases

I also calculated the percentage of users we kept through each question from the survey table, which could lead to an A/B testing of what
questions could be asked to keep more users engaged through the last question and lead to the next process of trying on glasses.

In here, I'm using JOIN, DISTINCT, TEMP TABLE, aggregate functions, GROUP BY, window functions with LAG to create a running total using ORDER BY, and operators.

There are four csv files(home_try_on, quiz, survey, and purchase) that can be stored as tables in a database:

home_try_on should have columns: user_id(varchar), num_of_pairs(varchar), address(varchar)

quiz should have columns: user_id(varchar), style(varchar), fit(varchar), shape(varchar), color(varchar)

survey should have columns: question(varchar), user_id(varchar), response(varchar)

purchase should have columns: user_id(varchar), product_id(int), style(varchar), model_name(varchar), color(varchar), price(int)
