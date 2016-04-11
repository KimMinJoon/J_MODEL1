<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			<td>
			<c:if test="${empty param.pgm}"><jsp:include page="home.jsp"></jsp:include></c:if>
			<c:if test="${not empty param.pgm}"><jsp:include page="${param.pgm }"></jsp:include></c:if>
			</td>
		</tr>
		<tr>
			<td colspan="2" height="40"><jsp:include page="bottom.jsp" /></td>
		</tr>
	</table>
</body>
</html>