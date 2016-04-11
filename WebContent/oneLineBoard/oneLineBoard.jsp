<%@page import="j_onelineboard.J_OneLineReply"%>
<%@page import="j_onelineboard.J_OneLineBoardDAO"%>
<%@page import="j_onelineboard.J_OneLineBoard"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.wrap {
	width: 70%;
	position: relative;
	display: inline-block;
}

.wrap textarea {
	width: 80%;
	resize: none;
	min-height: 4.5em;
	line-height: 1.6em;
	max-height: 9em;
	vertical-align: top;
}

.wrap span {
	position: absolute;
	bottom: 5px;
	right: 5px;
}

#update{
	position : relative;
}

#counter {
	background: rgba(255, 0, 0, 0.5);
	border-radius: 0.5em;
	padding: 0 .5em 0 .5em;
	font-size: 0.75em;
}
</style>
<%	
		String mno = (String)session.getAttribute("m_no");
		
		String searchType = request.getParameter("searchType");
		String searchTxt = request.getParameter("searchTxt");
		
		if(searchType == null || searchType.equals("null") || searchType.equals("")){
			searchType = "brd_content";
		}
		
		if(searchTxt == null || searchTxt.equals("null")){
			searchTxt = "";
		}
		
		int rowPerPage = 10;
		int pagePerBlock = 10;
		int nowPage = 0;
		String pageNum = request.getParameter("pageNum");

		if (pageNum == null || pageNum.equals("") || pageNum.equals("null")) {
			pageNum = "1";
		}
		nowPage = Integer.parseInt(pageNum);

		J_OneLineBoardDAO jobd = J_OneLineBoardDAO.getInstance();
		int total = jobd.selectTotal(searchType, searchTxt);

		int totalPage = (int) Math.ceil((double) total / rowPerPage);
		int startRow = (nowPage - 1) * rowPerPage + 1;
		int endRow = startRow + rowPerPage - 1;
		int totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
		int startPage = (nowPage - 1) / 10 * 10 + 1;
		int endPage = startPage + pagePerBlock - 1;
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		total = total - startRow + 1;

		List<J_OneLineBoard> list = jobd.selectOneLine(startRow, endRow, searchType, searchTxt);
		
%>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		
		$(".updateForm").hide();
		$(".replyForm").hide();
		
		$(".btnUpdate").click(function(){
			$(this).parent().nextAll(".row").show();
			$(this).parent().nextAll(".updateForm").hide();
			$(this).parent().prevAll(".row").show();
			$(this).parent().prevAll(".updateForm").hide();
			$(this).parent().hide();
			var text = $(this).parent().next().find(".originText").text();
			$(this).parent().next().find(".updateContent").val(text);
			$(this).parent().next().show("slow");
		});
		
		$('.btnReply').click(function(){
			$(this).parent().next().next().show("slow");
		});
		
		
		$(".updateCancel").click(function(){
			$(this).parent().parent().hide("slow"); 
			$(this).parent().parent().prev().show("slow");	
		});
		
		$(".btnReply").click(function(){
			$(this).parent().next().next().show("slow");
		});
		
		$(".replyCancel").click(function(){
			$(this).parent().parent().hide("slow"); 
			$(this).parent().parent().prev().prev().show("slow");	
		});
	});
	
	function replyForm(id){
		var originRow = document.getElementById(id);
		var replyRow = document.getElementById("r" + id);
		originRow.style.display = "none";
		replyRow.style.display = "block";
	}
	
	function deleteChk(brd_no,pageNum){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href="../oneLineBoard/deleteOneline.jsp?brd_no="+brd_no+"&pageNum="+pageNum;	
		}else{
			return;
		}
	}
	
	function deleteRepChk(reply_no){
		if(confirm("정말 삭제하시겠습니까?")){
			location.href="../oneLineBoard/deleteRepOneline.jsp?reply="+reply_no;	
		}else{
			return;
		}
	}
	
	function isSubmit(number) {
		alert(number);
 		if(number == null || number == "" || number == "null"){
 			if (confirm("이 서비스는 로그인이 필요한 서비스 입니다. 로그인 하시겠습니까?")) {
 				location.href = "../module/main.jsp?pgm=/member/login.jsp";
 			} else {
 				return false;
 			}
 		}else{
 			return true;
 		}
 		return false;	
	}
	
	function textCheck() {
		var counter = document.getElementById("counter");
		var content = document.getElementById("content");
		counter.innerHTML = content.value.length + "/" + content.maxLength;
		if(content.value.length >= content.maxLength){
			alert("최대 " + content.maxLength + "글자 까지 작성할수 있습니다.");
		}
	}
	
	function locate(pageNum){
		var searchType = document.getElementById("searchType");
		var searchTxt = document.getElementById("searchTxt");
		location.href="main.jsp?pgm=/oneLineBoard/oneLineBoard.jsp?pageNum=" + pageNum + "&searchType=" + searchType.value + "&searchTxt=" + searchTxt.value;
	}
