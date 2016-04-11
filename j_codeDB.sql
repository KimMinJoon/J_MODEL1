create table j_code (
	c_major varchar2(2) not null,     -- 대분류(언어, 국가, 게시판)
	c_minor varchar2(10) primary key, -- 소분류(각 국가, 언어,게시판의 코드값)
	c_value varchar2(30) not null	  -- 나오는 값
);

select * from j_code; 

select COUNT(*) from j_code; -- 349갯수입니다 확인 바람

drop table j_code;

