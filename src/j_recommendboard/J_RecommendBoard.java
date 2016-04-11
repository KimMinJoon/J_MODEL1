package j_recommendboard;

import java.sql.Date;

public class J_RecommendBoard {

	private int brd_no;
	private String brd_subject;
	private String brd_content;
	private int brd_readcount;
	private int brd_recommend;
	private String brd_ip;
	private Date brd_reg_date;
	private Date brd_update_date;
	private String brd_dey_yn;
	private int ref;
	private int re_step;
	private int re_level;
	private int m_no;
	private String m_nick;
	private String m_passwd;
	private String rc_code;
	private String rc_value;
	private int recocount;

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

	public int getBrd_recommend() {
		return brd_recommend;
	}

	public void setBrd_recommend(int brd_recommend) {
		this.brd_recommend = brd_recommend;
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

	public String getBrd_dey_yn() {
		return brd_dey_yn;
	}

	public void setBrd_dey_yn(String brd_dey_yn) {
		this.brd_dey_yn = brd_dey_yn;
	}

	public int getRef() {
		return ref;
	}

	public void setRef(int ref) {
		this.ref = ref;
	}

	public int getRe_step() {
		return re_step;
	}

	public void setRe_step(int re_step) {
		this.re_step = re_step;
	}

	public int getRe_level() {
		return re_level;
	}

	public void setRe_level(int re_level) {
		this.re_level = re_level;
	}

	public int getM_no() {
		return m_no;
	}

	public void setM_no(int m_no) {
		this.m_no = m_no;
	}

	public String getM_nick() {
		return m_nick;
	}

	public void setM_nick(String m_nick) {
		this.m_nick = m_nick;
	}

	public String getM_passwd() {
		return m_passwd;
	}

	public void setM_passwd(String m_passwd) {
		this.m_passwd = m_passwd;
	}
	
	public String getRc_code() {
		return rc_code;
	}

	public void setRc_code(String rc_code) {
		this.rc_code = rc_code;
	}

	public String getRc_value() {
		return rc_value;
	}

	public void setRc_value(String rc_value) {
		this.rc_value = rc_value;
	}

	public int getRecocount() {
		return recocount;
	}

	public void setRecocount(int recocount) {
		this.recocount = recocount;
	}

	/*@Override
	public String toString() {
		return "J_RecommendBoard [brd_no=" + brd_no + ", brd_subject=" + brd_subject + ", brd_content=" + brd_content
				+ ", brd_readcount=" + brd_readcount + ", brd_recommend=" + brd_recommend + ", brd_ip=" + brd_ip
				+ ", brd_reg_date=" + brd_reg_date + ", brd_update_date=" + brd_update_date + ", brd_dey_yn="
				+ brd_dey_yn + ", ref=" + ref + ", re_step=" + re_step + ", re_level=" + re_level + ", m_no=" + m_no
				+ ", m_nick=" + m_nick + ", mc_code=" + mc_code + ", mc_value=" + mc_value + "]";
	}*/
	
	
}
