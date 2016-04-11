<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="meetboard" class="j_meetboard.J_MeetBoard"></jsp:useBean>
<jsp:setProperty property="*" name="meetboard"/>
</head>
<body>
<%
	String pageNum = request.getParameter("pageNum");
	String ip = request.getRemoteAddr();//아이피주소를 남기기위해 씀
	meetboard.setBrd_ip(ip);
	J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
	int result = bd.insert(meetboard);
	if (result > 0) response.sendRedirect("../module/main.jsp?pgm=/meetBoard/list.jsp?pageNum="+pageNum);
	else {
%>
<script type="text/javascript">
	alert("잘해!");
	history.go(-1);
</script>
<%
	}
%>
</body>
</html>