
create table OPLU_RESULT
(
  id          NUMBER ,
  sid         VARCHAR2(30) not null,
  owner       VARCHAR2(30) not null,
  nm_test     VARCHAR2(50),
  nm_origin   VARCHAR2(50),
  ds_type     VARCHAR2(30) not null,
  line        NUMBER not null,
  fg_result   CHAR(1) not null,
  ds_expected VARCHAR2(500),
  ds_actual   VARCHAR2(500),
  dt_included DATE default SYSDATE not null
) ;
 
alter table OPLU_RESULT
  add constraint PK_RESULT primary key (ID);
