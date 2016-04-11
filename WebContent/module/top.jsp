<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>
	<hr size="1" color="black">
	<table width="100%">
		<tr>
			<td width="20%" align="left"><a href="main.jsp">
					<h2>Exchange Language</h2>
			</a></td>
			<c:set var="m_no" value="${sessionScope.m_no}"></c:set>
			<c:if test="${empty m_no}">
				<td width="80%" align="right"><a
				href="main.jsp?pgm=/member/login.do">Login</a> &nbsp; <a
				href="main.jsp?pgm=/member/join.do">Join</a></td>
			</c:if>
			<c:if test="${not empty m_no }">
				<td width="80%" align="right"><a
				href="main.jsp?pgm=/member/login.jsp">Login</a> &nbsp; <a
				href="main.jsp?pgm=/member/join.jsp">Join</a></td>
			</c:if>
		</tr>
	</table>

	<hr>

</body>
</html>