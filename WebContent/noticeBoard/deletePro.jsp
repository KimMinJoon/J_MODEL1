<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_noticeboard.*"%>
	<%@ include file="../session/adminChk.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String pageNum = request.getParameter("pageNum");
	int brd_no = Integer.parseInt(request.getParameter("brd_no"));
	J_NoticeBoardDao bd = J_NoticeBoardDao.getInstance();
	int result = bd.delete(brd_no);
	if (result > 0) {
%>
<script type="text/javascript">
	alert("삭제성공");
	location.href="../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=<%=pageNum%>";
	
</script>
<%
	} else {
%>
<script type="text/javascript">
	alert("삭제실패...");
	history.go(-1);
</script>
<%
	}
%>

</body>
</html>