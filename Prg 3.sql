CREATE TABLE student
(
	regno VARCHAR2(5),
	name VARCHAR2(10) NOT NULL,
	major VARCHAR2(10) NOT NULL,
	bdate date NOT NULL,
	CONSTRAINT pk_rgnostu PRIMARY KEY(regno) 
);

CREATE TABLE course
(
	coursenum INTEGER,
	cname VARCHAR2(10) NOT NULL,
	dept VARCHAR2(10) NOT NULL,
	CONSTRAINT pk_coucourse PRIMARY KEY(coursenum)
);

CREATE TABLE enroll
(
	regno VARCHAR2(5),
	coursenum INTEGER,
	sem INTEGER,
	marks INTEGER NOT NULL,
	CONSTRAINT fk_rgnoenro FOREIGN KEY(regno) REFERENCES student(regno) ON DELETE CASCADE,
	CONSTRAINT fk_couenro FOREIGN KEY(coursenum) REFERENCES course(coursenum) ON DELETE CASCADE,
	CONSTRAINT pk_enroll PRIMARY KEY(regno,coursenum,sem)
);

CREATE TABLE text
(
	isbn INTEGER,
	title VARCHAR2(15) NOT NULL,
	publisher VARCHAR2(10) NOT NULL,
	author VARCHAR2(10) NOT NULL,
	CONSTRAINT pk_isbntex PRIMARY KEY(isbn)
);

CREATE TABLE book_adopt
(
	coursenum INTEGER,
	sem INTEGER,
	isbn INTEGER NOT NULL,
	CONSTRAINT fk_coubooadpt FOREIGN KEY(coursenum) REFERENCES course(coursenum) ON DELETE CASCADE,
	CONSTRAINT fk_isbnboadpt FOREIGN KEY(isbn) REFERENCES text(isbn) ON DELETE CASCADE,
	CONSTRAINT pk_booadpt PRIMARY KEY(coursenum,sem)
);



=======================================================
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
INSERT INTO student VALUES('&regno','&name','&major','&bdate');
INSERT INTO course VALUES('&coursenum','&cname','&dept');
INSERT INTO enroll VALUES('&regno','&coursenum','&sem','&marks');
INSERT INTO text VALUES('&isbn','&title','&publisher','&author');
INSERT INTO book_adopt VALUES('&coursenum','&sem','&isbn');
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

INSERT INTO student VALUES('cs42','Robby','cse','17-dec-1991');
INSERT INTO student VALUES('cs48','Payal','cse','02-sep-1990');
INSERT INTO student VALUES('ec26','Christina','cse','16-aug-1991');
INSERT INTO student VALUES('ee37','Sam','ise','28-may-1991');
INSERT INTO student VALUES('is48','Ricky','ise','28-may-1991');

INSERT INTO course VALUES(1,'.net','Computer');
INSERT INTO course VALUES(2,'J2EE','Computer');
INSERT INTO course VALUES(3,'OpenSource','Infosci');
INSERT INTO course VALUES(4,'FS','Infosci');
INSERT INTO course VALUES(5,'Oracle','Computer');

INSERT INTO enroll VALUES('cs42',1,6,98);
INSERT INTO enroll VALUES('cs48',2,6,97);
INSERT INTO enroll VALUES('ec26',5,5,50);
INSERT INTO enroll VALUES('is48',3,7,90);
INSERT INTO enroll VALUES('ee37',4,4,80);
INSERT INTO enroll VALUES('cs48',1,6,35);

INSERT INTO text VALUES(101,'Progmer Padgm','Apress','Marcus');
INSERT INTO text VALUES(102,'Think in C++','Apress','Barbara');
INSERT INTO text VALUES(103,'Oracle','McGraw','Emily Chen');
INSERT INTO text VALUES(104,'.net','Apress','Martin');
INSERT INTO text VALUES(105,'J2EE','Pearson','Smith');

INSERT INTO book_adopt VALUES(1,6,101);
INSERT INTO book_adopt VALUES(1,3,104);
INSERT INTO book_adopt VALUES(1,5,105);
INSERT INTO book_adopt VALUES(2,3,104);
INSERT INTO book_adopt VALUES(2,5,105);
INSERT INTO book_adopt VALUES(2,6,103);
INSERT INTO book_adopt VALUES(3,5,102);
INSERT INTO book_adopt VALUES(4,4,104);
INSERT INTO book_adopt VALUES(5,7,105);



=======================================================
INSERT INTO TEXT VALUES(106,'Digit','Spinster','Rab');
INSERT INTO BOOK_ADOPT VALUES(5,3,106);

=======================================================

SELECT c.coursenum AS "Course Num",t.ISBN,t.title AS "Book Title"
FROM COURSE c,TEXT t,book_adopt b
WHERE c.COURSEnum=b.COURSEnum AND
      t.ISBN=b.ISBN AND
      c.DEPT='Computer' AND c.COURSEnum IN(SELECT b.COURSEnum
				      FROM book_adopt b
				      GROUP BY b.COURSEnum
				      HAVING COUNT(*)>2)
      GROUP BY c.COURSEnum ,t.ISBN,t.TITLE
      ORDER BY t.TITLE;
	 
=========================================================	

SELECT DISTINCT c.dept AS "Dept. All Books Same Publisher"
FROM course c,book_adopt b, text t
WHERE c.coursenum=b.COURSEnum AND
      b.ISBN=t.ISBN AND
      t.PUBLISHER='Apress' AND
      c.COURSEnum IN( SELECT COURSEnum
                      FROM book_adopt b,text t
                      WHERE b.ISBN=t.ISBN
                      GROUP BY COURSEnum
                      HAVING count(DISTINCT publisher)=1);

===========================================================

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DROP TABLE BOOK_ADOPT;
DROP TABLE TEXT;
DROP TABLE ENROLL;
DROP TABLE COURSE;
DROP TABLE STUDENT;					  