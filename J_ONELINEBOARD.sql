CREATE TABLE J_ONELINEBOARD(
  BRD_NO NUMBER primary key,
  BRD_CONTENT VARCHAR2(500) NOT NULL,
  BRD_REG_DATE DATE DEFAULT SYSDATE,
  BRD_UPDATE_DATE DATE,
  BRD_IP VARCHAR2(220) NOT NULL,
  BRD_DEL_YN CHAR(1) default 'n' check (brd_del_yn in ('y','n')),
  M_NO NUMBER NOT NULL ,
  BRD_OUT_DATE DATE
);

alter table j_onelineboard add constraint pk_brd_no
primary key(brd_no);

ALTER TABLE j_onelineboard ADD CONSTRAINT fk_ol_m_no
FOREIGN KEY(m_no) REFERENCES j_member(m_no);


