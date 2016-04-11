<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="../css/projectcss.css">
</head>
<body>
	<p>
	<p>
	<table align="center" width="70%" cellspacing="0" cellpadding="0">
		<caption>
			<h2>공지사항</h2>
		</caption>

		<tr>
			<th width="3%"></th>
			<th width="32%">제목</th>
			<th width="10%">작성일</th>
			<th width="5%">조회수</th>
		</tr>

		<%
			J_NoticeBoardDao bd = J_NoticeBoardDao.getInstance();
			String pageNum = request.getParameter("pageNum");//패이지를 읽어오지않으면!
			if (pageNum == null || pageNum.equals("null") || pageNum.equals(""))
				pageNum = "1";

			int rowPerPage = 15;//한페이지에 보여줄 게시글의 수
			int pagePerBlock = 10;//한페이지에 보여줄 블락의 수 (블락은 10페이지)
			int nowPage = Integer.parseInt(pageNum);
			int total = bd.selectTotal();
			int totalPage = (int) Math.ceil((double) total / rowPerPage);
			int startRow = (nowPage - 1) * rowPerPage + 1;
			int endRow = startRow + rowPerPage - 1;
			int totalBlk = (int) Math.ceil((double) totalPage / pagePerBlock);//총블록 구하기 
			int startPage = (nowPage - 1) / 10 * 10 + 1;
			int endPage = startPage + pagePerBlock - 1;
			if (endPage > totalPage)
				endPage = totalPage;
			total = total - startRow + 1;
			List<J_NoticeBoard> list = bd.selectList(startRow, endRow);
			if (list.size() != 0) {
				for (J_NoticeBoard brd : list) {
		%>
		<tr>
			<td colspan="4"><hr></td>
		</tr>
		<tr>
			<td class="default">
				<%-- <%=total--%>
			</td>
			<td class="subject"><a
				href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/view.jsp?brd_no=<%=brd.getBrd_no()%>&pageNum=<%=nowPage%>"><%=brd.getBrd_subject()%></a>
				<!-- 페이지넘을 가지고 다녀야만이 수정이나 삭제를 할때 페이지가 완료후 되돌아오는 페이지를 수정햇던 페이지로 보낸다.-->
			</td>
			<td class="default"><%=brd.getBrd_reg_date()%></td>
			<!-- 작성일 -->
			<td class="default"><%=brd.getBrd_readcount()%></td>
			<!-- 읽은 횟수 -->
		</tr>
		<%
			}
			} else {
		%>
		<tr>
			<th colspan="4">데이터가 없습니다.</th>
		</tr>
		<%
			}
		%>
	</table>
	<br>
	<div align="center">
		<%
			if (startPage > pagePerBlock) {
		%>
		<a
			href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=<%=startPage - pagePerBlock%>">[이전]</a>
		<a href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=1">[1]</a>
		...
		<%
			}

			for (int i = startPage; i <= endPage; i++) {
				if (i == nowPage) {
		%>
		<b>[<%=i%>]
		</b>
		<!-- i를누르면 pageNum을 가지고 다시 그페이지로 넘어가라 -->
		<%
			} else {
		%>
		<a href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=<%=i%>">[<%=i%>]
		</a>
		<%
			}

			}
			if (totalPage > endPage) {
		%>
		... <a
			href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=<%=totalPage%>">[<%=totalPage%>]
		</a> <a
			href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=<%=startPage + pagePerBlock%>">[다음]</a>
		<%
			}
		%>
		<p>
			<%
				String admin = (String) session.getAttribute("m_no");
				if (admin == null || admin.equals("") || admin.equals("null") || !admin.equals("1")) {
				} else {
			%>
			<button
				onclick="location.href='../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/writeForm.jsp?pageNum=<%=pageNum%>'">글쓰기</button>
			<%
				}
			%>
		
	</div>
</body>
</html>