
package j_onelineboard;

import java.sql.Date;
/**
 * 한줄게시판에서 사용될 VO 클래스
 * 
 * @author 이재설
 *
 */
public class J_OneLineBoard {
	private int brd_no;				//게시글 번호
	private String brd_content;		//게시글 내용
	private String brd_reg_date;	//게시글 등록일
	private Date brd_update_date;	//게시글 최종 수정일
	private String brd_ip;			//게시글 등록 IP
	private String brd_del_yn;		//게시글 삭제 여부
	private int m_no;				//게시자 회원번호
	private String m_nick;			//게시자 닉네임
	private int grp;				//댓글 그룹
	private int rep_count;			//해당 게시글에 대한 댓글의 총 수
	
	
	public int getRep_count() {
		return rep_count;
	}
	public void setRep_count(int rep_count) {
		this.rep_count = rep_count;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public String getM_nick() {
		return m_nick;
	}
	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}
	public int getBrd_no() {
		return brd_no;
	}
	public void setBrd_no(int brd_no) {
		this.brd_no = brd_no;
	}
	public String getBrd_content() {
		return brd_content;
	}
	public void setBrd_content(String brd_content) {
		this.brd_content = brd_content;
	}
	public String getBrd_reg_date() {
		return brd_reg_date;
	}
	public void setBrd_reg_date(String brd_reg_date) {
		this.brd_reg_date = brd_reg_date;
	}
	public Date getBrd_update_date() {
		return brd_update_date;
	}
	public void setBrd_update_date(Date brd_update_date) {
		this.brd_update_date = brd_update_date;
	}
	public String getBrd_ip() {
		return brd_ip;
	}
	public void setBrd_ip(String brd_ip) {
		this.brd_ip = brd_ip;
	}
	public String getBrd_del_yn() {
		return brd_del_yn;
	}
	public void setBrd_del_yn(String brd_del_yn) {
		this.brd_del_yn = brd_del_yn;
	}
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	//getter,setter
	
	/**
	 * 저장된 값 확인을 위한 toString 오버라이드
	 */
	@Override
	public String toString() {
		return "J_OneLineBoard [brd_no=" + brd_no + ", brd_content=" + brd_content + ", brd_reg_date=" + brd_reg_date
				+ ", brd_update_date=" + brd_update_date + ", brd_ip=" + brd_ip + ", brd_del_yn=" + brd_del_yn
				+ ", m_no=" + m_no + ", m_nick=" + m_nick + ", grp=" + grp + ", rep_count=" + rep_count + "]";
	}
}
