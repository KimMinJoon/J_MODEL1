<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*"%>
<%@ include file="../session/sessionChk.jsp"  %>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
<script type="text/javascript">
	function chk() {
		if(frm.password.value != frm.dbPass.value){
			alert("암호가 다릅니다.");
			frm.password.focus();
			return false;
		}
		return true;
	}
</script>
</head><body>
<%
	String pageNum = request.getParameter("pageNum");
	int brd_no = Integer.parseInt(request.getParameter("brd_no"));
	J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
	J_MeetBoard meetboard = bd.passwdChk(brd_no);
	String dbPass = meetboard.getM_passwd();
	// 로그인없이 게시글 접근 시 막기 
		
%>
<form action="../meetBoard/deletePro.jsp" name="frm" onsubmit="return chk()">
	<input type="hidden" name="brd_no" value="<%=brd_no%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="dbPass" value="<%=dbPass%>"> 
	암호 : <input type="password" name="password" required="required" autofocus="autofocus">
	<input type="submit" value="확인">
</form>

</body>
</html>