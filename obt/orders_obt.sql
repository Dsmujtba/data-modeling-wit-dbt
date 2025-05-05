SELECT
    {{var("source_schema")}}.orderdetails.orderNumber as order_number,
    {{var("source_schema")}}.orderdetails.orderLineNumber as order_line_number,
    {{var("source_schema")}}.products.productName as product_name,
    {{var("source_schema")}}.products.productScale as product_scale,
    {{var("source_schema")}}.products.productVendor as product_vendor,
    {{var("source_schema")}}.products.productDescription as product_description,
    {{var("source_schema")}}.products.buyPrice as product_buy_price,
    {{var("source_schema")}}.products.MSRP as product_msrp,
    {{var("source_schema")}}.productlines.textDescription as product_line,
    {{var("source_schema")}}.orderdetails.quantityOrdered as quantity_ordered,
    {{var("source_schema")}}.orderdetails.priceEach as product_price,
    {{var("source_schema")}}.orders.orderDate as order_date,
    {{var("source_schema")}}.orders.requiredDate as order_required_date,
    {{var("source_schema")}}.orders.shippedDate as order_shipped_date,
    {{var("source_schema")}}.customers.customerName as customer_name,
    {{var("source_schema")}}.customers.city as customer_city,
    {{var("source_schema")}}.customers.state as customer_state,
    {{var("source_schema")}}.customers.postalCode as customer_postal_code,
    {{var("source_schema")}}.customers.creditLimit as customer_credit_limit,
    {{var("source_schema")}}.employees.firstName as sales_rep_first_name,
    {{var("source_schema")}}.employees.lastName as sales_rep_last_name,
    {{var("source_schema")}}.employees.jobTitle as sales_rep_title,
    {{var("source_schema")}}.orders.status as order_status,
    {{var("source_schema")}}.orders.comments as order_comments
FROM {{var("source_schema")}}.orderdetails
JOIN {{var("source_schema")}}.orders ON {{var("source_schema")}}.orderdetails.orderNumber =  {{var("source_schema")}}.orders.orderNumber
JOIN {{var("source_schema")}}.products ON {{var("source_schema")}}.orderdetails.productCode =  {{var("source_schema")}}.products.productCode
JOIN {{var("source_schema")}}.productlines ON {{var("source_schema")}}.products.productLine =  {{var("source_schema")}}.productlines.productLine
JOIN {{var("source_schema")}}.customers ON {{var("source_schema")}}.orders.customerNumber =  {{var("source_schema")}}.customers.customerNumber
JOIN {{var("source_schema")}}.employees ON {{var("source_schema")}}.customers.salesRepEmployeeNumber =  {{var("source_schema")}}.employees.employeeNumber