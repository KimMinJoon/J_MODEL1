<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_recommendboard.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<%
		String m_no = (String) session.getAttribute("m_no");
		int brd_no = Integer.parseInt(request.getParameter("brd_no"));
		String pageNum = request.getParameter("pageNum");
		J_RecommendBoardDao jrbd = J_RecommendBoardDao.getInstance();
		J_RecommendBoard jrb = jrbd.select(brd_no);
		jrbd.updateHit(brd_no);
		int recommend = jrbd.selectRecommend(m_no, brd_no);
	%>
	
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../projectcss.css">
<script language="javascript">
function pwdpopup(){
	var purl = "../recommendBoard/deleteForm.jsp?brd_no="+<%=brd_no%>+"&pageNum="+<%=pageNum%>;
	var pname = "pwdpopup";
	var pwidth = 250;
	var pheight = 100;
	var pleft = (screen.availWidth-pwidth)/2;
	var ptop = (screen.availHeight-pheight)/2;
	var poption = "scrollbars=no,status=no,toolbar=no,resizable=0,location=no,menu=no," +
	                "width=" + pwidth + ",height=" + pheight + ",left=" + pleft + ",top=" + ptop;
	window.open(purl, pname, poption);
}

function chk() {
	alert("로그인 후 사용하실 수 있습니다.");
}
</script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
$(function() {
	$('#btnLike').click(function(){
		$.ajax({
			type : "POST",
			url : "../recommendBoard/recommendChk.jsp",
			data : {
				"brd_no" : $('#like_brd_no').val()
			},
			success : function(data){
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
</head>
<body>
	
	<table border="1" width="70%" align="center">
		<caption><h2>게시글 보기</h2></caption>
		<tr>
			<td>제목</td>
			<td><%=jrb.getBrd_subject()%></td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><%=jrb.getM_nick()%></td>
		</tr>

		<tr>
			<td>말머리</td>
			<td><%=jrb.getRc_value()%></td>
		</tr>

		<tr>
			<td>조회수</td>
			<td><%=jrb.getBrd_readcount()%></td>
		</tr>

		<tr>
			<td>추천수</td>
			<td><%=jrb.getRecocount()%></td>
		</tr>

		<tr>
			<td>IP</td>
			<td><%=jrb.getBrd_ip()%></td>
		</tr>

		<%
			if (jrb.getBrd_update_date() != null) {
		%>
		<tr>
			<td>작성일</td>
			<td><%=jrb.getBrd_reg_date()%></td>
		</tr>
		<tr>
			<td>최근수정일</td>
			<td><%=jrb.getBrd_update_date()%></td>
		</tr>
		<%
			} else {
		%>
		<tr>
			<td>작성일</td>
			<td><%=jrb.getBrd_reg_date()%></td>
		</tr>
		<%
			}
		%>

		<tr>
			<td>내용</td>
			<td><pre><%=jrb.getBrd_content()%></pre></td>
		</tr>
	</table>
	
	<p>
	
	<div align="center">
	<%
		if (m_no != null) {
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
			</button>
	<%
		} else {
		%>
			<button id="disableBtnLike" onclick="chk()">좋아요</button>
	<%
		}
	%>
		<input type="hidden" id="like_brd_no" value="<%=brd_no%>">
	</div>

	<p>
	
	<div align="center">
		<button
			onclick="location.href='../module/main.jsp?pgm=/recommendBoard/list.jsp?pageNum=<%=pageNum%>'">목록</button>
		<%
			if (m_no != null) {
				if (Integer.parseInt(m_no) == jrb.getM_no()) {
		%>
		<button
			onclick="location.href='../module/main.jsp?pgm=/recommendBoard/updateForm.jsp?brd_no=<%=brd_no%>&pageNum=<%=pageNum%>'">수정</button>
		<button
			onclick="pwdpopup()">삭제</button>
		<%
			}
		%>
		<button
			onclick="location.href='../module/main.jsp?pgm=/recommendBoard/writeForm.jsp?brd_no=<%=brd_no%>&pageNum=<%=pageNum%>'">답변</button>
		<%
		}
		%>
	</div>

</body>
</html>