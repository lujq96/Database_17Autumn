prompt PL/SQL Developer import file
prompt Created on 2017年12月31日 by SONY
set feedback off
set define off
prompt Creating BUYER...
create table BUYER
(
  buyerid   NUMBER(7) not null,
  bname     VARCHAR2(12) not null,
  bemail    VARCHAR2(50) not null,
  btele     NUMBER(15) not null,
  bpassword VARCHAR2(20) not null,
  bage      NUMBER(2) not null,
  bgender   CHAR(1) not null,
  baddress  VARCHAR2(120) not null
)
;
alter table BUYER
  add constraint BUYERPK primary key (BUYERID);
alter table BUYER
  add constraint GENDERCK
  check (BGender IN ('F','M'));

prompt Creating CPUNIT...
create table CPUNIT
(
  cpuid        VARCHAR2(20) not null,
  corenum      VARCHAR2(2) not null,
  cpufrequency VARCHAR2(10),
  cpubrand     VARCHAR2(15),
  trantech     VARCHAR2(10),
  cpupower     VARCHAR2(5)
)
;
alter table CPUNIT
  add constraint CPUNITPK primary key (CPUID);

prompt Creating GPU...
create table GPU
(
  gpuid  VARCHAR2(30) not null,
  gbrand VARCHAR2(15),
  gsize  VARCHAR2(5),
  gcore  VARCHAR2(10),
  ggene  VARCHAR2(5)
)
;
alter table GPU
  add constraint CPUPK primary key (GPUID);

prompt Creating HARDDISK...
create table HARDDISK
(
  hdid   VARCHAR2(30) not null,
  dtype  VARCHAR2(15),
  dsize  VARCHAR2(10),
  dbrand VARCHAR2(15)
)
;
alter table HARDDISK
  add constraint HDPK primary key (HDID);

prompt Creating NEICUN...
create table NEICUN
(
  memoryid   VARCHAR2(20) not null,
  mbrand     VARCHAR2(15),
  msize      VARCHAR2(10),
  mfrequency VARCHAR2(15),
  mgene      VARCHAR2(5)
)
;
alter table NEICUN
  add constraint NEICUNPK primary key (MEMORYID);

prompt Creating SCREEN...
create table SCREEN
(
  screenid    VARCHAR2(30) not null,
  sresolution VARCHAR2(15),
  ssize       VARCHAR2(10),
  sbrand      VARCHAR2(15)
)
;
alter table SCREEN
  add constraint SCPK primary key (SCREENID);

prompt Creating COMPUTER...
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
  screenid VARCHAR2(30)
)
;
alter table COMPUTER
  add constraint COMPK primary key (CID);
alter table COMPUTER
  add constraint CPUFK foreign key (CPUID)
  references CPUNIT (CPUID)
  disable
  novalidate;
alter table COMPUTER
  add constraint GPUFK foreign key (GPUID)
  references GPU (GPUID)
  disable
  novalidate;
alter table COMPUTER
  add constraint HDFK foreign key (HDID)
  references HARDDISK (HDID)
  disable
  novalidate;
alter table COMPUTER
  add constraint MEMORYFK foreign key (MEMORYID)
  references NEICUN (MEMORYID)
  disable
  novalidate;
alter table COMPUTER
  add constraint SCREENFK foreign key (SCREENID)
  references SCREEN (SCREENID)
  disable
  novalidate;

prompt Creating MANAGER...
create table MANAGER
(
  username VARCHAR2(10) not null,
  password VARCHAR2(16) not null,
  mngid    NUMBER(3) not null
)
;
alter table MANAGER
  add constraint MANAGERPK primary key (USERNAME);

prompt Creating ORDERSHEET...
create table ORDERSHEET
(
  orderid NUMBER(8) not null,
  ostate  NUMBER(1) default 0 not null,
  odate   TIMESTAMP(6),
  buyerid NUMBER(7) not null
)
;
alter table ORDERSHEET
  add constraint ORDERSHEETPK primary key (ORDERID);
