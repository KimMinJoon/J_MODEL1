<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String admin = (String) session.getAttribute("m_no");
	if (admin == null || admin.equals("") || admin.equals("null") || !admin.equals("1")) {
%>
<script type="text/javascript">
	alert("관리자만 이용할 수 있는 페이지입니다.");
	location.href = "../module/main.jsp?pgm=/member/login.jsp";
</script>
<%
	}
%>
