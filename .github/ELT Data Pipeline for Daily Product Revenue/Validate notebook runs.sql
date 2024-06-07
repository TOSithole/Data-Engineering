-- Databricks notebook source
-- MAGIC %run "./01 Cleanup Database and Datasets" $bronze_base_dir=$bronze_base_dir $gold_base_dir=$gold_base_dir

-- COMMAND ----------

-- MAGIC %run "./02 File Format Converter" $ds=orders $src_base_dir=$src_base_dir $bronze_base_dir=$bronze_base_dir

-- COMMAND ----------

-- MAGIC %run "./02 File Format Converter" $ds=order_items $src_base_dir=$src_base_dir $bronze_base_dir=$bronze_base_dir

-- COMMAND ----------

-- MAGIC %run "./03 Create Spark SQL Tables" $table_name=orders $bronze_base_dir=$bronze_base_dir

-- COMMAND ----------

-- MAGIC %run "./03 Create Spark SQL Tables" $table_name=order_items $bronze_base_dir=$bronze_base_dir

-- COMMAND ----------

SHOW tables

-- COMMAND ----------

SELECT count(*) FROM orders

-- COMMAND ----------

SELECT count(*) FROM order_items

-- COMMAND ----------

-- MAGIC %run "./04 Daily Product Revenue" $gold_base_dir=$gold_base_dir

-- COMMAND ----------

-- MAGIC %fs ls /public/retail_db_gold

-- COMMAND ----------


