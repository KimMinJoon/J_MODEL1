create table j_recommend (
	brd_no number not null, 
	m_no number not null,
	reco_reg_date date default sysdate,
	reco_del_yn char(1) default 'n' check (reco_del_yn in ('y','n')),
	primary key(brd_no, m_no)
);

-- 게시판에 m_no 외래키 설정
ALTER TABLE j_recommend ADD CONSTRAINT fk_m_no_reco
FOREIGN KEY(m_no) REFERENCES j_member(m_no);


-- 게시판에 brd_no 외래키 설정
ALTER TABLE j_recommend ADD CONSTRAINT fk_brd_no_reco
FOREIGN KEY(brd_no) REFERENCES j_meetboard(brd_no);