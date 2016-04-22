<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*,j_code.*"%>
<%@ page import="java.util.List"%>
<%@ include file="../session/sessionChk.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>
	<%
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		J_RecommendBoard jrb = jrbd.select(brd_no);
		J_CodeDao jcd = J_CodeDao.getInstance();
		List<J_Code> list = jcd.selectList();
	%>

	<form action="../recommendBoard/updatePro.jsp" method="post">
		<input type="hidden" name="brd_no" value="<%=jrb.getBrd_no()%>">
		<input type="hidden" name="pageNum" value="<%=pageNum%>">
		<table class="tab" cellpadding="10" align="center" width="50%">
			<caption><h2>게시판 수정</h2></caption>
			<tr>
				<td class="join1">제목</td>
				<td><input type="text" name="brd_subject" required="required" autofocus="autofocus" value="<%=jrb.getBrd_subject()%>"></td>
			</tr>
			<tr height="50">
				<td class="join1">말머리</td>
				<td><select name="rc_code">
						<option value="<%=jrb.getRc_code()%>" selected="selected"> <%=jrb.getRc_value()%></option>
						<%
							for (J_Code jmc : list) {
								if (jmc.getC_major().equals("rc")) {
						%>
									<option value=<%=jmc.getC_minor()%>>
										<%=jmc.getC_value()%>
									</option>
						<%
								}
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td class="join1">내용</td>
				<td><textarea rows="5" cols="50" name="brd_content" required="required"><%=jrb.getBrd_content()%></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="확인">
					<input type="button" value="취소" onclick="history.back(-1)"></td>
			</tr>
		</table>
	</form>
</body>
</html>