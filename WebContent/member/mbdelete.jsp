<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ include file="../session/sessionChk.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function dechk() {
		var aa = confirm("정말로 탈퇴하시겠습니까?");
		if (aa) {
			return true;
		} else {
			return false;
		}
	}
</script>
</head>
<body>

	<form name="frm" action="../member/mbdeletePro.jsp" method="post"
		onsubmit="return dechk()">
		<table class="tab" cellpadding="10" align="center">
			<tr>
				<td class="join1">암호</td>
				<td><input type="password" name="m_passwd"></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="확인">
					&nbsp; <input type="button" value="취소" onclick="location.href='../module/main.jsp?pgm=/member/mypagetemp.jsp'"></td>
			</tr>
		</table>
	</form>

</body>
</html>