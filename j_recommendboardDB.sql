create table j_recommendboard (
	brd_no number primary key, -- 게시글 번호 프라이머리키
	brd_subject varchar2(200) not null, -- 게시글 제목
	brd_content varchar2(4000) not null, -- 게시글내용
	brd_readcount number default 0, --읽은 횟수
	brd_ip varchar2(20) not null, --작성자 ip
	brd_reg_date date default sysdate, --게시등록일
	brd_update_date date,  --게시 수정일
	brd_del_yn char(1) default 'n' check (brd_del_yn in ('y','n')),
	ref number not null, -- 답변글끼리 그룹
	re_step number not null, -- ref내의 순서
	re_level number not null, -- 들여쓰기
	m_no number not null, -- m_no과 참조된 외래키
	rc_code varchar2(30) not null -- 게시판말머리
);

-- 게시판에 m_no 외래키 설정
alter table j_recommendboard add constraint fk_m_no
foreign key(m_no) references j_member(m_no);

drop constraint fk_m_no;

-- 게시판에 c_minor를 rc_code에  외래키 설정
alter table j_recommendboard add constraint fk_rc_code
foreign key(rc_code) references j_code(c_minor);


