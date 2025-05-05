SELECT 
    {{ dbt_utils.generate_surrogate_key(['orders.orderNumber', 'orderdetails.orderLineNumber']) }} AS  fact_order_key,
    {{ dbt_utils.generate_surrogate_key(['customers.customerNumber'])}} AS customer_key, 
    {{dbt_utils.generate_surrogate_key(['employees.employeeNumber'])}} AS employee_key,
    {{dbt_utils.generate_surrogate_key(['offices.officeCode'])}} AS office_key,
    {{dbt_utils.generate_surrogate_key(['productCode'])}} AS product_key, 
    {{var("source_schema")}}.orders.orderDate AS order_date,
    {{var("source_schema")}}.orders.requiredDate AS order_required_date, 
   {{var("source_schema")}}.orders.shippedDate AS order_shipped_date,
   {{var("source_schema")}}.orderdetails.quantityOrdered AS quantity_ordered, 
   {{var("source_schema")}}.orderdetails.priceEach AS product_price
FROM {{var("source_schema")}}.orders
JOIN {{var("source_schema")}}.orderdetails ON {{var("source_schema")}}.orders.orderNumber = {{var("source_schema")}}.orderdetails.orderNumber
JOIN {{var("source_schema")}}.customers ON {{var("source_schema")}}.orders.customerNumber = {{var("source_schema")}}.customers.customerNumber
JOIN {{var("source_schema")}}.employees ON {{var("source_schema")}}.customers.salesRepEmployeeNumber = {{var("source_schema")}}.employees.employeeNumber
JOIN {{var("source_schema")}}.offices ON {{var("source_schema")}}.employees.officeCode = {{var("source_schema")}}.offices.officeCode