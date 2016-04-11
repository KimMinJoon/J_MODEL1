<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String m_no = (String) session.getAttribute("m_no");
	int brd_no = Integer.parseInt(request.getParameter("brd_no"));
	String str = "";
	J_RecommendBoardDao jrdb = J_RecommendBoardDao.getInstance();
	int result = jrdb.recoCheck(m_no, brd_no);
	if (result > 0) {
		str = "TRUE";
	} else
		str = "FALSE";
	out.print(str);
%>