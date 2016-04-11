package j_onelineboard;

import java.sql.Date;

public class J_OneLineReply {
	private int reply_no;
	private int brd_no;
	private String content;
	private String reg_Date;
	private Date update_date;
	private String m_nick;
	private int m_no;
	private String del_yn;
	
	public int getReply_no() {
		return reply_no;
	}
	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}
	public int getBrd_no() {
		return brd_no;
	}
	public void setBrd_no(int brd_no) {
		this.brd_no = brd_no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReg_Date() {
		return reg_Date;
	}
	public void setReg_Date(String reg_Date) {
		this.reg_Date = reg_Date;
	}
	public Date getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}
	public String getM_nick() {
		return m_nick;
	}
	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	@Override
	public String toString() {
		return "J_OneLineReply [reply_no=" + reply_no + ", brd_no=" + brd_no + ", content=" + content + ", reg_Date="
				+ reg_Date + ", update_date=" + update_date + ", m_nick=" + m_nick + ", m_no=" + m_no + ", del_yn="
				+ del_yn + "]";
	}
}
