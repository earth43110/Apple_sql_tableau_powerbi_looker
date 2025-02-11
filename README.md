## Project Overview

This project is designed to showcase advanced SQL querying techniques through the analysis of over 1 million rows of Apple retail sales data. The dataset includes information about products, stores, sales transactions, and warranty claims across 
various Apple retail locations globally. By tackling a variety of questions, from basic to complex, this project demonstrates the ability to write sophisticated SQL queries that extract valuable insights from large datasets.

## PowerBI Dashboard Link
https://app.powerbi.com/view?r=eyJrIjoiMDZlOGU4ZjAtZjg2Yi00NWVhLTkxNjUtYWMyYTY0Y2I2YmI1IiwidCI6ImVhY2U1MTkxLWY0NDItNGExMS05NzMzLWI3YmViNWIwMTg2YSIsImMiOjF9

- Created PowerBI dashboard with 3 visuals and descriptions on product sales details

## Tableau Dashboard Link
[https://public.tableau.com/shared/6QKG4CGNW?:display_count=n&:origin=viz_share_link](https://public.tableau.com/views/AppleSales2/SalesDetailsDashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)
- Tableau version

## Looker Dashboard Link
https://lookerstudio.google.com/embed/reporting/874f778e-f513-4e41-b8af-2c82ee8bab1f/page/oRepE
- Looker studio version

## Entity Relationship Diagram (ER)
![erd](https://github.com/user-attachments/assets/13df2535-4aa6-436f-a037-49eef13e77d9)

## Database Schema

The project uses five main tables:

1. **stores**: Contains information about Apple retail stores.
   - `store_id`: Unique identifier for each store.
   - `store_name`: Name of the store.
   - `city`: City where the store is located.
   - `country`: Country of the store.

2. **category**: Holds product category information.
   - `category_id`: Unique identifier for each product category.
   - `category_name`: Name of the category.

3. **products**: Details about Apple products.
   - `product_id`: Unique identifier for each product.
   - `product_name`: Name of the product.
   - `category_id`: References the category table.
   - `launch_date`: Date when the product was launched.
   - `price`: Price of the product.

4. **sales**: Stores sales transactions.
   - `sale_id`: Unique identifier for each sale.
   - `sale_date`: Date of the sale.
   - `store_id`: References the store table.
   - `product_id`: References the product table.
   - `quantity`: Number of units sold.

5. **warranty**: Contains information about warranty claims.
   - `claim_id`: Unique identifier for each warranty claim.
   - `claim_date`: Date the claim was made.
   - `sale_id`: References the sales table.
   - `repair_status`: Status of the warranty claim (e.g., Paid Repaired, Warranty Void).

## Objectives

1. Find the number of stores in each country.
2. Calculate the total number of units sold by each store.
3. Identify how many sales occurred in December 2023.
4. Determine how many stores have never had a warranty claim filed.
5. Calculate the percentage of warranty claims marked as "Warranty Void".
6. Identify which store had the highest total units sold in the last year.
7. Count the number of unique products sold in the last year.
8. Find the average price of products in each category.
9. How many warranty claims were filed in 2020?
10. For each store, identify the best-selling day based on highest quantity sold.
11. Identify the least selling product in each country for each year based on total units sold.
12. Calculate how many warranty claims were filed within 180 days of a product sale.
13. Determine how many warranty claims were filed for products launched in the last two years.
14. List the months in the last three years where sales exceeded 5,000 units in the USA.
15. Identify the product category with the most warranty claims filed in the last two years.
16. Determine the percentage chance of receiving warranty claims after each purchase for each country.
17. Categorize the number of units sold by store as sales being 'high', 'medium', and 'low'.

## Dataset

- **Size**: 1 million+ rows of sales data.
- **Period Covered**: The data spans multiple years, allowing for long-term trend analysis.
- **Geographical Coverage**: Sales data from Apple stores across various countries.
