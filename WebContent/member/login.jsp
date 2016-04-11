<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/projectcss.css">
</head>
<body>
	<form action="../member/loginPro.jsp" name="frm">
		<table class="tab" cellpadding="10" align="center">
			<caption>
				<h2>로그인</h2>
			</caption>
			<tr>
				<td><input type="text" name="m_email" placeholder="이메일" required="required"></td>
			</tr>
			<tr>
				<td><input type="password" name="m_passwd" placeholder="비밀번호" required="required"></td>
			</tr>
			<tr>
				<td align="center"><input type="submit" value="확인"></td>
			</tr>
		</table>
	</form>

	<p>
	<div align="center">
		<a href="main.jsp?pgm=/member/join.jsp">
		<font style="text-decoration: underline;" size="2"> 회원가입 </font>
		</a>
	</div>

</body>
</html>