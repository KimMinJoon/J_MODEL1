/**
 * 한줄게시판 DAO 클래스
 * 한줄게시판에 보여질 모든 데이터베이스 정보를 가져오는 역할을 수행
 * 
 * @version 1.1.1
 * @author 이재설
 */
package j_onelineboard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class J_OneLineBoardDAO {
	private static J_OneLineBoardDAO instance = new J_OneLineBoardDAO();//싱글톤 생성
	private J_OneLineBoardDAO() {}
	public static J_OneLineBoardDAO getInstance(){
		return instance;
	}
	/**
	 * 
	 * @return 커멕션 풀에 있는 커넥션 가져와서 반환
	 */
	public Connection getConnection(){//커넥션 풀 
		Connection conn = null;
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/OracleDB");
			conn = ds.getConnection();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return conn;
	}//getConnection
	
	
	/**
	 * 한줄게시판에 새로운 글에 대한 정보를 데이터 베이스에 입력 하는 기능을 수행
	 * @param job 한줄게시판에 입력된 새로운 게시글 정보를 담고 있는 DTO 객체
	 * @return db 에 insert 작업을 수행하고 성공 여부
	 * 
	 */
	public int insertBoard(J_OneLineBoard job){
		int result = 0;//결과값
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int brd_number = 0;//새로운 게시글 번호 저장
		
		String sql = "insert into J_OneLineBoard values(?,?,sysdate,null,?,'n',?,null)";
		String sql1 = "select nvl(max(brd_no),0)+1 from J_OneLineBoard";

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			if (rs.next())
				brd_number = rs.getInt(1);//마지막 게시글 번호 + 1 된 번호
			pstmt.close();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_number);
			pstmt.setString(2, job.getBrd_content());
			pstmt.setString(3, job.getBrd_ip());
			pstmt.setInt(4, job.getM_no());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}//insertOneline
	
	/**
	 * 한줄게시판의 한페이지에 보여질 게시글들을 보이기 위해 DB 에서 정보를 읽어오는 기능을 수행
	 * 
	 * @param startRow 한페이지에서 보여질 첫 게시글 번호
	 * @param endRow 한페이지에서 보여질 마지막 게시글 번호
	 * @param searchType 검색 파라미터 (글쓴이 / 내용)
	 * @param searchTxt 검색 파라미터 (입력값)
	 * @return 페이징 처리와 조건 검색으로 완성된 List를 반환
	 * 
	 */
	public List<J_OneLineBoard> selectOneLine(int startRow, int endRow, String searchType, String searchTxt){
		List<J_OneLineBoard> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql2 = " and " +searchType + " like '%" + searchTxt + "%' ";	//조건 검색시 추가되어야할 QUERY
		if(searchTxt.equals("")){
			sql2 = "";
		}//검색내용이 없다면 검색을 하지 않고 모든 게시글을 가져오는 것으로 판단
		String sql = "SELECT * FROM (SELECT ROWNUM RN, A.* FROM(select m_nick, brd_no, fc_date_check(brd_reg_date) as dt, brd_content, brd_del_yn, a.m_no,(select count(*) from J_ONELINEREPLY c where c.brd_no = a.brd_no) rep_count from J_OneLineBoard a, j_member b where a.m_no = b.m_no and brd_del_yn = 'n' " + sql2 + "order by brd_no desc) A) WHERE RN BETWEEN ? AND ?";
		//System.out.println(sql);
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				J_OneLineBoard jolb = new J_OneLineBoard();
				jolb.setM_nick(rs.getString("M_NICK"));
				jolb.setBrd_no(rs.getInt("BRD_NO"));
				jolb.setBrd_content(rs.getString("BRD_CONTENT"));
				jolb.setBrd_reg_date(rs.getString("DT"));
				jolb.setBrd_del_yn(rs.getString("BRD_DEL_YN"));
				jolb.setM_no(rs.getInt("M_NO"));
				jolb.setRep_count(rs.getInt("REP_COUNT"));
				
				list.add(jolb);
			}
		}catch(Exception e){
			System.out.println("selectOneLine : " + e.getMessage());
		}finally {
			dbClose(rs, pstmt, conn);
		}
		return list;
	}//selectOneLine
	
	/**
	 * 
	 * @param brd_no 
	 * @return
	 *//*
	public J_OneLineBoard selectOneLineByNo(int brd_no){
		J_OneLineBoard jolb  = new J_OneLineBoard();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select brd_no,m_nick, brd_reg_date,brd_content from J_OneLineBoard a , J_MEMBER b where a.m_no = b.m_no and brd_del_yn = 'n' and brd_no = ?";
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				jolb.setBrd_no(rs.getInt("BRD_NO"));
				jolb.setM_nick(rs.getString("M_NICK"));
				jolb.setBrd_reg_date(rs.getString("BRD_REG_DATE"));
				jolb.setBrd_content(rs.getString("BRD_CONTENT"));
			}
		}catch(Exception e){
			System.out.println(jolb);
			System.out.println("selectOneLineByNo : " + e.getMessage());
		}finally {
			dbClose(rs, pstmt, conn);
		}
		return jolb;
	}//selectOneLineByNo
*/	
	/**
	 *	DB 에서 입력된 게시글들의 총 수를 구하는 역할을 수행
	 *	검색 파라미터가 전달 됬다면 검색 조건에 일치하는 게시글의 수를 구한다.
	 *
	 * @param searchType 검색 파라미터 (글쓴이 / 내용)
	 * @param searchTxt 검색 파라미터 (입력값)
	 * @return 데이터베이스에서 읽어온 게시글의 총 수
	 */
	public int selectTotal(String searchType, String searchTxt){
		int total = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT COUNT(*) FROM J_OneLineBoard a, j_member b WHERE a.m_no = b.m_no and BRD_DEL_YN = 'n'";
		String sql2 = " and " +searchType + " like '%" + searchTxt + "%'";//조건 검색시 추가되어야 할 QUERY
		
		if(!searchTxt.equals("")){
			sql += sql2;
		}//검색 내용이 있다면 검색 조건에 대한 QUERY를 기존에 작성되어있던 QUERY 문에 추가한다.
		System.out.println(sql);
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				total = rs.getInt(1);
			}
		} catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			dbClose(rs, pstmt, conn);
		}
		return total;
	}//selectTotal
	
	/**
	 * 사용자에게 입력받은 정보로 DB에 입력된 게시글을 수정하는 작업을 수행
	 * 
	 * @param jolb 사용자에게 입력 받은 게시글 수정 정보를 가진 DTO 객체
	 * @return 수정 작업 성공 여부
	 */
	public int updateBoard(J_OneLineBoard jolb){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update J_OneLineBoard set brd_content = ? , brd_update_date = sysdate where brd_no = ? and m_no = ? and brd_del_yn = 'n'";
		// 삭제가 되지 않은 게시글 중에 사용자 자신이 작성한 게시글의 내용을 갱신하고 현재 일자로 수정일이 입력됨
		// 수정일이 NULL 이 아니라면 한번이라도 수정된 게시글로 판단
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, jolb.getBrd_content());
			pstmt.setInt(2,	jolb.getBrd_no());
			pstmt.setInt(3, jolb.getM_no());
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally {
			dbClose(pstmt, conn);
		}
		return result;
	}//updateBoard
	
	/**
	 * 선택된 게시글의 삭제를 수행
	 * DB에 저장된 정보를 DELETE 하는 것이 아닌 삭제여부 컬럼 (BRD_DEL_YN) 을 n -> y 로 갱신 시켜 
	 * 사용자에 의해 삭제가 되었다고 판단한다.(사용자가 입력한 데이터는 최대한 보존하기 위한 목적)
	 * 
	 * @param brd_no 삭제될 글 번호
	 * @return 삭제 작업 성공 여부
	 */
	public int deleteBoard(int brd_no){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "update j_onelineboard set brd_del_yn = 'y',brd_out_date = sysdate where brd_no = ? and brd_del_yn = 'n'";
		//삭제되지 않은 게시글의 삭제여부 컬럼을 y -> n 으로 변경하며 삭제일자를 현재일자로 변경 한다
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println(e.getMessage());
		}finally {
			dbClose(pstmt, conn);
		}
		return result;
	}//deleteBoard
	
	public int insertReply(J_OneLineReply jolr){
		int result = 0;
		int rpl_number = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		System.out.println(jolr);
		
		String sql = "insert into J_onelineReply values (?,?,?,sysdate,null,?,'n',null)";
		String sql1 = "select nvl(max(REPLY_NO),0)+1 from J_onelineReply";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			if (rs.next())
				rpl_number = rs.getInt(1);
			pstmt.close();
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, rpl_number);
			pstmt.setInt(2,jolr.getBrd_no());
			pstmt.setString(3, jolr.getContent());
			pstmt.setInt(4, jolr.getM_no());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("result : " + result);
			System.out.println(e.getMessage());
		} finally {
			dbClose(rs, pstmt, conn);
		}
		return result;
	}//insertReply
	
	public int deleteRep(int reply_no){
		int result = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "UPDATE J_ONELINEREPLY SET OUT_DATE = SYSDATE, DEL_YN = 'y' WHERE REPLY_NO = ? AND DEL_YN = 'n'";
		
		try{
			
		}catch(Exception e){
			
		}finally {
			dbClose(pstmt, conn);
		}
		return result;
	}
	
	public List<J_OneLineReply> selectReply(int brd_no){
		List<J_OneLineReply> list = new ArrayList<J_OneLineReply>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT REPLY_NO,BRD_NO, CONTENT, FC_DATE_CHECK(REG_DATE) AS REG_DATE, M_NICK, A.M_NO FROM J_ONELINEREPLY A, J_MEMBER B WHERE A.M_NO = B.M_NO AND BRD_NO = ? AND DEL_YN = 'n'";
		
		try{
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, brd_no);
			rs = pstmt.executeQuery();
			while(rs.next()){
				J_OneLineReply jolr = new J_OneLineReply();
				jolr.setReply_no(rs.getInt("REPLY_NO"));
				jolr.setBrd_no(rs.getInt("BRD_NO"));
				jolr.setContent(rs.getString("CONTENT"));
				jolr.setReg_Date(rs.getString("REG_DATE"));
				jolr.setM_nick(rs.getString("M_NICK"));
				jolr.setM_no(rs.getInt("M_NO"));
				list.add(jolr);
			}
			
		} catch(Exception e){
			System.out.println(e.getMessage());
		}finally{
			dbClose(rs, pstmt, conn);
		}
		return list;
	}//selectReply
	
	/**
	 * DB 접근하기 위해 사용 되었던 Connection, PrepareStatement, ResultSet 을
	 * 일괄 close 를 수행
	 * SELECT 작업을 수행했던 메서드에 주로 사용
	 * 
	 * @param rs close 되어야할 ResultSet
	 * @param pstmt close 되어야할 PrepareStatement
	 * @param conn close 되어야할 Connection
	 */
	public void dbClose(ResultSet rs,PreparedStatement pstmt, Connection conn){
		try{
			if(rs != null){
				rs.close();
			}
			if(pstmt != null){
				pstmt.close();
			}
			if(conn != null){
				conn.close();
			}
		}catch(SQLException e){
			System.out.println(e.getMessage());
		}
	}//dbClose( rs,pstmt, conn)
	
	/**
	 * DB 접근하기 위해 사용 되었던 Connection, PrepareStatement 을
	 * 일괄 close 를 수행
	 * INSERT, UPDATE, DELETE 작업을 수행했던 메서드에 주로 사용
	 * 
	 * @param pstmt  close 되어야할 PrepareStatement
	 * @param conn close 되어야할 Connection
	 */
	public void dbClose(PreparedStatement pstmt, Connection conn){	
		try{
			if(pstmt != null){
				pstmt.close();
			}
			if(conn != null){
				conn.close();
			}
		}catch(SQLException e){
			System.out.println(e.getMessage());
		}
	}//dbClose( pstmt, conn)
}
