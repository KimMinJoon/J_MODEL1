<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html >
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
function chk(m_no) {
		alert(m_no);
		if(m_no == null || m_no == "" || m_no == "null"){
			if (confirm("이 서비스는 로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?")==true) {
				location.href = "../module/main.jsp?pgm=/member/login.jsp";
			} else {
				return;
			}
		}else{
			location.href = "../module/main.jsp?pgm=/meetBoard/writeForm.do?pageNum="+${param.pageNum};
		}
}

function locate(pageNum){
	var searchType = document.getElementById("searchType");
	var searchTxt = document.getElementById("searchTxt");
	location.href="main.jsp?pgm=/meetBoard/list.jsp?pageNum=" + pageNum + "&searchType=" + searchType.value + "&searchTxt=" + searchTxt.value;
}

</script>
<link type="text/css" rel="stylesheet" href="../css/projectcss.css">
</head><body>

<c:set var="pageNum" value="${pageNum}"></c:set>
<table border="1" width="100%"><caption>게시판</caption>

	<tr>
		<td>말머리</td><td>글번호</td><td>제목</td><td>닉네임</td><td>희망언어</td><td>조회수</td><td>추천수</td><td>작성일</td>
	</tr>
	<c:set var="tot" value="${total }"></c:set>
	
	
	<c:if test="${ not empty list}">
		<c:forEach var="brd" items="${list }"> 

	<tr>
		<td>${brd.c_value_cate}</td>
		
		<td>${tot}</td>
		<c:if test="${brd.brd_del_yn == 'y' }">
		<td colspan="7"> 삭제된 글입니다.</td></tr>
		</c:if>
		
		<c:if test="${brd.brd_del_yn == 'n' }">
		<td>
			<a href="../module/main.jsp?pgm=/meetBoard/view.jsp?brd_no=${brd.brd_no}&pageNum=${nowPage}">
			${brd.brd_subject}</a>
			<!-- 페이지넘을 가지고 다녀야만이 수정이나 삭제를 할때 페이지가 완료후 되돌아오는 페이지를 수정햇던 페이지로 보낸다.--> 
			<c:if test="${ brd_readcount > 1}">
			<img src='../images/hot.gif'>
			
			</c:if>
		</td>
		<%-- <td><%=brd.getM_no() %></td> --%>
		<td>${brd.m_nick}</td>
		<td>${brd.c_value_lang}</td>
		<td>${brd.brd_readcount}</td>
		<td>${brd.brd_recommend}</td>
		<%-- <td><%=brd.getBrd_ip() %></td> --%>
		<td>${brd.brd_reg_date}</td>
		<%-- <td><%=brd.getBrd_update_date() %></td> --%>
	</tr>		
	</c:if>

	</c:forEach>
	
	</c:if>
	
	<c:if test="${empty list }">
 	<c:set var="tot" value="${tot - 1 }"></c:set>
	<tr>
		<th colspan="9">데이터가 없습니다.</th>
	</tr> 
	</c:if>
</table>
<div align="center">
	<a href="javascript:locate(1)">[첫페이지]</a>
<c:if test="${startPage > pagePerBlock}">

	<a href="javascript:locate(${startPage-pagePerBlock})">[이전]</a>
	</c:if>
	

	<c:forEach var="i" begin="${startPage }" end="${endPage }">
	<c:if test="${nowPage ne i }">
	<a href="javascript:locate(${i}})">${i}</a>
	</c:if>
	
	<!-- i를누르면 pageNum을 가지고 다시 그페이지로 넘어가라 -->

	<c:if test="${nowPage eq i }">
	<strong>
		[${i}]
	</strong>
	</c:if>
	</c:forEach>
	<c:if test="${totalPage > endPage } }">

	<a href="javascript:locate(${startPage + pagePerBlock})">[다음]</a>

	</c:if>

	<a href="javascript:locate(${totalPage})">[마지막페이지]</a>

	<%-- <br><button onclick="location.href='writeForm.jsp?pageNum=<%=pageNum%>'">글쓰기</button>  --%>
	<!-- <br><input type="submit" value="글쓰기"> -->
	<br><button onclick="chk(${m_no})" name="writeBtn">글쓰기</button> 

<br>
		<select id="searchType">
			
			<c:if test="${searchType eq 'all' }">
				<option value="all" selected="selected">제목 + 내용</option>
			</c:if>
			
			<c:if test="${searchType ne 'all' }">
				<option value="all">제목 + 내용</option>
			</c:if>
				
				
				
			<c:if test="${searchType eq brd_content }">	
				<option value="brd_content" selected="selected">내용</option>
			</c:if>
			
			<c:if test="${searchType ne brd_content }">
				<option value="content">내용</option>
			</c:if>
				
			<c:if test="${searchType eq brd_subject }">
				<option value="brd_subject" selected="selected">제목</option>
			</c:if>
			
			<c:if test="${searchType ne brd_subject }">
				<option value="brd_subject">제목</option>
			</c:if>
				
			<c:if test="${searchType eq m_nick }">
				<option value="m_nick" selected="selected">글쓴이</option>
			</c:if>
			
			<c:if test="${searchType ne m_nick }">
				<option value="m_nick">글쓴이</option>
			</c:if>
			
			</select>
			<input type="text" id="searchTxt" value="${searchTxt}">
			<input type="submit" value="검색" onclick="locate(1)">
</div>
</body>
</html>