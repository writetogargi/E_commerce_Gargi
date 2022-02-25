CREATE DATABASE e_commerce;
USE e_commerce;

/* Delete if Tables are Present */
DROP TABLE IF EXISTS `category`, `customer`, `order`, `product`, `product_details`, `rating`, `supplier`;

/* create Tables */
CREATE TABLE supplier(
	supp_id INT PRIMARY KEY,
    supp_name VARCHAR(50),
    supp_city VARCHAR(50),
    supp_phone BIGINT
    ) ;
    
DESC supplier;

CREATE TABLE customer(
	 cus_id INT PRIMARY KEY,
     cus_name VARCHAR(50),
     cus_phone BIGINT(15),
     cus_city VARCHAR(50),
     cus_gender VARCHAR(2)
) ;

DESC customer;

CREATE TABLE category(
	cat_id INT PRIMARY KEY,
    cat_name VARCHAR(50)
);

DESC category 

CREATE TABLE product(
	pro_id INT PRIMARY KEY,
    pro_name INT VARCHAR(50),
    pro_desc VARCHAR(50),
    cat_id INT,
    FOREIGN KEY(cat_id) REFERENCES category(cat_id)
    );
    
    DESC product;
    
    CREATE TABLE product_details(
    prod_id INT PRIMARY KEY,
    pro_id INT,
    supp_id INT,
    price FLOAT,
    FOREIGN KEY(pro_id) REFERENCES product(pro_id),
    FOREIGN KEY(supp_id) REFERENCES supplier(supp_id)
    );
    DESC product_details;
    
    CREATE TABLE 'order'(
    ord_id INT PRIMARY KEY,
    ord_amount FLOAT,
    ord_date DATE,
    cus_id INT,
    prod_id INT,
    FOREIGN KEY(cus_id) REFERENCES customer(cus_id),
    FOREIGN KEY(prod_id) REFERENCES product_details(prod_id)
    );
    
    DESC 'order';
    
    CREATE TABLE rating(
    rat_id INT PRIMARY KEY,
    cus_id INT,
    supp_id INT,
    rat_ratstars INT,
	FOREIGN KEY(cus_id) REFERENCES customer(cus_id),
    FOREIGN KEY(supp_id) REFERENCES product_details(supp_id)
    );
    DESC rating;
    
    /* Insert into th Tables */
    
    INSERT INTO supplier VALUES
    (1, "Rajesh Retails", "Delhi", 1234567890),
    (2, "Appario Ltd.", "Mumbai", 2589631470),
    (3, "Knome products", "Bangalore", 9785462315),
    (4, "Bansal Retail", "Kochi", 8975463285),
    (5, "Mittal Ltd", "Lucknow", 7898456532);
    
    SELECT * FROM supplier;
    
    INSERT INTO customer VALUES
    (1, "AAKASH", 9999999999, "DELHI", "M"),
    (2, "AMAN", 9785463215, "NOIDA", "M"),
    (3, "NEHA", 9999999999, "MUMBAI", "F"),
    (4, "MEGHA", 9994562399, "KOLKATA", "F"),
    (5, "PULKIT", 7895999999, "LUCKNOW", "M");
    
    SELECT * FROM customer;
    
    INSERT INTO category VALUES
    (1, "BOOKS"),
    (2, "GAMES"),
    (3, "GROCERIES"),
    (4, "ELECTRONICS"),
    (5, "CLOTHES");
    
    SELECT * FROM category;
    
    INSERT INTO product VALUES
    (1, "GTA V", "DFJDJFDJFDJFDJFJF", 2),
    (2, "TSHIRT", "DFDFJDFJDKFD", 5),
    (3, "ROG LAPTOP", "DFNTTNTNTERND", 4),
    (4, "OATS", "REURENTBTOTH", 3),
    (5, "HARRY POTTER", "NBEMCTHTJTH", 1);
    
	SELECT * FROM product;
    
    INSERT INTO product_details VALUES
    (1, 1, 2, 1500),
    (2, 3, 5, 30000),
    (3, 5, 1, 3000),
    (4, 2, 3, 2500),
    (5, 4, 1, 1000);
    
    SELECT * FROM product_details;
    
    INSERT INTO `order` VALUES
    (20, 1500, "2021-10-12", 3, 5),
    (25, 30500, "2021-09-16", 5, 2),
    (26, 2000, "2021- 10-05", 1, 1),
    (30, 3500, "2021-08-16", 4, 3),
    (50, 2000, "2021-10-06", 2, 1);
    
    SELECT * FROM `order`;
    
    INSERT INTO rating VALUES
    (1, 2, 2, 4);
    INSERT INTO rating VALUES
    (2, 3, 4, 3);
    INSERT INTO rating VALUES
    (3, 5, 1, 5);
    INSERT INTO rating VALUES
    (4, 1, 3, 2);
    INSERT INTO rating VALUES
    (5, 4, 5, 4);
    
    SELECT * FROM rating ;
    
    /*
		3) Display the number of the customer group by their genders who 
        have placed any order of amount greater than or equal to Rs 3000
        
    */
    SELECT cus_gender , count(cus_name) FROM 
    (SELECT cus_name, cus_gender 
		FROM customer 
        INNER JOIN 
			(SELECT * FROM `order` WHERE ord_amount >=3000) as q ON customer.cus_id = q.cus_id) AS output
GROUP BY cus_gender;

/*
 4) Display all the orders along with the product name ordered by a customer having customer_id=2.
 */
 
 SELECT product.pro_name, Q.*
		FROM product
        INNER JOIN 
        `order` AS Q ON Q.prod_id = product.pro_id WHERE Q.cus_id = 2;
        
  /*
  5)  Display the Supplier details who can supply more than one product.
  */
  
  SELECT * FROM supplier 
	WHERE supplier.supp_id = (SELECT supp_id
		FROM
        (SELECT supp_id, COUNT(supp_id) FROM product_details GROUP BY supp_id HAVING COUNT(supp_id)>1) AS S);
        
/*
6) Find the category of the product whoes order amount is minimum
*/

SELECT cat_id FROM product WHERE product.pro_id = (SELECT prod_id
 FROM 
	(SELECT * FROM `order` WHERE ord_amount=(SELECT min(ord_amount) FROM `order`)) AS min 
    );
    
/*
7) Display the id and the name of the product ordered after "2021-10-05". 	
 */   
SELECT pro_id, pro_name, ord_date FROM product 
 INNER JOIN 
 (SELECT* FROM `order` WHERE ord_date > "2021-10-05") AS Z ON Z.prod_id = product.prod_id;
 
 /*
 8) Display customer name  and gender whoes names start or ends with character "A"
 */
 SELECT cus_name, cus_gender FROM customer WHERE cus_name like 'A%' OR cus_name LIKE '%A';
 

 


        
  
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     
     