alter table ORDERSHEET
  add constraint ORDERBUYFK foreign key (BUYERID)
  references BUYER (BUYERID);

prompt Creating SELLER...
create table SELLER
(
  sellerid  NUMBER(7) not null,
  sname     VARCHAR2(50) not null,
  semail    VARCHAR2(50) not null,
  stele     NUMBER(15) not null,
  spassword VARCHAR2(20) not null,
  saddress  VARCHAR2(120) not null,
  sactive   NUMBER(1) default 0 not null
)
;
alter table SELLER
  add constraint SELLERPK primary key (SELLERID);

prompt Creating SELL...
create table SELL
(
  sellid   NUMBER(8) not null,
  cid      VARCHAR2(30) not null,
  sellerid NUMBER(7) not null,
  sprice   NUMBER(6) default 0 not null,
  sremain  NUMBER(4) default 0 not null
)
;
alter table SELL
  add constraint SELLPK primary key (SELLID);
alter table SELL
  add constraint SELLCOMFK foreign key (CID)
  references COMPUTER (CID);
alter table SELL
  add constraint SELLERFK foreign key (SELLERID)
  references SELLER (SELLERID);

prompt Creating ORDERS...
create table ORDERS
(
  orderid  NUMBER(8) not null,
  sellid   NUMBER(8) not null,
  quantity NUMBER(4) not null,
  track    NUMBER(1) default 0 not null
)
;
alter table ORDERS
  add constraint ORDERPK primary key (ORDERID, SELLID);
alter table ORDERS
  add constraint OOFK foreign key (ORDERID)
  references ORDERSHEET (ORDERID);
alter table ORDERS
  add constraint OSFK foreign key (SELLID)
  references SELL (SELLID);

