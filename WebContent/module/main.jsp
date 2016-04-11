<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String pgm = request.getParameter("pgm");
	if (pgm == null || pgm == "") {
		pgm = "home.jsp";
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>
	<table align="center">
		<tr>
			<td width="1100" height="50"><jsp:include page="top.jsp" /></td>
		</tr>
		<tr>
			<td><jsp:include page="menu.jsp"/></td>
		</tr>
		<tr>
			<td><jsp:include page="<%=pgm%>"/></td>
		</tr>
		<tr>
			<td colspan="2" height="40"><jsp:include page="bottom.jsp" /></td>
		</tr>
	</table>
</body>
</html>