<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_member.*" %>

<%
	request.setCharacterEncoding("UTF-8");

	String m_nick = request.getParameter("m_nick");
	String m_no = request.getParameter("m_no");
	String str = "";
	J_MemberDao jmd = J_MemberDao.getInstance();
	int result = jmd.nickCheck(m_nick, m_no);
	if(result > 0) {
		str = "TRUE";
	}else if(result == 0){
		str = "EQUAL";
	}else {
		str = "FALSE";
	}
	out.print(str);
%>