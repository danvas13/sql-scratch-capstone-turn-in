First Touch Query


WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
                pv.utm_campaign
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp;


1.How many campaigns and sources does CoolTShirts use? Which source is used for each campaign?


* one for the number of distinct campaigns,


SELECT COUNT(DISTINCT(utm_campaign))                        8
FROM page_visits; 


* one for the number of distinct sources,


SELECT COUNT(DISTINCT(utm_source))                                6
FROM page_visits;


* one to find how they are related.


SELECT DISTINCT(utm_campaign),utm_source
FROM page_visits;


















2. What pages are on the CoolTShirts website?


SELECT DISTINCT(page_name)
FROM page_visits;




1 - landing_page
	2 - shopping_cart
	3 - checkout
	4 - purchase
	



3. How many first touches is each campaign responsible for?


WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT ft.user_id,
    ft.first_touch_at,
    pv.utm_source,
        pv.utm_campaign, COUNT(*)
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign;






ANSWER: 


user_id
	first_touch_at
	utm_source
	utm_campaign
	COUNT(*)
	99684
	2018-01-13 13:20:49
	google
	cool-tshirts-search
	169
	99933
	2018-01-25 00:04:39
	nytimes
	getting-to-know-cool-tshirts
	612
	99990
	2018-01-13 23:30:09
	medium
	interview-with-cool-tshirts-founder
	622
	99765
	2018-01-04 05:59:46
	buzzfeed
	ten-crazy-cool-tshirts-facts
	576
	



4. How many last touches is each campaign responsible for?
Starting with the last-touch query from the lesson, group by campaign and count the number of last touches for each.


WITH last_touch AS (
  SELECT user_id,
   MAX(timestamp) as last_touch_at
FROM page_visits
GROUP BY user_id)
SELECT lt.user_id, lt.last_touch_at, pv.utm_source, pv.utm_campaign, COUNT(*)
FROM last_touch lt
JOIN page_visits pv
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
  GROUP BY pv.campaign;














ANSWER: 


user_id
	last_touch_at
	utm_source
	utm_campaign
	COUNT(pv.utm_campaign)
	99344
	2018-01-18 21:36:32
	google
	cool-tshirts-search
	60
	99589
	2018-01-15 04:55:43
	nytimes
	getting-to-know-cool-tshirts
	232
	99838
	2018-01-02 07:40:34
	medium
	interview-with-cool-tshirts-founder
	184
	98840
	2018-01-10 04:58:48
	google
	paid-search
	178
	99928
	2018-01-24 05:26:09
	facebook
	retargetting-ad
	443
	99990
	2018-01-16 11:35:09
	email
	retargetting-campaign
	245
	99765
	2018-01-04 05:59:47
	buzzfeed
	ten-crazy-cool-tshirts-facts
	190
	99933
	2018-01-26 06:18:39
	email
	weekly-newsletter
	447
	



5. How many visitors make a purchase?


SELECT COUNT(DISTINCT(user_id)),
   MAX(timestamp) as 'last_touch_at', page_name
FROM page_visits
GROUP BY page_name;     


ANSWER:










COUNT(DISTINCT(user_id))
	last_touch_at
	page_name
	1979
	2018-01-30 23:34:11
	1 - landing_page
	1881
	2018-01-31 03:49:25
	2 - shopping_cart
	1431
	2018-02-04 10:57:47
	3 - checkout
	361
	2018-02-04 11:09:47
	4 - purchase
	









6. How many last touches on the purchase page is each campaign responsible for?


WITH last_touch AS (
  SELECT user_id,
         MAX(timestamp) AS last_touch_at
  FROM page_visits
  WHERE page_name = '4 - purchase'
  GROUP BY user_id)
  SELECT lt.user_id, lt.last_touch_at, pv.utm_source, pv.utm_campaign, COUNT(*)
FROM last_touch lt
JOIN page_visits pv
  ON lt.user_id = pv.user_id
  AND lt.last_touch_at = pv.timestamp
  GROUP BY pv.campaign;










ANSWER:


user_id
	last_touch_at
	utm_source
	utm_campaign
	COUNT(*)
	95650
	2018-01-18 00:25:00
	google
	cool-tshirts-search
	2
	92172
	2018-01-16 15:15:29
	nytimes
	getting-to-know-cool-tshirts
	9
	83547
	2018-01-10 18:20:21
	medium
	interview-with-cool-tshirts-founder
	7
	94567
	2018-01-19 16:37:58
	google
	paid-search
	52
	99897
	2018-01-06 09:41:19
	facebook
	retargetting-ad
	113
	99285
	2018-01-24 09:00:58
	email
	retargetting-campaign
	54
	98651
	2018-01-15 04:17:36
	buzzfeed
	ten-crazy-cool-tshirts-facts
	9
	99933
	2018-01-26 06:18:39
	email
	weekly-newsletter
	115