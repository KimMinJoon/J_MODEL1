<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_member.*,j_code.*, java.util.*" %>
<%@ include file="../session/sessionChk.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		J_MemberDao jmd = J_MemberDao.getInstance();
		J_Member jif = jmd.infoselect(m_no);
	%>
	<table class="tab" cellpadding="10" align="center" height="100%">
		<caption>
			<h2>내정보보기</h2>
		</caption>
		<tr height="40%">
			<td colspan="2"><img alt="pic" src="../images/1P.jpg"
				height="150"></td>
		</tr>
		<tr height="15%">
			<td class="join1">이메일</td>
			<td><%=jif.getM_email()%></td>
		</tr>
		<tr height="15%">
			<td class="join1">닉네임</td>
			<td><%=jif.getM_nick()%></td>
		</tr>
		<tr height="15%">
			<td class="join1">국적</td>
			<td><%=jif.getC_value() %></td>
		</tr>
		<tr height="15%">
			<td class="join1">희망언어</td>
			<td><%=jif.getL_value() %></td>
		</tr>
	</table>

</body>
</html>