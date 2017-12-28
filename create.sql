-- Create table 买方用户表
create table BUYER
(
  buyerid   NUMBER(7) not null,
  bname     VARCHAR2(12) not null,
  bemail    VARCHAR2(50) not null,
  btele     NUMBER(15) not null,
  bpassword VARCHAR2(20) not null,
  bage      NUMBER(2) not null,
  bgender   CHAR(1) not null,
  baddress  VARCHAR2(120) not null,
constraint BUYERPK primary key (BUYERID),
constraint GENDERCK check (BGender IN ('F','M'))
)
-- Create table 卖方用户表
create table SELLER
(
  sellerid  NUMBER(7) not null,
  sname     VARCHAR2(50) not null,
  semail    VARCHAR2(50) not null,
  stele     NUMBER(15) not null,
  spassword VARCHAR2(20) not null,
  saddress  VARCHAR2(120) not null,
  sactive   NUMBER(1) default 0 not null,
constraint SELLERPK primary key (SELLERID)
)
-- Create table CPU
create table CPUNIT
(
  cpuid        VARCHAR2(20) not null,
  corenum      VARCHAR2(2) not null,
  cpufrequency VARCHAR2(10),
  cpubrand     VARCHAR2(15),
  trantech     VARCHAR2(10),
  cpupower     VARCHAR2(5),
 add constraint CPUNITPK primary key (CPUID)
)
-- Create table 内存
create table NEICUN
(
  memoryid   VARCHAR2(20) not null,
  mbrand     VARCHAR2(15),
  msize      VARCHAR2(10),
  mfrequency VARCHAR2(15),
  mgene      VARCHAR2(5),
constraint NEICUNPK primary key (MEMORYID)
)
-- Create table GPU
create table GPU
(
  gpuid  VARCHAR2(30) not null,
  gbrand VARCHAR2(15),
  gsize  VARCHAR2(5),
  gcore  VARCHAR2(10),
  ggene  VARCHAR2(5),
add constraint CPUPK primary key (GPUID)
)
-- Create table 硬盘
create table HARDDISK
(
  hdid   VARCHAR2(30) not null,
  dtype  VARCHAR2(15),
  dsize  VARCHAR2(10),
  dbrand VARCHAR2(15),
constraint HDPK primary key (HDID)
)
-- Create table 屏幕
create table SCREEN
(
  screenid    VARCHAR2(30) not null,
  sresolution VARCHAR2(15),
  ssize       VARCHAR2(10),
  sbrand      VARCHAR2(15),
constraint SCPK primary key (SCREENID)
)
-- Create table 电脑
create table COMPUTER
(
  cid      VARCHAR2(30) not null,
  cname    VARCHAR2(30) not null,
  cyear    NUMBER(4),
  cbrand   VARCHAR2(15),
  cpuid    VARCHAR2(20),
  memoryid VARCHAR2(20),
  gpuid    VARCHAR2(30),
  hdid     VARCHAR2(30),
  screenid VARCHAR2(30),
constraint COMPK primary key (CID),
constraint GPUFK foreign key (GPUID)
  references GPU (GPUID),
constraint HDFK foreign key (HDID)
  references HARDDISK (HDID),
constraint MEMORYFK foreign key (MEMORYID)
  references NEICUN (MEMORYID),
constraint SCREENFK foreign key (SCREENID)
  references SCREEN (SCREENID)
)
-- Create table 卖单
create table SELL
(
  sellid   NUMBER(8) not null,
  cid      VARCHAR2(30) not null,
  sellerid NUMBER(7) not null,
  sprice   NUMBER(6) default 0 not null,
  sremain  NUMBER(4) default 0 not null,
constraint SELLPK primary key (SELLID),
constraint SELLCOMFK foreign key (CID)
  references COMPUTER (CID),
constraint SELLERFK foreign key (SELLERID)
  references SELLER (SELLERID)
)
-- Create table 订单
create table ORDERSHEET
(
  orderid NUMBER(8) not null,
  ostate  NUMBER(1) default 0 not null,
  odate   DATE,
  buyerid NUMBER(7) not null,
constraint ORDERSHEETPK primary key (ORDERID),
constraint ORDERBUYFK foreign key (BUYERID)
  references BUYER (BUYERID)
)
-- Create table 订购状态
create table ORDERS
(
  orderid  NUMBER(8) not null,
  sellid   NUMBER(8) not null,
  quantity NUMBER(4) not null,
  track    NUMBER(1) default 0 not null,
constraint ORDERPK primary key (ORDERID, SELLID),
constraint OOFK foreign key (ORDERID)
  references ORDERSHEET (ORDERID),
constraint OSFK foreign key (SELLID)
  references SELL (SELLID)
)
-- Create Table 管理员
CREATE table Manager(
 username varchar2(10) NOT NULL,
 password varchar2(16) NOT NULL,
 mngid    NUMBER(3) not null,
 CONSTRAINT ManagerPK PRIMARY KEY (username)
)