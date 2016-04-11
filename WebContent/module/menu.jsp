<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>
	<hr size="1" color="black">
	<table height="5" width="100%">
		<tr>
			<td width="20%" align="center"><a href="main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp">사이트소개/공지사항</a></td>
			<td width="20%" align="center"><a href="main.jsp?pgm=/meetBoard/list.do">모임 게시판</a></td>
			<td width="20%" align="center"><a href="main.jsp?pgm=/recommendBoard/list.jsp">추천 게시판</a></td>
			<td width="20%" align="center"><a href="main.jsp?pgm=/oneLineBoard/list.do">한줄 게시판</a></td>
			<td width="20%" align="center">
			<input type="text" id="search" name="search" size=15 />
			<input type="button" id="search" name="search" value="검색"/>
			</td>
		</tr>
	</table>
	
	<hr>
	
</body>
</html>