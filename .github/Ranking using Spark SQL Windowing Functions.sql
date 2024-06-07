-- Databricks notebook source
SELECT * FROM PARQUET.`dbfs:/public/retail_db/daily_product_revenue`
ORDER BY 1, 3 DESC

-- COMMAND ----------

CREATE OR REPLACE TEMPORARY VIEW daily_product_revenue
USING PARQUET
OPTIONS (
  path='dbfs:/public/retail_db/daily_product_revenue'
)

-- COMMAND ----------

SELECT * FROM daily_product_revenue
ORDER BY 1, 3 DESC

-- COMMAND ----------

SELECT dpr.*,
rank() OVER (ORDER BY revenue DESC) AS rnk,
dense_rank() OVER (ORDER BY revenue DESC) AS drnk
FROM daily_product_revenue AS dpr
WHERE dpr.order_date LIKE '2013-07-26%'
ORDER BY 1, 3 DESC

-- COMMAND ----------

SELECT dpr.*,
rank() OVER (PARTITION BY dpr.order_date ORDER BY revenue DESC) AS rnk
FROM daily_product_revenue AS dpr
ORDER BY 1, 3 DESC

-- COMMAND ----------

/* Get top 5 products based on revenue, using rank */
SELECT * FROM 
  (SELECT dpr.*,
    rank() OVER (ORDER BY revenue DESC) AS rnk,
    dense_rank() OVER (ORDER BY revenue DESC) AS drnk
  FROM daily_product_revenue AS dpr
  WHERE dpr.order_date LIKE '2013-07-26%')
WHERE drnk <= 5

-- COMMAND ----------

/*Select top 5 performing product per month  using nested query*/
SELECT * FROM (
  SELECT dpr.*,
    dense_rank() OVER (PARTITION BY dpr.order_date ORDER BY revenue DESC) AS drnk
  FROM daily_product_revenue AS dpr)
WHERE drnk <=  5
ORDER BY 1, 3 DESC

-- COMMAND ----------

/*Using CTE to get daily product revenue, based on ranks */
WITH daily_product_revenue_ranked_cte AS (
    SELECT dpr.*,
    dense_rank() OVER (PARTITION BY dpr.order_date ORDER BY revenue DESC) AS drnk
  FROM daily_product_revenue AS dpr
) 
SELECT * FROM daily_product_revenue_ranked_cte
WHERE drnk <= 5
ORDER BY 1, 3 DESC

-- COMMAND ----------

/* Get ranks using views */
CREATE OR REPLACE TEMPORARY VIEW daily_product_revenue_ranked_v
AS 
SELECT dpr.*,
  dense_rank() OVER (PARTITION BY dpr.order_date ORDER BY revenue DESC) AS drnk
FROM daily_product_revenue AS dpr


-- COMMAND ----------

SELECT * FROM daily_product_revenue_ranked_v
WHERE drnk <= 3
ORDER BY 1, 3 DESC
