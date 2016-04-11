<%@page import="j_onelineboard.J_OneLineBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="jolr" class="j_onelineboard.J_OneLineReply"/>
	<jsp:setProperty property="*" name="jolr"/>
<%
	int reply_no = Integer.parseInt(request.getParameter("reply_no"));
	J_OneLineBoardDAO jolbd =  J_OneLineBoardDAO.getInstance();
	int result = jolbd.deleteRep(reply_no);
	
%>
</body>
</html>