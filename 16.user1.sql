/* Create Sequences */

CREATE SEQUENCE SEQ_BORD_BNO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_LECTURE_LEC_NO INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_REPLY_RNO INCREMENT BY 1 START WITH 1;


/* Create Tables */

CREATE TABLE ADMIN_LIST
(
   ID varchar2(30) NOT NULL,
   REGDATE date DEFAULT SYSDATE,
   PRIMARY KEY (ID)
);


CREATE TABLE BORD
(
   BNO number(10) NOT NULL,
   WRITER varchar2(30) NOT NULL,
   TITLE varchar2(30),
   CONTENT varchar2(2000),
   PRIMARY KEY (BNO)
);


CREATE TABLE LECTURE
(
   LEC_NO number(10) NOT NULL,
   TEACHER varchar2(30),
   LEC_LIST varchar2(30),
   PRIMARY KEY (LEC_NO)
);


CREATE TABLE LEC_ORDER
(
   LEC_NO number(10) NOT NULL,
   ID varchar2(30) NOT NULL,
   ORDERDATE date DEFAULT SYSDATE,
   PRIMARY KEY (LEC_NO, ID)
);


CREATE TABLE REPLY
(
   RNO number(10) NOT NULL,
   WRITER varchar2(30) NOT NULL,
   CONTENT varchar2(2000),
   BNO number(10) NOT NULL,
   PRIMARY KEY (RNO)
);


CREATE TABLE USERS
(
   ID varchar2(30) NOT NULL,
   NAME varchar2(30) NOT NULL,
   REGDATE date DEFAULT SYSDATE,
   PRIMARY KEY (ID)
);