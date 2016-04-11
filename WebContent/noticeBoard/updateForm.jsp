<%@page import="java.util.List"%>
<%@ include file="../session/adminChk.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="comm.css">
</head>
<body>
	<%
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_NoticeBoardDao bd = J_NoticeBoardDao.getInstance();
		J_NoticeBoard nb = bd.select(brd_no);
	%>
	<form action="../noticeBoard/updatePro.jsp" method="post">
		<input type="hidden" name="brd_no" value="<%=nb.getBrd_no()%>"> <input
			type="hidden" name="pageNum" value="<%=pageNum%>">
			<input
			type="hidden" name="admin" value="<%=admin%>">

		<table border="1">
			<caption>게시판 수정</caption>

			<tr>
				<td class="join1">제목</td>
				<td><input type="text" name="brd_subject" required="required"
					autofocus="autofocus" value="<%=nb.getBrd_subject()%>"></td>
			</tr>
			<tr>
				<td class="join1">내용</td>
				<td><textarea rows="5" cols="50" name="brd_content"
						required="required"><%=nb.getBrd_content()%></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인">
					<input type="button" value="취소" onclick="history.go(-1)"></td>
			</tr>
		</table>
	</form>
</body>
</html>