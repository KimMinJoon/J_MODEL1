<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*,j_code.*"%>
    <%@ include file="../session/sessionChk.jsp"  %>
<!DOCTYPE ><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WriteForm</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
<%
	//String m_no = "1";	
	String pageNum = request.getParameter("pageNum");
%>

<%
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList();
		//String m_no = (String)session.getAttribute("m_no");
		// 로그인없이 게시글 접근 시 막기 
%>

</head>
<body>
<form action="../meetBoard/write.jsp" method="post">
<input type="hidden" name="pageNum" value="<%=pageNum%>">
<input type="hidden" name="m_no" value="<%=m_no%>">
 
<table class="tab"><caption>게시판 작성</caption>
	<tr>
		<td class="join1">제목</td><td><input type="text" name="brd_subject" required="required" autofocus="autofocus"></td>
	</tr>
	
	<tr height="50">
				<td class="join1">말머리</td>
				<td>
					<select name="mc_code">
						<option value="0">해당없음</option>
						<%
							for (J_Code jmc : list) {
								if (jmc.getC_major().equals("mc")) {
						%>
						<option value=<%=jmc.getC_minor()%>>
							<%=jmc.getC_value()%>
						</option>
						<%
							}
						}
						%>
					</select>
				</td>
			</tr>
			
	<tr height="50">
				<td class="join1">희망언어</td>
				<td>
					<select name="l_code">
						<option value="0">해당없음</option>
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("l")) {
						%>
						<option value="<%=jc.getC_minor()%>">
							<%=jc.getC_value()%>
						</option>
						<%
							}
						}
						%>
					</select>
				</td>
			</tr>
	<tr>
		<td class="join1">내용</td><td><textarea rows="5" cols="50" name="brd_content" required="required"></textarea></td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="확인">
			<input type="reset"  value="취소">
		</td>
	</tr>
</table>
</form>
</body>
</html>