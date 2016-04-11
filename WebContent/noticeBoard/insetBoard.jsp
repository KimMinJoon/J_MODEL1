<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		J_NoticeBoardDao jnbd = J_NoticeBoardDao.getInstance();

		for (int i = 0; i <= 10000; i++) {
			J_NoticeBoard jrb = new J_NoticeBoard();
			jrb.setBrd_subject("초아초아조아요" + i);
			jrb.setBrd_content("아이유도조아요" + i);
			jrb.setAdmin("1");
			jnbd.insert(jrb);
		}
	%>
	성공
</body>
</html>