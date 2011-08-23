CREATE TABLE author
(
	authorid INTEGER,
	name VARCHAR2(15) NOT NULL,
	city VARCHAR2(15) NOT NULL,
	country VARCHAR2(15) NOT NULL,
	CONSTRAINT pk_authidauth PRIMARY KEY(authorid)
);

CREATE TABLE publisher
(
	publisherid INTEGER,
	name VARCHAR2(15) NOT NULL,
	city VARCHAR2(15) NOT NULL,
	country VARCHAR2(15) NOT NULL,
	CONSTRAINT pk_pubidpub PRIMARY KEY(publisherid)
);

CREATE TABLE category
(
	categoryid INTEGER,
	description VARCHAR2(15) NOT NULL,
	CONSTRAINT pk_catidcat PRIMARY KEY(categoryid)
);

CREATE TABLE catalog1
(
	bookid INTEGER,
	title VARCHAR2(15) NOT NULL,
	authorid INTEGER NOT NULL,
	publisherid INTEGER NOT NULL,
	categoryid INTEGER NOT NULL,
	year INTEGER NOT NULL,
	price INTEGER NOT NULL,
	CONSTRAINT fk_authidcat FOREIGN KEY(authorid) REFERENCES author(authorid) ON DELETE CASCADE,
	CONSTRAINT fk_pubidcat FOREIGN KEY(publisherid) REFERENCES publisher(publisherid) ON DELETE CASCADE,
	CONSTRAINT fk_catidcat FOREIGN KEY(categoryid) REFERENCES category(categoryid) ON DELETE CASCADE,
	CONSTRAINT pk_booidcat PRIMARY KEY(bookid)
);

CREATE TABLE orderdetails
(
	orderno INTEGER,
	bookid INTEGER,
	qty INTEGER check (qty>0),
	CONSTRAINT fk_booidordet FOREIGN KEY(bookid) REFERENCES catalog1(bookid) ON DELETE CASCADE,
	CONSTRAINT pk_ordrdet PRIMARY KEY(orderno,bookid)
);



=================================================================
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
INSERT INTO author VALUES('&authorid','&name','&city','&country');
INSERT INTO publisher VALUES('&publisherid','&name','&city','&country');
INSERT INTO category VALUES('&categoryid','&description');
INSERT INTO catalog1 VALUES('&bookid','&title','&authorid','&publisherid','&categoryid','&year','&price');
INSERT INTO orderdetails VALUES('&orderno','&bookid','&qty');
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

INSERT INTO author VALUES (1,'Uerialc','Bangalore','India');
INSERT INTO author VALUES (2,'Reshu','Bangalore','India');
INSERT INTO author VALUES (3,'Kumar','Taiwan','Japan');
INSERT INTO author VALUES (4,'Gudiya','Washington','USA');
INSERT INTO author VALUES (5,'Hansa','California','Europe');


INSERT INTO publisher VALUES (101,'Pearson','Bangalore','India');
INSERT INTO publisher VALUES (102,'Tata','Mumbai','Australia');
INSERT INTO publisher VALUES (103,'Sapna','Chansity','Europe');
INSERT INTO publisher VALUES (104,'Eco Buddy','Bhilai','Amazon');
INSERT INTO publisher VALUES (105,'OReiley','UK','Kingdom');


INSERT INTO category VALUES (1001,'Computer');
INSERT INTO category VALUES (1002,'Electronics');
INSERT INTO category VALUES (1003,'Maths');
INSERT INTO category VALUES (1004,'Science');
INSERT INTO category VALUES (1005,'Electrical');


INSERT INTO catalog1 VALUES (111,'lib1',1,101,1001,2002,500);
INSERT INTO catalog1 VALUES (112,'lib2',2,102,1002,2000,800);
INSERT INTO catalog1 VALUES (113,'lib3',3,103,1003,2003,200);
INSERT INTO catalog1 VALUES (114,'lib4',4,104,1001,2006,350);
INSERT INTO catalog1 VALUES (115,'lib5',5,105,1004,2007,100);
INSERT INTO catalog1 VALUES (116,'lib6',2,103,1005,2007,600);
INSERT INTO catalog1 VALUES (117,'lib7',2,105,1002,2007,450);
INSERT INTO catalog1 VALUES (118,'lib8',1,101,1001,2002,500);


INSERT INTO orderdetails VALUES (1,111,2);
INSERT INTO orderdetails VALUES (2,112,3);
INSERT INTO orderdetails VALUES (3,111,5);
INSERT INTO orderdetails VALUES (4,113,1);
INSERT INTO orderdetails VALUES (5,114,2);
INSERT INTO orderdetails VALUES (6,115,1);
INSERT INTO orderdetails VALUES (7,114,2);
INSERT INTO orderdetails VALUES (8,113,2);

===================================================
SELECT name AS "Author Name",city AS "City",country AS "Country"
FROM author 
WHERE AUTHORID IN (SELECT AUTHORID FROM catalog1 WHERE
    YEAR>2000 AND price>(SELECT AVG(price) FROM catalog1) 
    GROUP BY AUTHORID 
    HAVING COUNT(*)>=2);
===================================================
SELECT a.AUTHORID AS "Author ID",name AS "Author Name" 
FROM author a,catalog1 c 
WHERE a.AUTHORID=c.AUTHORID AND
   c.BOOKID=(SELECT BOOKID FROM orderdetails GROUP BY BOOKID HAVING
   SUM(qty)=(select MAX(SUM(qty)) from orderdetails 
   GROUP BY BOOKID));

======================================================
UPDATE CATALOG1 SET PRICE=PRICE*1.10
WHERE PUBLISHERID=101

==================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP TABLE ORDERDETAILS;
DROP TABLE CATALOG1;
DROP TABLE CATEGORY;
DROP TABLE PUBLISHER;
DROP TABLE AUTHOR;   
	

