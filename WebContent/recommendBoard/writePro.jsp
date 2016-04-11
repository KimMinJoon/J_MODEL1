<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*" errorPage="/error/DBError.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="recommendboard" class="j_recommendboard.J_RecommendBoard"></jsp:useBean>
<jsp:setProperty property="*" name="recommendboard" />
</head>
<body>

	<%
		String pageNum = request.getParameter("pageNum");
		String ip = request.getRemoteAddr();
		recommendboard.setBrd_ip(ip);
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		int result = jrbd.insert(recommendboard);
		if (result > 0)
			response.sendRedirect("../module/main.jsp?pgm=/recommendBoard/list.jsp?pageNum=" + pageNum);
		else {
	%>
		<script type="text/javascript">
			alert("글쓰기 실패");
			history.go(-1);
		</script>
	<%
		}
	%>
	
</body>
</html>