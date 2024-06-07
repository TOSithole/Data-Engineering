# Databricks notebook source
retail_key = dbutils.secrets.get('saudemyretail', 'saudemyretailkey')

# COMMAND ----------

spark.conf.set('fs.azure.account.key', retail_key )

# COMMAND ----------

# MAGIC %fs ls abfss://data@saudemyretail.dfs.core.windows.net/retail_db
