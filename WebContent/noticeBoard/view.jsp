<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
</head>
<body>
	<%
		String m_no = (String) session.getAttribute("m_no");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_NoticeBoardDao jnbd = J_NoticeBoardDao.getInstance();
		J_NoticeBoard jnb = jnbd.select(brd_no);
		jnbd.updateHit(brd_no);
	%>
	<table border="1" width="70%" align="center">
		<caption>
			<h2>게시판 보기</h2>
		</caption>
		<tr>
			<th>제목</th>
			<td><%=jnb.getBrd_subject()%></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=jnb.getBrd_readcount()%></td>
		</tr>
		<%
			if (jnb.getBrd_update_date() != null) {
		%>
		<tr>
			<th>작성일</th>
			<td><%=jnb.getBrd_reg_date()%></td>
		</tr>
		<tr>
			<th>최근수정일</th>
			<td><%=jnb.getBrd_reg_date()%></td>
		</tr>

		<%
			} else {
		%>
		<tr>
			<th>작성일</th>
			<td><%=jnb.getBrd_reg_date()%></td>
		</tr>
		<%
			}
		%>
		<tr>
			<th>내용</th>
			<td><pre><%=jnb.getBrd_content()%></pre></td>
			<!-- pre는 입력한 내용을 잇는 그래도 보여줌  -->
		</tr>
	</table>
	<p>
	<div align="center">
		<button
			onclick="location.href='../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=<%=pageNum%>'">
			목록</button>
		<%
			String admin = (String) session.getAttribute("m_no");
			if (admin == null || admin.equals("") || admin.equals("null") || !admin.equals("1")) {
			} else {
		%>
		<button
			onclick="location.href='../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/updateForm.jsp?brd_no=<%=brd_no%>&pageNum=<%=pageNum%>'">수정</button>
		<!-- 이렇게해야 수정을 누르면 수정클릭한 해당 페이지로 보내준다. -->
		<button
			onclick="location.href='../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/deleteForm.jsp?brd_no=<%=brd_no%>&pageNum=<%=pageNum%>'">삭제</button>
		<%
			}
		%>
	</div>
</body>
</html>