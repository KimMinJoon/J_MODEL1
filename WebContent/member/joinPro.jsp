<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_member.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:useBean id="mb" class="j_member.J_Member"></jsp:useBean>
	<jsp:setProperty property="*" name="mb" />
	<%
		J_MemberDao jmd = J_MemberDao.getInstance();
		int result = jmd.insert(mb);
		if (result > 0) {
	%>
	<script type="text/javascript">
		alert("회원가입 완료");
		location.href = "../module/main.jsp?pgm=/member/login.jsp";
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("회원가입 실패");
		history.go(-1);
	</script>
	<%
		}
	%>
</body>
</html>