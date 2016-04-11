<%@page import="java.util.List"%>
<%@ include file="../session/adminChk.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WriteForm</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
<%
	String pageNum = request.getParameter("pageNum");
%>

</head>
<body>
	<form action="../noticeBoard/writePro.jsp" method="post">
		<input type="hidden" name="pageNum" value="<%=pageNum%>"> <input
			type="hidden" name="admin" value="<%=admin%>">

		<table class="tab" cellpadding="10" align="center" width="50%">
			<caption>
				<h2>공지사항 작성</h2>
			</caption>
			<tr>
				<td class="join1">제목</td>
				<td><input type="text" name="brd_subject" required="required"
					autofocus="autofocus"></td>
			</tr>
			<tr>
				<td class="join1">내용</td>
				<td><textarea rows="5" cols="50" name="brd_content"
						required="required"></textarea></td>
			</tr>

			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인">&nbsp;
					<input type="button" value="취소" onclick="history.go(-1)"></td>
			</tr>
		</table>
	</form>
</body>
</html>