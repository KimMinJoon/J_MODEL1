<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="j_meetboard.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	function chk() {
		alert("회원가입 후 사용하실 수 있습니다.")
	}
$(function() {
	$('#btnLike').click(function(){
		$.ajax({
			type : "POST",
			url : "../meetBoard/recommendchk.jsp",
			data : {
				"brd_no" : $('#like_brd_no').val()
			},
			success : function(data){
				alert($.trim(data));
				if ($.trim(data) == "TRUE") {
					$('#btnLike').text("좋아요");
				} else if($.trim(data) == "FALSE"){
					$('#btnLike').text("좋아요 취소");
				}
			} 
		});
	});
});

</script>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
</head>
<body>
<%
	String m_no = (String)session.getAttribute("m_no");
	int brd_no = Integer.parseInt(request.getParameter("brd_no"));
	String pageNum = request.getParameter("pageNum");
	J_MeetBoardDao bd = J_MeetBoardDao.getInstance();
	J_MeetBoard brd = bd.select(brd_no);
	
	System.out.println("추천수 가져올때 값 : " + brd.getBrd_recommend());
	int recommend = 0;
	
	if ( m_no != null){
	recommend = bd.selectRecommend(Integer.parseInt(m_no), brd_no);
	}
	
	if (brd != null) {
		bd.updateHit(brd_no);
%>
	<table border="1" width="80%"><caption>게시판 상세내용</caption>
	
		<tr>
			<th>제목</th><td><%=brd.getBrd_subject() %></td>
		</tr>
		<tr>
			<th>닉네임</th><td><%=brd.getM_nick() %></td>
		</tr>
		
		<tr>
			<th>말머리</th><td><%=brd.getC_value_cate() %></td>
		</tr>
		
		<tr>
			<th>조회수</th><td><%=brd.getBrd_readcount() %></td>
		</tr>
		
		<tr>
			<th>추천수</th><td><%=brd.getBrd_recommend() %></td>
		</tr>
		
		<tr>
			<th>희망언어</th><td><%=brd.getC_value_lang() %></td>
		</tr>
		
		
		<%-- <tr>
			<th>IP</th><td><%=brd.getBrd_ip() %></td>
		</tr> --%>
		
		
		
		<%
			if (brd.getBrd_update_date()!=null){
		%>
		<tr>
			<th>작성일</th><td><%=brd.getBrd_reg_date() %></td>
		</tr>
		
		<tr>
			<th>최근수정일</th><td><%=brd.getBrd_update_date() %></td>
		</tr>
		<%
			} else {
		%>
		<tr>
			<th>작성일</th><td><%=brd.getBrd_reg_date() %></td>
		</tr>
		<%
			}
		%>
		
		<tr>
			<th>내용</th><td><pre><%=brd.getBrd_content() %></pre></td>
			<!-- pre는 입력한 내용을 잇는 그래도 보여줌  -->
		</tr>
</table>
<%
	} else {
%>
	데이터가 없습니다. 
<%		
	}
%>

<div align="center">
<%
	if(m_no!=null){
%>
	<button id="btnLike">
	<%
		if(recommend > 0){
	%>
		좋아요 취소
	<%
		}else{
	%>
		좋아요
	<%
		}
	%>
<%
	} else {
%>
	<button id="disableBtnLike" onclick="chk()">좋아요</button>
<%
	}
%>
	</button>
	<input type="hidden" id="like_brd_no" value="<%=brd_no%>">
</div>

<div align="center">
	<button onclick="location.href='../module/main.jsp?pgm=/meetBoard/list.jsp?pageNum=<%=pageNum%>'">게시판 목록</button>
	<%
		if (m_no != null) {
		 	if (Integer.parseInt(m_no) == brd.getM_no()){
	%>
	<button onclick="location.href='../module/main.jsp?pgm=/meetBoard/updateForm.jsp?brd_no=<%=brd_no %>&pageNum=<%=pageNum%>'">수정하기</button>
	<!-- 이렇게해야 수정을 누르면 수정클릭한 해당 페이지로 보내준다. -->
	
	<button onclick="location.href='../module/main.jsp?pgm=/meetBoard/deleteForm.jsp?brd_no=<%=brd_no %>&pageNum=<%=pageNum%>'">삭제하기</button>
	<%
			}
		}
	%>
	<%-- <button onclick="location.href='writeForm.jsp?brd_no=<%=brd_no %>&pageNum=<%=pageNum%>'">답변</button> --%>
</div>

</body>
</html>