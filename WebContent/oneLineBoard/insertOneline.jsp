<%@page import="j_onelineboard.J_OneLineBoardDAO"%>
<%@page import="j_board.J_BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../session/sessionChk.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<jsp:useBean id="olb" class="j_onelineboard.J_OneLineBoard"/>
<jsp:setProperty property="*" name="olb"/>
<body>
<%	
	olb.setBrd_ip(request.getRemoteAddr());
	J_OneLineBoardDAO jold = J_OneLineBoardDAO.getInstance();
	int result = jold.insertBoard(olb);
	if(result > 0){
		response.sendRedirect("../module/main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp");
	}else{
%>
	<script type="text/javascript">
		alert("한줄 글 등록 실패");
		history.back();
	</script>
<%
	}
%>
</body>
</html>