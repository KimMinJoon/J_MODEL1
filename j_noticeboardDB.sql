create table j_noticeboard (
	brd_no number primary key, -- 게시글 번호 프라이머리키
	brd_subject varchar2(200) not null, -- 게시글 제목
	brd_content varchar2(4000) not null, -- 게시글내용
	brd_readcount number default 0, --읽은 횟수
	brd_reg_date date default sysdate, --게시등록일
	brd_update_date date,  --게시 수정일
	brd_del_yn char(1) default 'n' check (brd_del_yn in ('y','n')),--도메인무결성
	--외래키 설정해야될 속성들
	--brd_writer number not null, -- m_no과 참조된 외래키
	admin varchar2(15) not null -- 관리자
);