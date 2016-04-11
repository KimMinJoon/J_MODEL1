create table j_meetboard (
	brd_no number primary key, -- 게시글 번호 프라이머리키
	brd_subject varchar2(200) not null, -- 게시글 제목
	brd_content varchar2(4000) not null, -- 게시글내용
	brd_readcount number default 0, --읽은 횟수
	brd_recommend number default 0, --추천받은 수
	brd_ip varchar2(20) not null, --작성자 ip
	brd_reg_date date default sysdate, --게시등록일
	brd_update_date date,  --게시 수정일
	brd_del_yn char(1) default 'n' check (brd_del_yn in ('y','n')),--도메인무결성
	--외래키 설정해야될 속성들
	--brd_writer number not null, -- m_no과 참조된 외래키
	m_no number not null, -- m_no과 참조된 외래키
	mc_code varchar2(30) not null, -- 게시판말머리(brd_category)
	l_code varchar2(30) not null -- l_code 과 게시글마다 희망언어로 필요
);

drop constraint fk_m_no;

-- 게시판에 m_no 외래키 설정
ALTER TABLE j_meetboard ADD CONSTRAINT fk_m_no
FOREIGN KEY(m_no) REFERENCES j_member(m_no);


-- 게시판에 c_minor를 l_code에 외래키 설정
ALTER TABLE j_meetboard ADD CONSTRAINT fk_l_code
FOREIGN KEY(l_code) REFERENCES j_code(c_minor);

-- 게시판에 c_minor를 mc_code에  외래키 설정
ALTER TABLE j_meetboard ADD CONSTRAINT fk_mc_code
FOREIGN KEY(mc_code) REFERENCES j_code(c_minor);
