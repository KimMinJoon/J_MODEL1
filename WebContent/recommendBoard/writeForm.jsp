<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_code.*, j_recommendboard.*" %>
<%@ page import="java.util.List" %>
<%@ include file="../session/sessionChk.jsp" %>

<%
	String pageNum = request.getParameter("pageNum");

	int brd_no = 0, ref = 0, re_step = 0, re_level = 0;
	if (request.getParameter("brd_no") != null) {
		brd_no = Integer.parseInt(request.getParameter("brd_no"));
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		J_RecommendBoard jdb = jrbd.select(brd_no);
		ref = jdb.getRef();
		re_step = jdb.getRe_step();
		re_level = jdb.getRe_level();
	}

	J_CodeDao jcd = J_CodeDao.getInstance();
	List<J_Code> list = jcd.selectList();
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>WriteForm</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>

	<form action="../recommendBoard/writePro.jsp" method="post">
		<input type="hidden" name="brd_no" value="<%=brd_no%>">
		<input type="hidden" name="ref" value="<%=ref%>">
		<input type="hidden" name="re_step" value="<%=re_step%>">
		<input type="hidden" name="re_level" value="<%=re_level%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<input type="hidden" name="m_no" value="<%=m_no%>">

		<table class="tab" cellpadding="10" align="center" width="50%">
			<caption><h2>게시판 작성</h2></caption>
			<tr>
				<td class="inputleft">
				<select name="rc_code">
					<%
						for (J_Code jc : list) {
							if (jc.getC_major().equals("rc")) {
					%>
						<option value=<%=jc.getC_minor()%>>
							<%=jc.getC_value()%>
						</option>
					<%
							}
						}
					%>
				</select></td>
			</tr>
			<tr>
				<td class="inputleft"> <input type="text" name="brd_subject" required="required" autofocus="autofocus" size="50" placeholder="제목을 입력해 주세요"></td>
			</tr>
			<tr>
				<td><textarea rows="20" cols="90" name="brd_content" required="required"></textarea></td>
			</tr>
			<tr>
				<td align="center"><input type="submit" value="확인"> &nbsp;
				<input type="button" value="취소" onclick="history.back(-1)"></td>
			</tr>
		</table>
	</form>
	
</body>
</html>