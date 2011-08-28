CREATE TABLE person
(
	driverid VARCHAR(5),
	name VARCHAR(30),
	address VARCHAR(50),
	CONSTRAINT pk_dridper PRIMARY KEY (driverid)
);

CREATE TABLE car
(
	regno VARCHAR(5),
	model VARCHAR(25),
	year INTEGER,
	CONSTRAINT pk_rgnocar PRIMARY KEY (regno)
);

CREATE TABLE accident
(
	reportno INTEGER,
	date1 date,
	location VARCHAR(30),
	CONSTRAINT pk_rptnoacc PRIMARY KEY (reportno)
);

CREATE TABLE owns
(
	driverid VARCHAR(5),
	regno VARCHAR(5),
	CONSTRAINT fk_dridown FOREIGN KEY(driverid) REFERENCES person(driverid) ON DELETE CASCADE,
	CONSTRAINT fk_rgnoown FOREIGN KEY(regno) REFERENCES car(regno) ON DELETE CASCADE,
	CONSTRAINT pk_own PRIMARY KEY(driverid,regno)
);

CREATE TABLE participated
(
	driverid VARCHAR(5),
	regno VARCHAR(5),
	reportno INTEGER,
	damages INTEGER,
	CONSTRAINT fk_dridpart FOREIGN KEY(driverid) REFERENCES person(driverid) ON DELETE CASCADE,
	CONSTRAINT fk_rgnopart FOREIGN KEY(regno) REFERENCES car(regno) ON DELETE CASCADE,
	CONSTRAINT fk_rptno FOREIGN KEY(reportno) REFERENCES accident(reportno) ON DELETE CASCADE,
	CONSTRAINT pk_part PRIMARY KEY(driverid,regno,reportno)
);


======================================
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	INSERT INTO person VALUES('&driverid','&name','&address');
	INSERT INTO car VALUES('&regno','&model','&year');
	INSERT INTO accident VALUES('&reportno','&date1','&location');
	INSERT INTO owns VALUES('&driverid','&regno');
	INSERT INTO participated VALUES('&driverid','&regno','&reportno','&damages');
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

	INSERT INTO person VALUES (1,'House','Carolina');
	INSERT INTO person VALUES (2,'Dexter','Hampshire');
	INSERT INTO person VALUES (3,'Elena','USA');
	INSERT INTO person VALUES (4,'Steffan','Boston');
	INSERT INTO person VALUES (5,'Daemon','Scotland');


	INSERT INTO car VALUES ('reg1','Mercedes',2007);
	INSERT INTO car VALUES ('reg2','Porsche',2005);
	INSERT INTO car VALUES ('reg3','Rolls Royce',2006);
	INSERT INTO car VALUES ('reg4','Ferrari',1999);
	INSERT INTO car VALUES ('reg5','Bentley',2000);
	INSERT INTO car VALUES ('reg6','Maybach',2007);


	INSERT INTO accident VALUES (1,'1-Jan-2008','Dakota');
	INSERT INTO accident VALUES (2,'28-Mar-2008','London');
	INSERT INTO accident VALUES (3,'2-Dec-2008','Nagpur');
	INSERT INTO accident VALUES (4,'5-Jan-2007','Bangalore');
	INSERT INTO accident VALUES (5,'26-Jan-2007','China');
	INSERT INTO accident VALUES (12,'4-Feb-2007','Japan');


	INSERT INTO owns VALUES (1,'reg1');
	INSERT INTO owns VALUES (2,'reg2');
	INSERT INTO owns VALUES (2,'reg5');
	INSERT INTO owns VALUES (3,'reg3');
	INSERT INTO owns VALUES (4,'reg4');
	INSERT INTO owns VALUES (5,'reg6');


	INSERT INTO participated VALUES (1,'reg1',1,500);
	INSERT INTO participated VALUES (2,'reg2',1,2000);
	INSERT INTO participated VALUES (3,'reg3',1,1000);
	INSERT INTO participated VALUES (1,'reg1',2,1500);
	INSERT INTO participated VALUES (4,'reg5',2,800);
	INSERT INTO participated VALUES (5,'reg6',3,750);
	INSERT INTO participated VALUES (2,'reg5',3,600);
	INSERT INTO participated VALUES (1,'reg1',3,200);
	INSERT INTO participated VALUES (5,'reg6',4,1000);
	INSERT INTO participated VALUES (2,'reg2',5,1200);
	INSERT INTO participated VALUES (3,'reg3',12,10000);
	INSERT INTO participated VALUES (2,'reg1',12,5000);

=====================================

UPDATE PARTICIPATED
SET DAMAGES=25000
WHERE REGNO='reg1' AND REPORTNO=12
--------------------
INSERT INTO accident VALUES (7,'16-mar-2007','Chicago');
INSERT INTO participated VALUES (2,'reg1',7,15000);

=========================================
 SELECT COUNT(DISTINCT p.driverid) AS "Ppl Owning Cars of Accidnt-08" FROM accident a,owns o,participated p
        WHERE date1 LIKE '%08' AND a.reportno=p.reportno 
	    AND p.regno=o.regno AND o.driverid=p.driverid;
	    
		
==============================================
SELECT COUNT(*) FROM car c,participated p WHERE model='Mercedes' AND c.regno=p.regno;

********************

SELECT CAR.MODEL AS "Model",COUNT(CAR.REGNO) AS "No. of Accidents" 
FROM CAR,PARTICIPATED
WHERE CAR.REGNO=PARTICIPATED.REGNO
GROUP BY CAR.MODEL;

~~~~~~~~~~~~~~~~~~~~~~~~
DROP TABLE PARTICIPATED;
DROP TABLE OWNS;
DROP TABLE ACCIDENT;
DROP TABLE CAR;
DROP TABLE PERSON;



