prompt Disabling triggers for BUYER...
alter table BUYER disable all triggers;
prompt Disabling triggers for CPUNIT...
alter table CPUNIT disable all triggers;
prompt Disabling triggers for GPU...
alter table GPU disable all triggers;
prompt Disabling triggers for HARDDISK...
alter table HARDDISK disable all triggers;
prompt Disabling triggers for NEICUN...
alter table NEICUN disable all triggers;
prompt Disabling triggers for SCREEN...
alter table SCREEN disable all triggers;
prompt Disabling triggers for COMPUTER...
alter table COMPUTER disable all triggers;
prompt Disabling triggers for MANAGER...
alter table MANAGER disable all triggers;
prompt Disabling triggers for ORDERSHEET...
alter table ORDERSHEET disable all triggers;
prompt Disabling triggers for SELLER...
alter table SELLER disable all triggers;
prompt Disabling triggers for SELL...
alter table SELL disable all triggers;
prompt Disabling triggers for ORDERS...
alter table ORDERS disable all triggers;
prompt Disabling foreign key constraints for ORDERSHEET...
alter table ORDERSHEET disable constraint ORDERBUYFK;
prompt Disabling foreign key constraints for SELL...
alter table SELL disable constraint SELLCOMFK;
alter table SELL disable constraint SELLERFK;
prompt Disabling foreign key constraints for ORDERS...
alter table ORDERS disable constraint OOFK;
alter table ORDERS disable constraint OSFK;
prompt Loading BUYER...
insert into BUYER (buyerid, bname, bemail, btele, bpassword, bage, bgender, baddress)
values (0, 'Test0', '1@1', 0, 'Test0', 18, 'M', 'NoAdd');
commit;
prompt 1 records loaded
prompt Loading CPUNIT...
insert into CPUNIT (cpuid, corenum, cpufrequency, cpubrand, trantech, cpupower)
values ('i7-6700', '4', '3.4GHz', 'Intel', '14nm', '65W');
insert into CPUNIT (cpuid, corenum, cpufrequency, cpubrand, trantech, cpupower)
values ('i3-7100', '2', '3.9GHz', 'Intel', '14nm', '51W');
insert into CPUNIT (cpuid, corenum, cpufrequency, cpubrand, trantech, cpupower)
values ('A10-9700E', '4', '3GHz', 'AMD', '28nm', '35W');
insert into CPUNIT (cpuid, corenum, cpufrequency, cpubrand, trantech, cpupower)
values ('i7-7700k', '4', '4.2GHz', 'Intel', '14nm', '91W');
insert into CPUNIT (cpuid, corenum, cpufrequency, cpubrand, trantech, cpupower)
values ('i5-4200U', '2', '1600MHZ', 'Intel', '32nm', '12W');
insert into CPUNIT (cpuid, corenum, cpufrequency, cpubrand, trantech, cpupower)
values ('i5-5200U', '2', '1.8GHz', 'Intel', '22nm', '25W');
insert into CPUNIT (cpuid, corenum, cpufrequency, cpubrand, trantech, cpupower)
values ('i5-7500', '4', '3.4GHz', 'Intel', '14nm', '65W');
insert into CPUNIT (cpuid, corenum, cpufrequency, cpubrand, trantech, cpupower)
values ('i3-8100', '4', '3.6GHz', 'Intel', '14nm', '65W');
commit;
prompt 8 records loaded
prompt Loading GPU...
insert into GPU (gpuid, gbrand, gsize, gcore, ggene)
values ('Radeon HD R9 360', 'AMD', '2GB', 'R9 360', 'GDDR5');
insert into GPU (gpuid, gbrand, gsize, gcore, ggene)
values ('GMA HD 630', 'Intel', '-', 'HD630', '-');
insert into GPU (gpuid, gbrand, gsize, gcore, ggene)
values ('集成显卡', 'AMD', '-', '-', '-');
insert into GPU (gpuid, gbrand, gsize, gcore, ggene)
values ('GTX1050', 'Nvidia', '2GB', 'GP107', 'DDR5');
commit;
prompt 4 records loaded
prompt Loading HARDDISK...
insert into HARDDISK (hdid, dtype, dsize, dbrand)
values ('General500HDD', 'HDD', '500GB', '-');
insert into HARDDISK (hdid, dtype, dsize, dbrand)
values ('ST1000DM003', 'HDD', '1TB', '希捷');
insert into HARDDISK (hdid, dtype, dsize, dbrand)
values ('850EVO-250-SATA3', 'SATA3-SSD', '250GB', 'Samsung');
commit;
prompt 3 records loaded
prompt Loading NEICUN...
insert into NEICUN (memoryid, mbrand, msize, mfrequency, mgene)
values ('Vostro8G内存', '杂牌', '8GB', '1600MHz', 'DDR3L');
insert into NEICUN (memoryid, mbrand, msize, mfrequency, mgene)
values ('General4D416', '-', '4GB', '1600MHz', 'DDR4');
insert into NEICUN (memoryid, mbrand, msize, mfrequency, mgene)
values ('BLS8G4D240FSC', '英睿达铂胜运动', '8GB', '2400MHz', 'DDR4');
insert into NEICUN (memoryid, mbrand, msize, mfrequency, mgene)
values ('Kingston-8G-R4-2400', 'Kingston', '8GB', '2400MHz', 'DDR4');
commit;
prompt 4 records loaded
prompt Loading SCREEN...
insert into SCREEN (screenid, sresolution, ssize, sbrand)
values ('仅主机', '-', '-', '-');
insert into SCREEN (screenid, sresolution, ssize, sbrand)
values ('General20FHD', '1920*1080', '20英寸', '-');
insert into SCREEN (screenid, sresolution, ssize, sbrand)
values ('Infinity非触控', '1920*1080', '23.8英寸', 'Dell');
insert into SCREEN (screenid, sresolution, ssize, sbrand)
values ('U2415', '1920*1200', '24英寸', 'DELL');
commit;
prompt 4 records loaded
prompt Loading COMPUTER...
insert into COMPUTER (cid, cname, cyear, cbrand, cpuid, memoryid, gpuid, hdid, screenid)
values ('Test0-0', 'Test0', 2017, 'Tsinghua', 'i7-7700k', 'Kingston-8G-R4-2400', 'GTX1050', '850EVO-250-SATA3', 'U2415');
insert into COMPUTER (cid, cname, cyear, cbrand, cpuid, memoryid, gpuid, hdid, screenid)
values ('3650-D1938', 'Vostro成就3650', 2016, 'Dell', 'i7-6700', 'Vostro8G内存', 'Radeon HD R9 360', 'ST1000DM003', '仅主机');
insert into COMPUTER (cid, cname, cyear, cbrand, cpuid, memoryid, gpuid, hdid, screenid)
values ('I371004G50D-10', '联想扬天T4900D', 2017, '联想', 'i3-7100', 'General4D416', 'GMA HD 630', 'General500HDD', 'General20FHD');
insert into COMPUTER (cid, cname, cyear, cbrand, cpuid, memoryid, gpuid, hdid, screenid)
values ('test1-1', 'test1', 2017, 'test1', 'i5-7500', 'Kingston-8G-R4-2400', 'GTX1050', '850EVO-250-SATA3', 'U2415');
insert into COMPUTER (cid, cname, cyear, cbrand, cpuid, memoryid, gpuid, hdid, screenid)
values ('Ins24-5475-D1908W', '灵越24''''全高清一体机', 2017, 'Dell', 'A10-9700E', 'BLS8G4D240FSC', '集成显卡', 'ST1000DM003', 'Infinity非触控');
commit;
prompt 5 records loaded
prompt Loading MANAGER...
insert into MANAGER (username, password, mngid)
values ('admin', 'admin', 301);
commit;
prompt 1 records loaded
prompt Loading ORDERSHEET...
insert into ORDERSHEET (orderid, ostate, odate, buyerid)
values (10000000, 0, null, 0);
commit;
prompt 1 records loaded
prompt Loading SELLER...
insert into SELLER (sellerid, sname, semail, stele, spassword, saddress, sactive)
values (9000000, 'Test1', '2@2', 9000000, 'Test1', 'NoAdd', 1);
commit;
prompt 1 records loaded
prompt Loading SELL...
insert into SELL (sellid, cid, sellerid, sprice, sremain)
values (100000, 'Test0-0', 9000000, 999999, 100);
commit;
prompt 1 records loaded
prompt Loading ORDERS...
insert into ORDERS (orderid, sellid, quantity, track)
values (10000000, 100000, 1, 0);
commit;
prompt 1 records loaded
prompt Enabling foreign key constraints for ORDERSHEET...
alter table ORDERSHEET enable constraint ORDERBUYFK;
prompt Enabling foreign key constraints for SELL...
alter table SELL enable constraint SELLCOMFK;
alter table SELL enable constraint SELLERFK;
prompt Enabling foreign key constraints for ORDERS...
alter table ORDERS enable constraint OOFK;
alter table ORDERS enable constraint OSFK;
prompt Enabling triggers for BUYER...
alter table BUYER enable all triggers;
prompt Enabling triggers for CPUNIT...
alter table CPUNIT enable all triggers;
prompt Enabling triggers for GPU...
alter table GPU enable all triggers;
prompt Enabling triggers for HARDDISK...
alter table HARDDISK enable all triggers;
prompt Enabling triggers for NEICUN...
alter table NEICUN enable all triggers;
prompt Enabling triggers for SCREEN...
alter table SCREEN enable all triggers;
prompt Enabling triggers for COMPUTER...
alter table COMPUTER enable all triggers;
prompt Enabling triggers for MANAGER...
alter table MANAGER enable all triggers;
prompt Enabling triggers for ORDERSHEET...
alter table ORDERSHEET enable all triggers;
prompt Enabling triggers for SELLER...
alter table SELLER enable all triggers;
prompt Enabling triggers for SELL...
alter table SELL enable all triggers;
prompt Enabling triggers for ORDERS...
alter table ORDERS enable all triggers;
set feedback on
set define on
prompt Done.
