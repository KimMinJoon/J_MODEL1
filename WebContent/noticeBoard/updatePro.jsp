<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../session/adminChk.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${result > 0}">
		<script type="text/javascript">
			location.href = "../module/main.jsp?pgm=/noticeBoard/noticeMenuTemp.jsp?nbpgm=/noticeBoard/list.jsp?pageNum=${pageNum}";
		</script>
	</c:if>
	<c:if test="${result <= 0}">
		<script type="text/javascript">
			alert("수정 실패");
			history.go(-1);
		</script>
	</c:if>
</body>
</html>