CREATE TABLE customer
(
	custnum INTEGER,
	custname VARCHAR2(10) NOT NULL,
	city VARCHAR2(15) NOT NULL,
	CONSTRAINT pk_cust PRIMARY KEY(custnum)
);

CREATE TABLE custorder
(
	ordrnum INTEGER,
	ordrdate DATE NOT NULL,
	custnum INTEGER NOT NULL,
	ordramt INTEGER,
	CONSTRAINT fk_cusnumco FOREIGN KEY(custnum) REFERENCES customer(custnum) ON DELETE CASCADE,
	CONSTRAINT pk_custordr PRIMARY KEY(ordrnum)
);

CREATE TABLE item
(
	itemnum INTEGER, 
	unitprice INTEGER NOT NULL,
	CONSTRAINT pk_item PRIMARY KEY(itemnum)
);

CREATE TABLE order_item
(
	ordrnum INTEGER,
	itemnum INTEGER,
	qty INTEGER check(qty>0),
	CONSTRAINT fk_ordnmoi FOREIGN KEY(ordrnum) REFERENCES custorder(ordrnum) ON DELETE CASCADE,
	CONSTRAINT fk_itmnmoi FOREIGN KEY(itemnum) REFERENCES item(itemnum) ON DELETE CASCADE,
	CONSTRAINT pk_oi PRIMARY KEY(ordrnum,itemnum)
);

CREATE TABLE warehouse
(
	warehousenum INTEGER,
	city VARCHAR2(15) NOT NULL,
	CONSTRAINT pk_wrehs PRIMARY KEY(warehousenum)
);

CREATE TABLE shipment
(
	ordrnum INTEGER,
	warehousenum INTEGER,
	shipdate DATE NOT NULL,	
	CONSTRAINT fk_ordrnmsm FOREIGN KEY(ordrnum) REFERENCES custorder(ordrnum) ON DELETE CASCADE,
	CONSTRAINT fk_whnmsm FOREIGN KEY(warehousenum) REFERENCES warehouse(warehousenum) ON DELETE CASCADE,
	CONSTRAINT pk_shpmt PRIMARY KEY(ordrnum,warehousenum)
);

====================================================
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
INSERT INTO customer VALUES('&custnum','&custname','&city');
INSERT INTO custorder(ordrnum,ordrdate,custnum) VALUES('&ordrnum','&ordrdate','&custnum');
INSERT INTO item VALUES('&itemnum','&unitprice');
INSERT INTO order_item VALUES('&ordrnum','&itemnum','&qty');
INSERT INTO shipment VALUES('&ordrnum','&warehousenum','&shipdate');
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

INSERT INTO customer VALUES(1,'Mayuri','MP');
INSERT INTO customer VALUES(2,'Sagar','Mysore');
INSERT INTO customer VALUES(3,'Strider','chennai');
INSERT INTO customer VALUES(4,'Mallika','Mumbai');
INSERT INTO customer VALUES(5,'Harsh','Kolkata');

INSERT INTO custorder(ordrnum,ordrdate,custnum) VALUES(1,'1-Jan-2006',1); 
INSERT INTO custorder(ordrnum,ordrdate,custnum) VALUES(2,'26-Mar-2006',2); 
INSERT INTO custorder(ordrnum,ordrdate,custnum) VALUES(3,'12-Jun-2006',1); 
INSERT INTO custorder(ordrnum,ordrdate,custnum) VALUES(4,'15-Sep-2006',3); 
INSERT INTO custorder(ordrnum,ordrdate,custnum) VALUES(5,'5-Jan-2007',4); 
INSERT INTO custorder(ordrnum,ordrdate,custnum) VALUES(6,'10-Jan-2007',4); 
INSERT INTO custorder(ordrnum,ordrdate,custnum) VALUES(7,'3-Mar-2007',5);

INSERT INTO item VALUES(1,500);
INSERT INTO item VALUES(2,300);
INSERT INTO item VALUES(3,2500);
INSERT INTO item VALUES(4,800);
INSERT INTO item VALUES(5,700);

INSERT INTO order_item VALUES(1,1,40);
INSERT INTO order_item VALUES(2,1,20);
INSERT INTO order_item VALUES(3,3,2);
INSERT INTO order_item VALUES(5,3,1);
INSERT INTO order_item VALUES(4,2,30);
INSERT INTO order_item VALUES(6,4,3);
INSERT INTO order_item VALUES(7,5,5);

UPDATE CUSTORDER SET ORDRAMT
	=(SELECT SUM(OI.qty*I.unitprice)
	FROM ORDER_ITEM OI,ITEM I
	WHERE OI.ORDRNUM=CUSTORDER.ORDRNUM
	AND I.itemnum=OI.itemnum);
	

INSERT INTO warehouse VALUES(100,'Pune');
INSERT INTO warehouse VALUES(101,'Chennai');
INSERT INTO warehouse VALUES(102,'Mumbai');
INSERT INTO warehouse VALUES(103,'Kolkata');
INSERT INTO warehouse VALUES(104,'Mysore');

INSERT INTO shipment VALUES(1,100,'3-Jan-2006');
INSERT INTO shipment VALUES(2,100,'28-Mar-2006');
INSERT INTO shipment VALUES(3,101,'13-Jun-2006');
INSERT INTO shipment VALUES(4,102,'18-Sep-2006');
INSERT INTO shipment VALUES(5,103,'11-Jan-2007');
INSERT INTO shipment VALUES(6,104,'13-Jan-2007');
INSERT INTO shipment VALUES(7,103,'3-Mar-2007');


========================================================
SELECT c.CUSTNAME AS "Name of Cust",COUNT(CO.ORDRNUM) AS "Number of Orders",AVG(CO.ORDRAMT) AS "Avg Amount"
	FROM CUSTOMER c,CUSTORDER CO 
	WHERE c.CUSTNUM=CO.CUSTNUM
	GROUP BY c.CUSTNAME;

========================================================

SELECT ordrnum AS "Order Number",warehousenum AS "Warehouse Number" 
	FROM SHIPMENT WHERE warehousenum IN
	(SELECT warehousenum FROM WAREHOUSE WHERE city='Pune');

=========================================================

DELETE FROM ITEM WHERE itemnum=1;

=========================================================



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP TABLE SHIPMENT;
DROP TABLE WAREHOUSE;
DROP TABLE ORDER_ITEM;
DROP TABLE ITEM;
DROP TABLE CUSTORDER;
DROP TABLE CUSTOMER;