<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
<script type="text/javascript">
	function locate(pageNum){
		var searchType = document.getElementById("searchType");
		var searchTxt = document.getElementById("searchTxt");
		location.href="main.jsp?pgm=/recommendBoard/list.jsp?pageNum="+pageNum+"&searchType="+searchType.value+"&searchTxt="+searchTxt.value;
	}
</script>
</head>
<body>
	
	<p>
	<p>
	
	<table class="tab" align="center" width="70%" cellspacing="0" cellpadding="0">
		<caption><h2>추천 게시판</h2></caption>
		<tr height="30">
			<th width="3%"></th>
			<th width="10%">말머리</th>
			<th width="31%">제목</th>
			<th width="8%">글쓴이</th>
			<th width="8%">작성일</th>
			<th width="4%">조회</th>
			<th width="4%">추천</th>
		</tr>
<%
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();

		String pageNum = request.getParameter("pageNum");
		if (pageNum == null || pageNum.equals("null") || pageNum.equals(""))
			pageNum = "1";
		
		String searchType = request.getParameter("searchType");
		String searchTxt = request.getParameter("searchTxt");
		if(searchType == null || searchType.equals("null") || searchType.equals("")){
			searchType = "all";
		}
		if(searchTxt == null || searchTxt.equals("null")){
			searchTxt = "";
		}
		
		int rowPerPage = 15;
		int pagePerBlock = 10;
		int nowPage = Integer.parseInt(pageNum);
		int total = jrbd.selectTotal(searchType, searchTxt);
		int totalPage = (int) Math.ceil((double)total/rowPerPage);
		int startRow = (nowPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int totalBlk = (int) Math.ceil((double)totalPage/pagePerBlock);
		int startPage = (nowPage - 1) / 10 * 10 + 1;
		int endPage = startPage + pagePerBlock - 1;
		if (endPage > totalPage)
			endPage = totalPage;
		total = total - startRow + 1;
		
		List<J_RecommendBoard> list = jrbd.selectList(startRow, endRow, searchType, searchTxt);
		if (list.size() != 0) {
			for (J_RecommendBoard jrb : list) {
%>
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td class="default"><%=total--%></td>
				<td class="default">
					<%if(jrb.getRc_value().equals("말머리 없음")) { %>
					<font class="category"> </font>
					<% } else { %>			
					<font class="category"> [<%=jrb.getRc_value()%>] </font>
					<% } %>
				</td>
				<td class="subject">
<%
					if (jrb.getRe_level() > 0) {
						int w = jrb.getRe_level() * 10;
%>
					<img alt="" src="../images/level.gif" width="<%=w%>" height="10">
					<img alt="" src="../images/re.gif">
<%
 					}
%>
					<a href="../module/main.jsp?pgm=/recommendBoard/view.jsp?brd_no=<%=jrb.getBrd_no()%>&pageNum=<%=nowPage%>"><%=jrb.getBrd_subject()%></a>
<%
					if (jrb.getBrd_readcount() > 20)
						out.println("<img src='../images/hot.gif'>");
%>
				</td>
				<td class="nickname"><%=jrb.getM_nick()%></td>
				<td class="default"><%=jrb.getBrd_reg_date()%></td>
				<td class="default"><%=jrb.getBrd_readcount()%></td>
				<td class="default"><%=jrb.getRecocount()%></td>
			</tr>
			<tr height="1" bgcolor="#e2e2e2"><td colspan="7"></td></tr>
<%
			}
		} else {
%>
			<tr height="1" bgcolor="#e2e2e2"><td colspan="7"></td></tr>
			<tr height="30" onMouseOver="this.style.backgroundColor='#E7E7E7'" onmouseout="this.style.backgroundColor=''">
				<td colspan="7" class="default">데이터가 없습니다</td>
			</tr>
<%
		}
%>
	</table>
	
	<br>
		
	<div class="list">
<%
		if (startPage > pagePerBlock) {
%>
			<a href="javascript:locate(<%=startPage - pagePerBlock%>)">[이전] </a>
			<a href="javascript:locate(1)">[1]</a>				
			...
<%
		}
		for (int i = startPage; i <= endPage; i++) {
			if(i==nowPage){
%>
				<b class="b">[<%=i%>]</b>
<%
			} else {
%>
				<a href="javascript:locate(<%=i%>)">[<%=i%>]</a>
<%
			}
		}
		if (totalPage > endPage) {
%>
			...
			<a href="javascript:locate(<%=totalPage%>)">[<%=totalPage%>]</a>
			<a href="javascript:locate(<%=startPage + pagePerBlock%>)">[다음]</a>
<%
		}
%>
		<p>
		<button onclick="location.href='../module/main.jsp?pgm=/recommendBoard/writeForm.jsp?pageNum=<%=pageNum%>'">글쓰기</button>
		
		<p>
		<select id="searchType">
			<option value="all" 
			<%
				if(searchType.equals("all")){
			%>
				selected="selected"
			<%
				}
			%>
			>제목+내용</option>
			<option value="brd_subject" 
			<%
				if(searchType.equals("brd_subject")){
			%>
				selected="selected"
			<%
				}
			%>
			>제목</option>
			<option value="brd_content" 
			<%
				if(searchType.equals("brd_content")){
			%>
				selected="selected"
			<%
				}
			%>
			>내용</option>
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
