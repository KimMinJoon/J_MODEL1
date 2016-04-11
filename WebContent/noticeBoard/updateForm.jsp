<%@ include file="../session/adminChk.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="comm.css">
</head>
<body>
	<form action="../noticeBoard/updatePro.do" method="post">
		<input type="hidden" name="brd_no" value="${jnb.brd_no}"> <input
			type="hidden" name="pageNum" value="${pageNum}"> <input
			type="hidden" name="admin" value="${sessionScope.m_no}">

		<table border="1">
			<caption>게시판 수정</caption>

			<tr>
				<td class="join1">제목</td>
				<td><input type="text" name="brd_subject" required="required"
					autofocus="autofocus" value="${jnb.brd_subject}"></td>
			</tr>
			<tr>
				<td class="join1">내용</td>
				<td><textarea rows="5" cols="50" name="brd_content"
						required="required">${jnb.brd_content}</textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인">
					<input type="button" value="취소" onclick="history.go(-1)"></td>
			</tr>
		</table>
	</form>
</body>
</html>
