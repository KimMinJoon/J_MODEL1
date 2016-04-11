<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*"%>
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
	<jsp:useBean id="recommendboard" class="j_recommendboard.J_RecommendBoard"></jsp:useBean>
	<jsp:setProperty property="*" name="recommendboard" />
	<%
		String pageNum = request.getParameter("pageNum");
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		int result = jrbd.update(recommendboard);
		if (result > 0) {
	%>
			<script type="text/javascript">
				alert("수정 성공");
				location.href="../module/main.jsp?pgm=/recommendBoard/view.jsp?brd_no=<%=recommendboard.getBrd_no()%>&pageNum=<%=pageNum%>";
			</script>
	<%
		} else {
	%>
			<script type="text/javascript">
				alert("수정 실패");
				history.go(-1);
			</script>
	<%
		}
	%>
	
</body>
</html>