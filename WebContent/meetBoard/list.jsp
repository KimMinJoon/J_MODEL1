<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*"%>
<!DOCTYPE html >
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	String m_no = (String) session.getAttribute("m_no");
	String pageNum = request.getParameter("pageNum");//패이지를 읽어오지않으면!
	J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
	String searchType = request.getParameter("searchType");
	String searchTxt = request.getParameter("searchTxt");
	
	if(searchType == null || searchType.equals("null") || searchType.equals("")){
		searchType = "brd_content";
	}
	
	if(searchTxt == null || searchTxt.equals("null")){
		searchTxt = "";
	}
	
%>
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
			location.href = "../module/main.jsp?pgm=/meetBoard/writeForm.jsp?pageNum=<%=pageNum%>";
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

<table border="1" width="100%"><caption>게시판</caption>

	<tr>
		<td>말머리</td><td>글번호</td><td>제목</td><td>닉네임</td><td>희망언어</td><td>조회수</td><td>추천수</td><td>작성일</td>
	</tr>
	
<%

	int rowPerPage = 15;//한페이지에 보여줄 게시글의 수
	int pagePerBlock = 10;//한페이지에 보여줄 블락의 수 (블락은 10페이지)
	if (pageNum == null || pageNum.equals("null")||pageNum.equals("")) pageNum = "1";//페이지는 1이다.
	int nowPage = Integer.parseInt(pageNum);
	int total = bd.selectTotal(searchType, searchTxt);
	int totalPage = (int)Math.ceil((double)total/rowPerPage);
	int startRow = (nowPage - 1) * rowPerPage + 1;
	int endRow = startRow + rowPerPage - 1;
	int totalBlk = (int)Math.ceil((double)totalPage/pagePerBlock);//총블록 구하기 
	int startPage = (nowPage - 1) / 10 * 10 + 1;
	int endPage = startPage + pagePerBlock - 1;
	
	if (endPage > totalPage) {
		endPage = totalPage;
	}
	total = total - startRow +1;
	
	List<J_MeetBoard> list = bd.selectList(startRow, endRow, searchType, searchTxt);
	if (list.size() != 0){
		for(J_MeetBoard brd : list){
%>

	<tr>
		<td><%=brd.getC_value_cate()%></td>
		<td><%=total--%></td>
		<%
			if (brd.getBrd_del_yn().equals("y")) {
		%>
		<td colspan="7"> 삭제된 글입니다.</td></tr>
		<%
			}else{
		%>
		<td>
			<a href="../module/main.jsp?pgm=/meetBoard/view.jsp?brd_no=<%=brd.getBrd_no()%>&pageNum=<%=nowPage %>">
			<%=brd.getBrd_subject() %></a>
			<!-- 페이지넘을 가지고 다녀야만이 수정이나 삭제를 할때 페이지가 완료후 되돌아오는 페이지를 수정햇던 페이지로 보낸다.--> 
			<%
				if(brd.getBrd_readcount()>1){//조회수가 20보다 크면 이미지를 붙여라
					out.println("<img src='../images/hot.gif'>");
				}
			%>
		</td>
		<%-- <td><%=brd.getM_no() %></td> --%>
		<td><%=brd.getM_nick()%></td>
		<td><%=brd.getC_value_lang()%></td>
		<td><%=brd.getBrd_readcount()%></td>
		<td><%=brd.getBrd_recommend()%></td>
		<%-- <td><%=brd.getBrd_ip() %></td> --%>
		<td><%=brd.getBrd_reg_date() %></td>
		<%-- <td><%=brd.getBrd_update_date() %></td> --%>
	</tr>		
<%	
		} }
	} else {
%>
	<tr>
		<th colspan="9">데이터가 없습니다.</th>
	</tr> 
<%		
	}
%>
</table>
<div align="center">

	<a href="javascript:locate(1)">[첫페이지]</a>

<%
	if (startPage > pagePerBlock) {
%>
	<a href="javascript:locate(<%=startPage-pagePerBlock%>)">[이전]</a>
<%
	}

	for(int i = startPage; i <= endPage; i++){
		if (nowPage != i) {
%>
	<a href="javascript:locate(<%=i%>)"><%=i%></a>
	<!-- i를누르면 pageNum을 가지고 다시 그페이지로 넘어가라 -->
<%
	} else {
%>
	<strong>
		[<%=i%>]
	</strong>
<%
		}
	}
	if (totalPage > endPage) {
%>
	<a href="javascript:locate(<%=startPage + pagePerBlock%>)">[다음]</a>
<%
	}
%>

	<a href="javascript:locate(<%=totalPage%>)">[마지막페이지]</a>

	<%-- <br><button onclick="location.href='writeForm.jsp?pageNum=<%=pageNum%>'">글쓰기</button>  --%>
	<!-- <br><input type="submit" value="글쓰기"> -->
	<br><button onclick="chk(<%=m_no%>)" name="writeBtn">글쓰기</button> 

<br>
			<select id="searchType">
				<option value="brd_content" 
				<%
					if(searchType.equals("brd_content")){
				%>
					selected="selected"
				<%
					}
				%>
				>제목 + 내용</option>
				<option value="m_nick"
				<%
					if(searchType.equals("m_nick")){
				%>
					selected="selected"
				<%
					}
				%>
				>글쓴이</option>
			</select>
			<input type="text" id="searchTxt" value="<%=searchTxt%>">
			<input type="submit" value="검색" onclick="locate(1)">
</div>

</body>
</html>