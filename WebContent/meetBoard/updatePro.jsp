<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="meetboard" class="j_meetboard.J_MeetBoard"></jsp:useBean>
<jsp:setProperty property="*" name="meetboard"/>
<%
	String pageNum = request.getParameter("pageNum");
	J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
	int result = bd.update(meetboard);
	if (result > 0){
%>
	<script type="text/javascript">
		alert("수정 성공");
		location.href="../module/main.jsp?pgm=/meetBoard/view.jsp?brd_no=<%=meetboard.getBrd_no()%>&pageNum=<%=pageNum %>";
	</script>
<%
	}else {
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