<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="j_member.*, j_code.*, java.util.*" %>
<%@ include file="../session/sessionChk.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.js"></script>
<script type="text/javascript">
	function chk() {
		if(frm.m_passwd.value != frm.m_passwd2.value) {
			alert("비밀번호를 다시 입력하세요");
			frm.m_passwd.value = "";
			frm.m_passwd2.value = "";
			frm.m_passwd.focus();
			return false;
		}
		if(frm.m_passwd.value.length < 6) {
			alert("비밀번호는 6~20자로 입력해주세요");
			frm.m_passwd.value = "";
			frm.m_passwd2.value = "";
			frm.m_passwd.focus();
			return false;
		}
		if(frm.m_passwd.value.indexOf(" ")>=0) {
			alert("비밀번호는 공백없이 입력해 주세요.");
			frm.m_passwd.value = "";
			frm.m_passwd2.value = "";
			frm.m_passwd.focus();
			return false;
	    }
		if(frm.m_nick.value.length < 2) {
			alert("닉네임은 2~10자로 입력해주세요");
			frm.m_nick.value = "";
			frm.m_nick.focus();
			return false;
		}
		if(frm.m_nick.value.indexOf(" ")>=0) {
			alert("닉네임은 공백없이 입력해 주세요.");
			frm.m_nick.value = "";
			frm.m_nick.focus();
			return false;
	    }
		var regex = /^[가-힝A-Za-z0-9]{2,10}$/;
		if (regex.test(frm.m_nick.value) === false) {
			alert("닉네임이 한글 또는 영문 또는 숫자가 아닙니다. ");
			frm.m_nick.value = "";
			frm.m_nick.focus();
			return false;
		}
		return true;
	}
	
	$(function() {
		$('#m_nick').blur(function() {
			var regex = /^[가-힝A-Za-z0-9]{2,10}$/;
			var str_space = /\s/;
			if (regex.test($('#m_nick').val()) === false) {
				$('#check').html("<font>한글,영문,숫자 2~10자</font>");
				if($("#m_nick").val().length < 2) {
					$('#check').html("<font>2~10자로 입력</font>");
				}
				if(str_space.test($('#m_nick').val())) {
					$('#check').html("<font class=red>공백 불가능</font>");
				}
			}else {
			$.ajax({
				type : "POST",
				url : "../member/nickChk.jsp",
				data : {
					"m_nick" : $('#m_nick').val(),
					"m_no" : $('#m_no').val()
				},
				success : function(data) {
					if ($.trim(data) == "FALSE") {
						$('#check').html("<font>사용가능</font>");
					} else if($.trim(data) == "TRUE"){
						$('#check').html("<font class=red>사용불가</font>");
					} else {
						$('#check').html("<font></font>");
					}						
				}
			});
			}
		});
	});
</script>
</head>
<body>

<%
	J_CodeDao jcd = J_CodeDao.getInstance();
	List<J_Code> list = jcd.selectList();
	J_MemberDao mdo = J_MemberDao.getInstance();
	J_Member mb = mdo.select(m_no);
%>
	
	<form action="../member/mbupdatePro.jsp" name="frm" onsubmit="return chk()">
		<input type="hidden" name="check" value="false">
		<input type="hidden" name="m_no" id="m_no" value="<%=m_no%>">
		<table class="tab" cellpadding="10" align="center">
			<caption>
				<h2>회원정보수정</h2>
			</caption>
			<tr height="50">
				<td class="join1"><font class="red">*</font>이메일</td>
				<td><input type="hidden" name="m_email"
					value="<%=mb.getM_email()%>"> <label><%=mb.getM_email()%></label></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>비밀번호</td>
				<td><input type="password" name="m_passwd" id="m_passwd" 
					value="<%=mb.getM_passwd()%>" required="required" maxlength="20">
				<span id="pass"></span>
				</td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>비밀번호 확인</td>
				<td><input type="password" name="m_passwd2" required="required" maxlength="20"></td>
			</tr>
			<tr height="50">
				<td class="join1"><font class="red">*</font>닉네임</td>
				<td><input type="text" name="m_nick" id="m_nick"
					value="<%=mb.getM_nick()%>" required="required" maxlength="10">
					<span id="check"></span>
				</td>
			</tr>
			<tr height="50">
				<td class="join1">국적</td>
				<td><select name="c_code">
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("c")) {
						%>
						<option value=<%=jc.getC_minor()%>
							<%if (jc.getC_minor().equals(mb.getC_code())) {%>
							selected="selected" <%}%>>
							<%=jc.getC_value()%>
						</option>
						<%
							}
						}
						%>
				</select></td>
			</tr>
			<tr height="50">
				<td class="join1">희망언어</td>
				<td><select name="l_code">
						<%
							for (J_Code jc : list) {
								if (jc.getC_major().equals("l")) {
						%>
						<option value=<%=jc.getC_minor()%>
							<%if (jc.getC_minor().equals(mb.getL_code())) {%>
							selected="selected" <%}%>>
							<%=jc.getC_value()%>
						</option>
						<%
							}
						}
						%>
				</select></td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit" value="수정">
					&nbsp; <input type="button" value="취소" onclick="location.href='../module/main.jsp?pgm=/member/mypagetemp.jsp'">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>