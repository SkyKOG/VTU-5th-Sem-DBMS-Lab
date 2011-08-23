CREATE TABLE branch
(
	branchname VARCHAR2(10),
	city VARCHAR2(10),
	assets REAL,
	CONSTRAINT pk_brnamebr PRIMARY KEY(branchname)
);

CREATE TABLE customer
(
	custname VARCHAR2(10),
	street VARCHAR2(10) NOT NULL,
	city VARCHAR2(10) NOT NULL,
	CONSTRAINT pk_cusnmecus PRIMARY KEY(custname)
	
);

CREATE TABLE account
(
	accno INTEGER,
	branchname VARCHAR2(10),
	balance REAL,
	CONSTRAINT fk_brnameacc FOREIGN KEY(branchname) REFERENCES branch(branchname),
	CONSTRAINT pk_accnoacc PRIMARY KEY(accno)
);

CREATE TABLE loan
(
	loanno INTEGER,
	branchname VARCHAR2(10) NOT NULL,
	amt REAL,
	CONSTRAINT fk_brnamelon FOREIGN KEY(branchname) REFERENCES branch(branchname) ON DELETE CASCADE,
	CONSTRAINT pk_loalon PRIMARY KEY(loanno)
);

CREATE TABLE depositor
(
	custname VARCHAR2(10),
	accno INTEGER,
	CONSTRAINT fk_accnodepo FOREIGN KEY(accno) REFERENCES account(accno) ON DELETE CASCADE,
	CONSTRAINT fk_cusnmedepo FOREIGN KEY(custname) REFERENCES customer(custname) ON DELETE CASCADE,
	CONSTRAINT pk_depo PRIMARY KEY(custname,accno)
);

CREATE TABLE borrower
(
	custname VARCHAR2(10),
	loanno INTEGER,
	CONSTRAINT fk_cusnmeborr FOREIGN KEY(custname) REFERENCES customer(custname) ON DELETE CASCADE,
	CONSTRAINT fk_lonnoborr FOREIGN KEY(loanno) REFERENCES loan(loanno) ON DELETE CASCADE,
	CONSTRAINT pk_borr PRIMARY KEY(custname,loanno)
);
=============================================================

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
INSERT INTO branch VALUES('&branchname','&city','&assets');
INSERT INTO customer VALUES('&custname','&street','&city');
INSERT INTO account VALUES('&accno','&branchname','&balance');
INSERT INTO loan VALUES('&loanno','&branchname','&amt');
INSERT INTO depositor VALUES('&custname','&accno');
INSERT INTO borrower VALUES('&custname','&loanno');
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

INSERT INTO branch VALUES('Children','Nagpur',1200000); 
INSERT INTO branch VALUES('Main','Chennai',2000000);
INSERT INTO branch VALUES('Regional','Mumbai',330000);
INSERT INTO branch VALUES('Farmer','Hyderabad',555555);
INSERT INTO branch VALUES('District','Nagpur',9999999);

INSERT INTO customer VALUES('Ted','Dharampet','Nagpur');
INSERT INTO customer VALUES('Robin','Sadar','Nagpur');
INSERT INTO customer VALUES('Barney','Palce road','Chennai');
INSERT INTO customer VALUES('Lily','Street','Delhi');
INSERT INTO customer VALUES('Marshall','Miramar','Mumbai');
INSERT INTO customer VALUES('Zoey','Jewel','Hyderabad');

INSERT INTO  account VALUES(1,'Children',25000);
INSERT INTO  account VALUES(2,'Main',12000);
INSERT INTO  account VALUES(3,'Main',1000);
INSERT INTO  account VALUES(4,'Regional',10000);
INSERT INTO  account VALUES(5,'District',600000);
INSERT INTO  account VALUES(6,'Farmer',50000);

INSERT INTO loan VALUES(1,'Children',5000);
INSERT INTO loan VALUES(2,'Main',1500);
INSERT INTO loan VALUES(3,'Regional',10000);
INSERT INTO loan VALUES(4,'Farmer',3500);
INSERT INTO loan VALUES(5,'District',20000);

INSERT INTO depositor VALUES('Ted',2);
INSERT INTO depositor VALUES('Robin',1);
INSERT INTO depositor VALUES('Robin',5);
INSERT INTO depositor VALUES('Marshall',4);
INSERT INTO depositor VALUES('Barney',3);
INSERT INTO depositor VALUES('Lily',6);
INSERT INTO depositor VALUES('Ted',3);

INSERT INTO borrower VALUES('Ted',2);
INSERT INTO borrower VALUES('Robin',1);
INSERT INTO borrower VALUES('Marshall',3);
INSERT INTO borrower VALUES('Barney',4);
INSERT INTO borrower VALUES('Lily',5);

======================================================

SELECT custname AS "Cust with 2+ Acc Main Branch"
	FROM account a,depositor d 
	WHERE a.accno=d.accno AND branchname='Main' 
	GROUP BY custname 
	HAVING COUNT(*)>=2;

=====================================================

SELECT DISTINCT custname AS "Acc At All Branches of City" FROM depositor
	WHERE accno IN(SELECT accno FROM account 
	WHERE branchname IN(SELECT branchname FROM branch 
	WHERE city='Nagpur'));

=====================================================

DELETE FROM account WHERE branchname IN (SELECT branchname FROM branch WHERE city='Nagpur');

=====================================================


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP TABLE BORROWER;
DROP TABLE DEPOSITOR;
DROP TABLE LOAN;
DROP TABLE ACCOUNT;
DROP TABLE CUSTOMER;
DROP TABLE BRANCH;