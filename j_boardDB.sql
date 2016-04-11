create table j_board (
	brd_no number primary key, -- 게시글 번호 프라이머리키
	brd_subject varchar2(50) not null, -- 게시글 제목
	brd_content varchar2(4000) not null, -- 게시글내용
	brd_category varchar2(10), -- 게시판말머리
	brd_readcount number default 0, --읽은 횟수
	brd_recommend number default 0, --추천받은 수
	brd_ip varchar2(20) not null, --작성자 ip
	brd_reg_date date default sysdate, --게시등록일
	brd_update_date date,  --게시 수정일
	brd_del_yn char(1) default 'n' check (brd_del_yn in ('y','n')),--도메인무결성
	--외래키 설정해야될 속성들
	--brd_writer number not null, -- m_no과 참조된 외래키
	m_no number not null, -- m_no과 참조된 외래키
	l_code varchar2(30) not null, -- l_code 과 게시글마다 희망언어로 필요
	b_code varchar2(30) not null -- b_code로 게시판 구분으로 필요
);

select * from j_board;
select * from user_tables;

desc j_board;

drop table j_board; --테이블삭제
drop table j_code; --테이블삭제
drop table j_member; --테이블삭제
drop table board1; --테이블삭제
drop table j_boardcode; --테이블삭제

create table j_boardcode ( -- 게시판코드 테이블 생성
	boardcode number primary key,
	boardname varchar2(10) not null
);

-- 게시판에 m_no 외래키 설정
ALTER TABLE j_board ADD CONSTRAINT fk_m_no
FOREIGN KEY(m_no) REFERENCES j_member(m_no);


-- 게시판에 c_minor를 l_code에 외래키 설정
ALTER TABLE j_board ADD CONSTRAINT fk_l_code
FOREIGN KEY(l_code) REFERENCES j_code(c_minor);

-- 게시판에 c_minor를 b_code에  외래키 설정
ALTER TABLE j_board ADD CONSTRAINT fk_b_code
FOREIGN KEY(b_code) REFERENCES j_code(c_minor);

-- 게시판에 code 외래키 설정
ALTER TABLE 컨트리 랭귀지 ADD CONSTRAINT fk_code
FOREIGN KEY(code) REFERENCES 컨트리랭귀지(code);




--boardcode 외래키 설정 삭제 예제
ALTER TABLE j_board DROP CONSTRAINT fk_boardcode;

select * from (select rowNum rn, * from j_board a, j_member b where a.brd_no = b.m_no order by brd_no desc) where rn between 1 and 10;

select * from j_board;

select * from user_tables;