</script>
</head>
<body>
	<div style="border: 1px solid; padding: 10px 10px 10px 10px;"
		class="wrap">
		<form action="../oneLineBoard/insertOneline.jsp" name="wrtierFrm" onsubmit="return isSubmit(<%=mno%>)">
			<input type="hidden" name="m_no" value="<%=mno%>">
			<textarea rows="3" cols="50" maxlength="150" id="content"
				name="brd_content" required="required" onkeyup="textCheck()"></textarea>
			<span id="counter">0/150</span> <input
				style="height: 50px; width: 120px;" type="submit" value="등록">
		</form>
	</div>
	<p>
	
	<div
		style=" border: 1px solid; padding: 10px 10px 10px 10px;"
		class="wrap">
			
		<%
				if (list != null) {
					if(list.size() > 0){
						for (int i = 0 ; i < list.size(); i++) {
							J_OneLineBoard jolb = list.get(i);
		%>
		<div class="row">
			<p><%=total--%>&nbsp;<%=jolb.getM_nick()%>&nbsp;<%=jolb.getBrd_reg_date()%>
			<pre style="width:600px; white-space: pre-line;word-break:break-all;"><%=jolb.getBrd_content()%></pre>
			<a href="javascript:replyForm(<%=i%>)">[<%=jolb.getRep_count()%>]</a>	
					<%
						if (mno != null) {
							if (jolb.getM_no() == Integer.parseInt(mno)) {
					%> 
								<input type="button" class="btnUpdate" value="수정">
								<input type="button" value="삭제" onclick="deleteChk(<%=jolb.getBrd_no()%>,<%=pageNum%>)">
					<%
		 					}
					%> 
								<input type="button" class="btnReply" value="답글">
					<%
						}
					%>
			</p>
		</div>
		<div class="updateForm">
			<form action="../oneLineBoard/updateOneline.jsp" name="updateFrm" method="post" onsubmit="return isSubmit(<%=mno%>)">
				<input type="button" class="updateCancel" value="취소">
				<input type="hidden" name="m_no" value="<%=mno%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				<input type="hidden" name="brd_no" value="<%=jolb.getBrd_no()%>">
				<p class="originText" style="display: none;"><%=jolb.getBrd_content()%></p>
				<textarea rows="3" cols="100" maxlength="150" class="updateContent"
						name="brd_content" required="required"><%=jolb.getBrd_content()%></textarea>
				<input style="height: 50px; width: 120px;" type="submit" value="등록">
			</form>
		</div>
		<div class="replyForm">
			<form action="../oneLineBoard/insertReplyOneline.jsp" name="replyFrm" onsubmit="return isSubmit(<%=mno%>)" method="post">
				<input type="hidden" name="m_no" value="<%=mno%>">
				<input type="hidden" name="brd_no" value="<%=jolb.getBrd_no()%>">
				<input type="hidden" name="pageNum" value="<%=pageNum%>">
				<input type="button" class="replyCancel" value="취소"></p>
				<textarea rows="3" cols="100" maxlength="150" class="replyContent"
					name="content" required="required"></textarea>
		 		<input style="height: 50px; width: 120px;" type="submit" value="등록">
			</form>
			<div>
				
				<%
				System.out.println(jolb.getBrd_no());
					List<J_OneLineReply> reList = jobd.selectReply(jolb.getBrd_no());
					if(reList != null){
						System.out.println(reList.size());
						for(J_OneLineReply jolr : reList){
							System.out.println(jolr);
				%>
						<div class="replyRow">
							<img src="../images/re.gif"><%=jolr.getM_nick()%><%=jolr.getReg_Date()%><%=jolr.getContent()%>
							<%
								if(mno != null){
									System.out.println("mno : " + mno + ", rep 작성자 mno : " + jolr.getM_no());
									if(Integer.parseInt(mno) == jolr.getM_no()){
							%>
									<input type="button" value="수정" id="btnRepUpdate">
									<input type="button" value="삭제" onclick="deleteRepChk(<%=jolr.getReply_no()%>)">
							<%
									}
								}
							%>
						
						</div>
						<div class="replyUpdate" style="display: none;">
							<form action="../oneLineBoard/oneLineReplyUpdate.jsp" method="post" >
								<input type="hidden" value="<%=jolr.getReply_no()%>">
								<input type="hidden" value="<%=jolr.getBrd_no()%>">
								<input type="button" id="repUpdateCancel" value="취소">
								<textarea rows="3" cols="100" maxlength="150" class="updateReContent"
									name="content" required="required"><%=jolr.getContent()%></textarea>
								<input type="submit" value="등록">
							</form>
						</div>
				<%
						}
					}
				%>
			</div>
		</div>
			<%
						}
					}else{
			%>
				<p>no data found</p>
			<%
					}
				}
			%>
		
		<div align="center" id="pagingandsearch">
			<%
				if (startPage != 1) {
			%>
			<a href="javascript:locate(1)">&lt;&lt;맨
				앞으로</a>
			<%
				}
				if (startPage > pagePerBlock) {
			%>
			<a
				href="javascript:locate(<%=startPage - pagePerBlock%>)">&lt;이전</a>
			<%
				}
			%>
			<%
				for (int i = startPage; i <= endPage; i++) {
					if (nowPage != i) {
			%>
			<a href="javascript:locate(<%=i%>)"><%=i%></a>
			<%
				} else {
			%>
			<strong>
				[<%=i%>]
			</strong>
			<%
					}
				}
				if (totalPage > endPage) {
			%>
			<a
				href="javascript:locate(<%=startPage + pagePerBlock%>)">다음&gt;</a>
			<%
				}
			%>
			<%
				if (endPage != totalPage) {
			%>
			<a
				href="javascript:locate(<%=totalPage%>)">맨
				뒤로&gt;&gt;</a>
			<%
				}
			%>
			<br>
			<select id="searchType">
				<option value="brd_content" 
				<%
					if(searchType.equals("brd_content")){
				%>
					selected="selected"
				<%
					}
				%>
				>내용</option>
				<option value="m_nick"
				<%
					if(searchType.equals("m_nick")){
				%>
					selected="selected"
				<%
					}
				%>
				>글쓴이</option>
			</select>
			<input type="text" id="searchTxt" value="<%=searchTxt%>">
			<input type="submit" value="검색" onclick="locate(1)">
		</div>
	</div>
</body>
</html>