select * from Nykaa_Realistic_Marketing_Datas$;

--Campaign_id -- Unique Id for eacgh campaign 
--Campaign Type 
--Target_audience --- Influencer as campaign type then its target audience will be Beauty Enthusiasts
--Channel Used -- which channel is used for campagin 
--Duration -- in days
--Impressions -- how many times ad was shown
--Clicks -- how many people clicked 
--leads-- people who showed interest 
--Conversions -- people who actually purchased/ converted
--Acquisition_cost --money spent to acquire customer
--Revenue -- 
--Engagement_score --overall engagement level
--ROI -- Return compared with marketing cost
--DATE
--Festive Season -- yes or no 
--CTR -- % of impression that became clicks 
--CPC -- Cost for one click 
--CPA -- cost for one conversion/customer
--AOV -- Average order value
--Bonus Rate -- % of leaving without further iteraction
--Time on page in sec -- avg time spent on page 

SELECT campaign_id, COUNT(*) FROM Nykaa_Realistic_Marketing_Datas$ GROUP BY campaign_id HAVING COUNT(*) > 1;



select campaign_type, count(*) as total_records 
from Nykaa_Realistic_Marketing_Datas$
group by campaign_type
order by total_records DESC;

select sum(revenue) as Total_revenue from Nykaa_Realistic_Marketing_Datas$;

select sum(acquisition_cost)  from Nykaa_Realistic_Marketing_Datas$;


-- Performance Analysis


-- Q1. Find the revenue by campaign types
   
SELECT Campaign_Type, CONCAT(ROUND(SUM(Revenue)/1000000,2),'M') AS Total_Revenue  -- to get revenue in M we divided it by 1,000,000
FROM Nykaa_Realistic_Marketing_Datas$
GROUP BY Campaign_Type
ORDER BY Total_Revenue DESC;


-- Q2. Which campaign type generates the highest revenue
   
SELECT top 1 Campaign_Type, CONCAT(ROUND(SUM(Revenue)/1000000,2),'M') AS Total_Revenue  -- to get revenue in M we divided it by 1,000,000
FROM Nykaa_Realistic_Marketing_Datas$
GROUP BY Campaign_Type
ORDER BY Total_Revenue DESC;


-- Q3. Which campaign type has the highest ROI?
SELECT top 1 Campaign_Type,round(avg(ROI)*100, 2) as Highest_ROI-- if the decimal represents a proportion and you want to display it as a percentage
FROM Nykaa_Realistic_Marketing_Datas$
GROUP BY Campaign_Type
ORDER BY Highest_ROI DESC;

-- Q4. Which campaign type has the highest CTR?
SELECT top 1 Campaign_Type,round(avg(CTR), 2) as Highest_CTR-- if the decimal represents a proportion and you want to display it as a percentage
FROM Nykaa_Realistic_Marketing_Datas$
GROUP BY Campaign_Type
ORDER BY Highest_CTR DESC;

SELECT top 1 Campaign_Type,round(sum(clicks)*100.0 / sum(impressions), 2)  as Highest_CTR-- if the decimal represents a proportion and you want to display it as a percentage
FROM Nykaa_Realistic_Marketing_Datas$
GROUP BY Campaign_Type
ORDER BY Highest_CTR DESC;


-- FUNNEL ANALYSIS
--A funnel means the journey a customer takes from first seeing a campaign until finally becoming a customer.
--Impression --> clicks --> Leads --> conversions

-- Q1. Which channel generates the highest conversions?
SELECT top 1 channel_used ,round(sum(conversions), 0)  as Highest_Conversion-- if the decimal represents a proportion and you want to display it as a percentage
FROM Nykaa_Realistic_Marketing_Datas$
GROUP BY channel_used
ORDER BY Highest_Conversion DESC; 


SELECT top 1 channel_used ,round(sum(conversions), 0)  as Highest_Conversion-- if the decimal represents a proportion and you want to display it as a percentage
FROM Nykaa_Realistic_Marketing_Datas$
GROUP BY channel_used
ORDER BY sum(conversions) DESC;   -- Do not use Alias when we use Format in SELECT statment because it converts vales into String and sort lexicographical instead of numerical sorting

-- Q2. Conversion Rate by channel

select channel_used, round(sum(conversions) *100.0 / sum(leads), 2) as conversion_rate
from Nykaa_Realistic_Marketing_Datas$
group by channel_used
order by conversion_rate DESC;



-- Q3 Which channel loses the most users in the funnel?
select top 1 channel_used, sum(leads) as total_leads, sum(conversions) as total_conversions,
       round(((sum(leads) - sum(conversions)) / sum(leads))* 100, 2) as conversion_lost_rate
from Nykaa_Realistic_Marketing_Datas$
group by channel_used
order by conversion_lost_rate DESC;

-- Q4. Lead generation rate by channel
--people who showed interest and then clicked 
select channel_used, 
       round(sum(leads) * 100.0 / sum(clicks),2) as lead_generation_rate
from Nykaa_Realistic_Marketing_Datas$
group by channel_used
order by lead_generation_rate DESC;

-- COST ANALYSIS --

-- Q1. Which campaign has the lowest CPA?
--cost for one conversion/customer -- so email has lowest CPA 
select top 1 campaign_type, round(avg(CPA),2) as avg_CPA
from Nykaa_Realistic_Marketing_Datas$
group by campaign_type
order by avg(CPA) ASC;


