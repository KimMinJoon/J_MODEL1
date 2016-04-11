create table j_member (
	m_no number primary key,
	m_email varchar2(30) not null unique,
	m_passwd varchar2(20) not null,
	m_nick varchar2(30) not null unique,
	m_reg_date date default sysdate,
	m_out_date date,
	m_del_yn char(1) default 'n',
	c_code varchar2(30),
	l_code varchar2(30)
);

select * from j_member;

insert into j_member values (1,'master',1,'관리자',sysdate,null,'n','c_default','l_defult');
-- 관리자 insert

--drop table j_member;

ALTER TABLE j_member ADD CONSTRAINT fk_member_l_code
FOREIGN KEY(l_code) REFERENCES j_code(c_minor);

ALTER TABLE j_member ADD CONSTRAINT fk_member_c_code
FOREIGN KEY(c_code) REFERENCES j_code(c_minor);