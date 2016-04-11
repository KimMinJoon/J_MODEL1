<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ include file="../session/sessionChk.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<%
		String mypgm = request.getParameter("mypgm");
		if (mypgm == null || mypgm == "") {
			mypgm = "myinfo.jsp";
		}
	%>

	<table align="center" width="100%">
		<tr>
			<td width="20%" height="50"><jsp:include page="mypage.jsp" /></td>
			<td width="80%" class="mypagetemp"><jsp:include page="<%=mypgm%>" /></td>
		</tr>
	</table>

</body>
</html>