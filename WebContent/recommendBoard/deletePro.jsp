<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*"%>
<%@ include file="../session/sessionChk.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<%
		String pageNum = request.getParameter("pageNum");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		int result = jrbd.delete(brd_no);
		if (result > 0) {
	%>
			<script language=javascript>
				self.window.alert("삭제 성공");
				opener.parent.location.href = "../module/main.jsp?pgm=/recommendBoard/list.jsp?pageNum=<%=pageNum%>";
				window.close();
			</script>
	<%
		} else {
	%>
			<script type="text/javascript">
				alert("삭제 실패");
				history.go(-1);
			</script>
	<%
		}
	%>

</body>
</html>