-- Q2. Which channel has the lowest CPC?
--CPC - cost for one click -- email has lowest CPC
select top 1 campaign_type, round(avg(CPC),2) as avg_CPC
from Nykaa_Realistic_Marketing_Datas$
group by campaign_type
order by avg(CPC) ASC;

-- Q3. Which campaign type spends the most money?
select campaign_type,
       concat(round(sum(acquisition_cost)/1000000,2),'M') as total_money_spent
from Nykaa_Realistic_Marketing_Datas$
group by campaign_type
order by total_money_spent DESC;

select campaign_type,
       concat(round(sum(acquisition_cost)/1000000,2),'M') as total_money_spent
from Nykaa_Realistic_Marketing_Datas$
group by campaign_type
order by sum(acquisition_cost) DESC;

--Here we can see that difference of using sum in order by and alias name 

-- AUDIENCE ANALYSIS

-- Q1. Which audience generates highest revenue?
--As we can see working professional has generated most of the revenue 
select top 1  target_audience,
       concat(round(sum(revenue)/1000000,2), 'M') as total_revenue
from Nykaa_Realistic_Marketing_Datas$
group by target_audience
order by sum(revenue) DESC;

-- Q2. Which audience has highest engagement?
--Young Adults audience has  2-3% of highest engagement than Beauty Enthusiasts audience
select top 2  target_audience,
       round(AVG(engagement_score),2) as avg_eng_score
from Nykaa_Realistic_Marketing_Datas$
group by target_audience
order by AVG(engagement_score) DESC;

-- Q3. Which audience gives best ROI?
select top 2  target_audience,
       concat(AVG(ROI)*100,'%') as ROI
from Nykaa_Realistic_Marketing_Datas$
group by target_audience
order by avg(ROI) DESC;

-- Q5. Which audience is most cost-efficient to acquire?   
select Target_audience, round(avg(CPA),2) as avg_cost_per_acq
from Nykaa_Realistic_Marketing_Datas$
group by Target_audience
order by avg(CPA);

SELECT
    MIN(CPA) AS Min_CPA,
    MAX(CPA) AS Max_CPA,
    AVG(CPA) AS Avg_CPA
FROM Nykaa_Realistic_Marketing_Datas$;



with cpa_stats as (select PERCENTILE_CONT(0.25) within group (order by CPA) over() as Q1,
       PERCENTILE_CONT(0.75) within group (order by CPA) over() as Q3
from Nykaa_Realistic_Marketing_Datas$)
select Q1,Q3, Q3-Q1 as IQR,
       Q3 + 1.5 * (Q3-Q1) as upper_limit,
       Q1 - 1.5 * (Q3-Q1) as lower_limit
from cpa_stats;

SELECT *
FROM Nykaa_Realistic_Marketing_Datas$
WHERE CPA > 3159.5375
ORDER BY CPA DESC;



-- Q6. Conversion rate by audience
select target_audience, round(sum(conversions)*100.0/ sum(leads),2) as conversion_rate
from Nykaa_Realistic_Marketing_Datas$
group by target_audience
order by conversion_rate DESC;

-- Festive Analysis --
-- Q1. Festive vs Non-Festive Revenue
select festive_season, concat(round(sum(revenue)/1000000,2),'M') as total_revenue
from Nykaa_Realistic_Marketing_Datas$
group by festive_season
order by sum(revenue) DESC;

-- We have 10 months non-festive months and 4 festive months

select year(date) as yr, month(Date) as mn, festive_season
from Nykaa_Realistic_Marketing_Datas$
group by  month(Date), year(date), festive_season
order by year(date) DESC;

select festive_season,
       round(avg(revenue),2) as avg_revenue,
       round(avg(conversions),2) as avg_conversions,
       round(avg(ROI)*100,2) as avg_roi_per
from Nykaa_Realistic_Marketing_Datas$
group by festive_season


-- Q2.Festive vs Non-Festive ROI 
select festive_season, round(avg(ROI)*100,2) as avg_ROI_per
from Nykaa_Realistic_Marketing_Datas$
group by festive_season
order by avg_roi_per DESC;

-- Q3 Monthly Revenue Trend

select year(date) as yr, month(Date) as mn, round(sum(revenue),2) as total_revenue
from Nykaa_Realistic_Marketing_Datas$
group by  month(Date), year(date)
order by month(date),year(date); 

-- Q4. Monthly Conversion Trend

select year(date) as yr, month(Date) as mn, round(sum(conversions),2) as total_conversions
from Nykaa_Realistic_Marketing_Datas$
group by  month(Date), year(date)
order by month(date),year(date); 


-- Q5. Monthly Avg. AOV 
select CONVERT(char(7), TRY_CONVERT(date, [Date], 101), 120) AS Year_Month, round(avg(AOV),2) as avg_aov
from Nykaa_Realistic_Marketing_Datas$
group by  month(Date), year(date)
order by month(date),year(date); 

SELECT 
   *
FROM Nykaa_Realistic_Marketing_Datas$;

-- WRONG (misleading):
SELECT AVG(ROI) FROM Nykaa_Realistic_Marketing_Datas$ WHERE channel = 'Instagram';

-- RIGHT (recompute from totals):
SELECT campaign_type,
       SUM(Revenue) AS total_revenue,
       SUM(Acquisition_Cost) AS total_spend,
       ROUND((SUM(Revenue) - SUM(Acquisition_Cost)) * 100.0 / SUM(Acquisition_Cost), 2) AS true_roi
FROM Nykaa_Realistic_Marketing_Datas$
GROUP BY campaign_type;