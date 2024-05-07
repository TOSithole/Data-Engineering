Repository for data engineer projects.

<H1>Compute Daily Product Revenue</H1>

<h2>Description</h2>
<ul>This project is an Azure Data Engineering project that calculates total revenue of orders per product based on the given order month(year and month, yyyy-MM).</ul>
<ul>I used Azure Data Factory, Azure Data Studio, Azure SQL Database, Azure Synapse Analytics, SQL and Azure Blob Storage.</ul>

<h2>Dataset</h2>
<ul>I downloaded the dataset from Durga's(Udemy Lecturer) repository, https://github.com/dgadiraju/data/tree/master/retail_db, I used the Orders and Order Items folder, the data is comma delimited.</ul>
<ul>In the above folder I also referred to the create_db_tables_og.sql script for the schema.</ul>

<h2>Data Flows</h2>
<h3>DFFileFormatConverterOrders</h3>
<ul>This data flow has two activities.</ul>
<ul>The first activity is the data source, it reads data from the Orders table that is stored in Azure Blob Storage and sends it to the sink.</ul>
<ul>The second/last activity receives the data from the incoming stream(Orders), saves the data to OrdersParquet(data set) in Azure Blob storage in Parquet format.</ul>

<h3>DFFileFormatConverterOrderItems</h3>
<ul>This data flow has two activities.</ul>
<ul>The first activity is the data source, it reads data from the OrderItems table that is stored in Azure Blob Storage and sends it to the sink.</ul>
<ul>The second/last activity receives the data from the incoming stream(OrderItems), saves the data to OrderItemsParquet(data set) in Azure Blob storage.</ul>

<h3>ComputeDailyProductRevenue</h3>
<ul>This data flow has five activities.</ul>
<ul>The first two activities are for data sources(Orders and Order Items).</ul>
<ul>The third activity is for joining the two tables.</ul>
<ul>The forth one is an aggregate activity that calculates the total revenue of orders per product.</ul>
<ul>The last activity is the sink which uses an Azure Synapse data set for storing the results in a table.</ul>

<h2>Pipeline</h2>
<h3>CopyCSVDataToSQLTable</h3>
<ul>This pipeline has two Copy Data activities.</ul>
<ul>The first copy activity copies the Orders CSV file to an Orders dataset in Azure SQL Database.</ul>
<ul>The second copy activity copies the Order Items CSV file to an OrderItems dataset in Azure SQL Database.</ul>

<h3>PLFileFormatConverterOrders</h3>
<ul>This pipeline has one data flow activity.</ul>
<ul>It is used to execute the DFFileFormatConverterOrders data flow.</ul>

<h3>PLFileFormatConverterOrderItems</h3>
<ul>This pipeline has one data flow activity.</ul>
<ul>It is used to execute the DFFileFormatConverterOrderItems data flow.</ul>

<h3>PLComputeDailyProductRevenueParams</h3>
<ul>This pipeline has one data flow activity.</ul>
<ul>It is used to execute the ComputeDailyProductRevenue data flow.</ul>
<ul>It uses the customized IR(Integrated Runtime) with a time to live of 30min to reduce wait time of compute when executing and testing.</ul>
<ul>It has one parameter that will be used to specify the order month(Year and month yyyy-MM) that will be used by the data flow to filter the data.</ul>
