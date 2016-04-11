<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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



		<c:if test="${not empty list}">
			<c:forEach var="brd" items="${list}">

				<tr>
					<td colspan="4"><hr></td>
				</tr>
				<tr>
					<td class="default">
						<%-- <%=total--%>
					</td>
					<td class="subject"><a
						href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/view.jsp?brd_no=${brd.brd_no}&pageNum=${nowPage}">${brd.brd_subject}</a>
						<!-- 페이지넘을 가지고 다녀야만이 수정이나 삭제를 할때 페이지가 완료후 되돌아오는 페이지를 수정햇던 페이지로 보낸다.-->
					</td>
					<td class="default">${brd.brd_reg_date}</td>
					<!-- 작성일 -->
					<td class="default">${brd.brd_readcount}</td>
					<!-- 읽은 횟수 -->
				</tr>
			</c:forEach>
		</c:if>
		<c:if test="${empty list}">
			<tr>
				<th colspan="4">데이터가 없습니다.</th>
			</tr>
		</c:if>
	</table>
	<br>
	<div align="center">
		<c:if test="${startPage > pagePerBlock}">
			<a
				href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=${startPage-pagePerBlock}">[이전]</a>
			<a
				href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=1">[1]</a>
		...
		</c:if>
		<c:forEach var="i" begin="${startPage }" end="${endPage }">
			<c:if test="${i == nowPage}">
				<b>[${i}] </b>
				<!-- i를누르면 pageNum을 가지고 다시 그페이지로 넘어가라 -->
			</c:if>
			<c:if test="${i != nowPage}">
				<a
					href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=${i}">[${i}]
				</a>
			</c:if>
		</c:forEach>
		<c:if test="${totalPage > endPage }">
	
		... <a
				href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=${totalPage}">[${totalPage}]
			</a>
			<a
				href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=${startPage+pagePerBlock}">[다음]</a>
		</c:if>
		<p>
			<c:set var="admin" value="${sessionScope.m_no}" />
			<c:if
				test="${empty admin } || ${ admin eq ''} || ${ admin eq 'null'} || ${ admin ne '1'}">
				<button
					onclick="location.href='../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/writeForm.jsp?pageNum=${pageNum}'">글쓰기</button>
			</c:if>
	</div>
</body>
</html>