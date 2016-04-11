<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*"%>
<%@ include file="../session/sessionChk.jsp"%>

<%
		String pageNum = request.getParameter("pageNum");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		J_RecommendBoard recommendboard = jrbd.pwdCheck(brd_no);
		String dbPass = recommendboard.getM_passwd();
%>
	
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
<script type="text/javascript">
	function deleteCheck(){	
			if (frm.password.value == '') {
				alert('비밀번호를 입력해주세요.');
				frm.password.focus();
				return false;
			}
			if(frm.password.value != frm.dbPass.value){
				alert("비밀번호가 다릅니다.");
				frm.password.focus();
				return false;
			}
		return true;
	}
</script>
</head>
<body>
	
	<form action="../recommendBoard/deletePro.jsp" name="frm" onsubmit="return deleteCheck()">
		<input type="hidden" name="brd_no" value="<%=brd_no%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="dbPass" value="<%=dbPass%>">
		<table align="center" cellpadding="0" cellspacing="0" border="0">
			<tr height="25">
			<td align="right" width="120" bgcolor="#D5D5D5"> <font face="나눔고딕" size="2"> password &nbsp; </font> </td>
			<td><input type="password" id="password" name="password" maxlength="15" size="15"></td>
			</tr>
			<tr height="10" bgcolor="white"><td colspan="2"></td></tr>
			<tr align="center">
				<td colspan="2">
				<input type="submit" value="삭제">
				<input type="button" value="취소" onclick="window.close()">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>