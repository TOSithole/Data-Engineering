-- Databricks notebook source
CREATE DATABASE IF NOT EXISTS itversity_retail_bronze

-- COMMAND ----------

USE itversity_retail_bronze

-- COMMAND ----------

CREATE OR REPLACE TEMPORARY VIEW $table_name
USING PARQUET
OPTIONS (
  path='${bronze_base_dir}/${table_name}'
) 
/* '/public/retail_db_bronze/orders' */

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS $table_name
AS SELECT * FROM $table_name

-- COMMAND ----------

Show tables
