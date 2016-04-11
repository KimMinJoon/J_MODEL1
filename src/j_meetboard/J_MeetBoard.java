package j_meetboard;

import java.sql.Date;

public class J_MeetBoard {
	
	private int brd_no;
	private String brd_subject;
	private String brd_content;
	private int brd_readcount;
	private int brd_recommend;
	private String brd_ip;
	private Date brd_reg_date;
	private Date brd_update_date;
	private String brd_del_yn;
	private int m_no;
	private String m_nick;
	private String m_passwd;
	private String l_code;
	private String c_value_lang; //l_code에 대한 것
	
	private String mc_code;
	private String c_value_cate; //mc_code에 대한 것
	
	
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
	
	public String getBrd_ip() {
		return brd_ip;
	}
	public void setBrd_ip(String brd_ip) {
		this.brd_ip = brd_ip;
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
	
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	public String getL_code() {
		return l_code;
	}
	public void setL_code(String l_code) {
		this.l_code = l_code;
	}
	public String getMc_code() {
		return mc_code;
	}
	public void setMc_code(String mc_code) {
		this.mc_code = mc_code;
	}
	public String getM_nick() {
		return m_nick;
	}
	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}
	public int getBrd_recommend() {
		return brd_recommend;
	}
	public void setBrd_recommend(int brd_recommend) {
		this.brd_recommend = brd_recommend;
	}
	public String getC_value_lang() {
		return c_value_lang;
	}
	public void setC_value_lang(String c_value_lang) {
		this.c_value_lang = c_value_lang;
	}
	public String getC_value_cate() {
		return c_value_cate;
	}
	public void setC_value_cate(String c_value_cate) {
		this.c_value_cate = c_value_cate;
	}
	
	@Override
	public String toString() {
		return "J_MeetBoard [brd_no=" + brd_no + ", brd_subject=" + brd_subject + ", brd_content=" + brd_content
				+ ", brd_readcount=" + brd_readcount + ", brd_recommend=" + brd_recommend + ", brd_ip=" + brd_ip
				+ ", brd_reg_date=" + brd_reg_date + ", brd_update_date=" + brd_update_date + ", brd_dey_yn="
				+ brd_del_yn + ", m_no=" + m_no + ", m_nick=" + m_nick + ", l_code=" + l_code + ", c_value_lang="
				+ c_value_lang + ", mc_code=" + mc_code + ", c_value_cate=" + c_value_cate + "]";
	}
	public String getBrd_del_yn() {
		return brd_del_yn;
	}
	public void setBrd_del_yn(String brd_del_yn) {
		this.brd_del_yn = brd_del_yn;
	}
	public String getM_passwd() {
		return m_passwd;
	}
	public void setM_passwd(String m_passwd) {
		this.m_passwd = m_passwd;
	}

}
