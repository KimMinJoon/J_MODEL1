<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String m_no = (String)session.getAttribute("m_no");
	if(m_no == null || m_no.equals("") || m_no.equals("null")){
%>
		<script type="text/javascript">
			alert("로그인을 하셔야 이용할 수 있는 페이지입니다.");		
			location.href="../module/main.jsp?pgm=/member/login.jsp";
		</script> 
<%
	}
%>

