<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*,j_code.*"%>
<%@ include file="../session/sessionChk.jsp"  %>
<!DOCTYPE html>
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="comm.css">
</head>
<body>

<%
	int brd_no = Integer.parseInt(request.getParameter("brd_no"));
	String pageNum = request.getParameter("pageNum");
	J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
	J_MeetBoard meetboard = bd.select(brd_no);
	J_CodeDao jcd = J_CodeDao.getInstance();
	List<J_Code> list = jcd.selectList();
	// 로그인없이 게시글 접근 시 막기 
%>

<form action="../meetBoard/updatePro.jsp" method="post">
	<input type="hidden" name="brd_no" value="<%=meetboard.getBrd_no() %>">
	<input type="hidden" name="pageNum" value="<%=pageNum %>">
<table border="1"><caption>게시판 수정</caption>

<tr>
		<td class="join1">제목</td><td><input type="text" name="brd_subject" required="required" autofocus="autofocus" value="<%=meetboard.getBrd_subject()%>"></td>
	</tr>
	<tr height="50">
				<td class="join1">말머리</td>
				<td>
					<select name="mc_code">
						<option value="<%=meetboard.getMc_code()%>" selected="selected"> <%=meetboard.getC_value_cate()%></option>
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
						<option value="<%=meetboard.getL_code()%>" selected="selected"><%=meetboard.getC_value_lang()%></option>
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("l")) {
						%>
						<option value=<%=jc.getC_minor()%>>
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
		<td class="join1">내용</td><td><textarea rows="5" cols="50" name="brd_content" required="required"><%=meetboard.getBrd_content()%></textarea></td>
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