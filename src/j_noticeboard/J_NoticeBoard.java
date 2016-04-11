package j_noticeboard;

import java.sql.Date;

public class J_NoticeBoard {

	private int brd_no; // 공지사항 번호 프라이머리키
	private String brd_subject; // 제목
	private String brd_content; // 내용
	private int brd_readcount; // 읽은 수
	private Date brd_reg_date; // 등록일
	private Date brd_update_date; // 수정일
	private String brd_del_yn; // 삭제yn
	private String admin; // 관리자
	
	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}

	public int getBrd_no() {
		return brd_no;
	}

	public void setBrd_no(int brd_no) {
		this.brd_no = brd_no;
	}

	public String getBrd_subject() {
		return brd_subject;
	}

	public void setBrd_subject(String brd_subject) {
		this.brd_subject = brd_subject;
	}

	public String getBrd_content() {
		return brd_content;
	}

	public void setBrd_content(String brd_content) {
		this.brd_content = brd_content;
	}

	public int getBrd_readcount() {
		return brd_readcount;
	}

	public void setBrd_readcount(int brd_readcount) {
		this.brd_readcount = brd_readcount;
	}

	public Date getBrd_reg_date() {
		return brd_reg_date;
	}

	public void setBrd_reg_date(Date brd_reg_date) {
		this.brd_reg_date = brd_reg_date;
	}

	public Date getBrd_update_date() {
		return brd_update_date;
	}

	public void setBrd_update_date(Date brd_update_date) {
		this.brd_update_date = brd_update_date;
	}

	public String getBrd_del_yn() {
		return brd_del_yn;
	}

	public void setBrd_del_yn(String brd_del_yn) {
		this.brd_del_yn = brd_del_yn;
	}

	@Override
	public String toString() {
		return "J_NoticeBoard [brd_no=" + brd_no + ", brd_subject=" + brd_subject + ", brd_content=" + brd_content
				+ ", brd_readcount=" + brd_readcount + ", brd_reg_date=" + brd_reg_date + ", brd_update_date="
				+ brd_update_date + ", brd_del_yn=" + brd_del_yn + ", admin=" + admin + "]";
	}
	
	
}
