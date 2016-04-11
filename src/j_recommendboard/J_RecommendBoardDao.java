package j_recommendboard;

import java.sql.*;
import java.util.*;

import javax.naming.*;
import javax.sql.*;

import j_meetboard.J_MeetBoard;

public class J_RecommendBoardDao {
	
	private static J_RecommendBoardDao instance = new J_RecommendBoardDao();
	private J_RecommendBoardDao() {	}
	public static J_RecommendBoardDao getInstance() {
		return instance;
	}
	
	public Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}
	
	public int selectTotal(String searchType, String searchTxt) {
		int total = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select count(*) from j_recommendboard jrb, j_member m where jrb.m_no=m.m_no and brd_del_yn='n'";
		String sql2 = "";
		if(searchType.equals("all")) {
			sql2 = "and (brd_subject like '%" + searchTxt + "%' or brd_content like '%" + searchTxt + "%') ";
		}else {
			sql2 = "and " + searchType + " like '%" + searchTxt + "%' ";
		}
		if(!searchTxt.equals("")) {
			sql += sql2;
		}
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs,pstmt,conn);
		}
		return total;
	}
	
	public void updateHit(int brd_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_recommendboard set brd_readcount=brd_readcount+1 where brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			pstmt.executeUpdate();		
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(pstmt,conn);
		}
	}
	
	public List<J_RecommendBoard> selectList(int startRow, int endRow, String searchType, String searchTxt) {
		List<J_RecommendBoard> list = new ArrayList<J_RecommendBoard>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql2 ="";
		if(searchType.equals("all")) {
			sql2 = "and (brd_subject like '%" + searchTxt + "%' or brd_content like '%" + searchTxt + "%') ";
		}else {
			sql2 = "and " + searchType + " like '%" + searchTxt + "%' ";
		}
		if(searchTxt.equals("")){
			sql2 = "";
		}
		String sql = "select * from (select rowNum rn, a.* from (select jrb.*, m_nick, c.c_value as rc_value, (select count(*) from j_recommend2 jr2 where jr2.brd_no = jrb.brd_no) recocount from j_recommendboard jrb, j_member m, j_code c where jrb.m_no=m.m_no and jrb.rc_code=c.c_minor and brd_del_yn='n' " + sql2 + "order by ref desc, re_step) a) where rn between ? and ?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				J_RecommendBoard recommendboard = new J_RecommendBoard();
				recommendboard.setBrd_no(rs.getInt("brd_no"));
				recommendboard.setBrd_subject(rs.getString("brd_subject"));
				recommendboard.setBrd_content(rs.getString("brd_content"));
				recommendboard.setBrd_readcount(rs.getInt("brd_readcount"));
				recommendboard.setBrd_ip(rs.getString("brd_ip"));
				recommendboard.setBrd_reg_date(rs.getDate("brd_reg_date"));
				recommendboard.setBrd_update_date(rs.getDate("brd_update_date"));
				recommendboard.setBrd_dey_yn(rs.getString("brd_del_yn"));
				recommendboard.setRef(rs.getInt("ref"));
				recommendboard.setRe_step(rs.getInt("re_step"));
				recommendboard.setRe_level(rs.getInt("re_level"));
				recommendboard.setM_no(rs.getInt("m_no"));
				recommendboard.setM_nick(rs.getString("m_nick"));
				recommendboard.setRc_value(rs.getString("rc_value"));
				recommendboard.setRecocount(rs.getInt("recocount"));
				list.add(recommendboard);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs,pstmt,conn);
		}		
		return list;
	}
	
	public int insert(J_RecommendBoard recommendboard) {
		int result = 0, number = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "insert into j_recommendboard values(?,?,?,0,?,sysdate,null,'n',?,?,?,?,?)";
		String sql1 = "select nvl(max(brd_no),0)+1 from j_recommendboard";
		String sql2 = "update j_recommendboard set re_step=re_step+1 where ref=? and re_step>?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			if (rs.next())
				number = rs.getInt(1);
			pstmt.close();
			if (recommendboard.getBrd_no() != 0) {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, recommendboard.getRef());
				pstmt.setInt(2, recommendboard.getRe_step());
				pstmt.executeUpdate();
				pstmt.close();
				recommendboard.setRe_level(recommendboard.getRe_level() + 1);
				recommendboard.setRe_step(recommendboard.getRe_step() + 1);
			} else {
				recommendboard.setRef(number);
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, recommendboard.getBrd_subject());
			pstmt.setString(3, recommendboard.getBrd_content());
			pstmt.setString(4, recommendboard.getBrd_ip());
			pstmt.setInt(5, recommendboard.getRef());
			pstmt.setInt(6, recommendboard.getRe_step());
			pstmt.setInt(7, recommendboard.getRe_level());
			pstmt.setInt(8, recommendboard.getM_no());
			pstmt.setString(9, recommendboard.getRc_code());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs,pstmt,conn);
		}
		return result;
	}
	
	public J_RecommendBoard select(int brd_no) {
		J_RecommendBoard recommendboard = new J_RecommendBoard();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = 
				"select jrb.*, m.m_nick, c.c_value as rc_value, (select count(*) from j_recommend2 jr2 where jr2.brd_no = jrb.brd_no) recocount from j_recommendboard jrb, j_member m, j_code c where jrb.brd_no=? and jrb.m_no=m.m_no and jrb.rc_code=c.c_minor";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				recommendboard.setBrd_no(rs.getInt("brd_no"));
				recommendboard.setBrd_subject(rs.getString("brd_subject"));
				recommendboard.setBrd_content(rs.getString("brd_content"));
				recommendboard.setBrd_readcount(rs.getInt("brd_readcount"));
				recommendboard.setBrd_ip(rs.getString("brd_ip"));
				recommendboard.setBrd_reg_date(rs.getDate("brd_reg_date"));
				recommendboard.setBrd_update_date(rs.getDate("brd_update_date"));
				recommendboard.setRef(rs.getInt("ref"));
				recommendboard.setRe_step(rs.getInt("re_step"));
				recommendboard.setRe_level(rs.getInt("re_level"));
				recommendboard.setM_no(rs.getInt("m_no"));
				recommendboard.setM_nick(rs.getString("m_nick"));
				recommendboard.setRc_code(rs.getString("rc_code"));
				recommendboard.setRc_value(rs.getString("rc_value"));
				recommendboard.setRecocount(rs.getInt("recocount"));				
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs,pstmt,conn);
		}
		return recommendboard;
	}
	
	public int update(J_RecommendBoard recommendboard) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_recommendboard set brd_subject=?,brd_content=?,rc_code=?,brd_update_date=sysdate where brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, recommendboard.getBrd_subject());
			pstmt.setString(2, recommendboard.getBrd_content());
			pstmt.setString(3, recommendboard.getRc_code());
			pstmt.setInt(4, recommendboard.getBrd_no());
			System.out.println(recommendboard);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(recommendboard);
			System.out.println(e.getMessage());
		} finally {
			dbClose(pstmt, conn);
		}
		return result;
	}

	public int delete(int brd_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_recommendboard set brd_del_yn='y' where brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(pstmt, conn);
		}
		return result;
	}
	
	public J_RecommendBoard pwdCheck(int brd_no) {
		J_RecommendBoard recommendboard = new J_RecommendBoard();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select m.m_passwd from j_recommendboard jrb, j_member m where jrb.m_no = m.m_no and brd_no=?";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				recommendboard.setM_passwd(rs.getString("m_passwd"));
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return recommendboard;
	}
	
	public int selectRecommend(String m_no, int brd_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from j_recommend2 where m_no = ? and brd_no = ?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_no);
			pstmt.setInt(2, brd_no);
			rs = pstmt.executeQuery();
			if(rs.next()){
				result = 1;
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}
	
	public int recoCheck(String m_no, int brd_no) {
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql2 = "select * from j_recommend2 where m_no = ? and brd_no = ?";
		String sql = "insert into j_recommend2 values(?,?,sysdate,'n')";
		String sql3 = "delete from j_recommend2 where m_no = ? and brd_no = ?";	
		conn = getConnection();
			try {
				pstmt = conn.prepareStatement(sql2);
				pstmt.setString(1, m_no);
				pstmt.setInt(2, brd_no);
				rs = pstmt.executeQuery();
				if(rs.next()){
					rs.close();
					pstmt.close();
					pstmt = conn.prepareStatement(sql3);
					pstmt.setString(1, m_no);
					pstmt.setInt(2, brd_no);
					result = pstmt.executeUpdate();
					if(result > 0){
						result = 1;
					}else{
						result = -1;
					}
				}else{
					rs.close();
					pstmt.close();
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, brd_no);
					pstmt.setString(2, m_no);
					result = pstmt.executeUpdate();
					if(result > 0){
						result = 0;
					}else{
						result = -1;
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				dbClose(rs, pstmt, conn);
			}
		return result; 
	}
	
	public void dbClose(PreparedStatement pstmt, Connection conn) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// dbClose(pstmt,conn)

	public void dbClose(ResultSet rs, PreparedStatement pstmt, Connection conn) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} // dbClose(rs,pstmt,conn)
	}

}
