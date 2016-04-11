<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"
	errorPage="/error/DBError.jsp"%>
<%@ include file="../session/adminChk.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="noticeboard" class="j_noticeboard.J_NoticeBoard"></jsp:useBean>
<jsp:setProperty property="*" name="noticeboard" />
</head>
<body>
	<%
		String pageNum = request.getParameter("pageNum");
		J_NoticeBoardDao bd = J_NoticeBoardDao.getInstance();
		int result = bd.insert(noticeboard);
		if (result > 0) {
			response.sendRedirect("../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=" + pageNum);
		} else {
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