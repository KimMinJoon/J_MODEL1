/*
<국가_언어 db 처리하는 Dao.java>

마지막 수정날짜 : 2016-03-24 오전 11:47
마지막 수정한 사람 : 강진우
*/

package j_code;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

public class J_CodeDao {
	private static J_CodeDao instance = new J_CodeDao();
	private J_CodeDao() { }
	public static J_CodeDao getInstance() {
		return instance;
	}

	public Connection getConnection() {
		Connection conn = null;
		try {
			Context ctx = new InitialContext();// 연결
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/OracleDB");// 커넥션
																					// 풀
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}// getConnection

	public List<J_Code> selectList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<J_Code> list = new ArrayList<>();
		String sql = "select * from j_code";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				J_Code c = new J_Code();
				c.setC_major(rs.getString(1));
				c.setC_minor(rs.getString(2));
				c.setC_value(rs.getString(3));
				list.add(c);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return list;
	}

}
