<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<style type="text/css">
	* { line-height: 150%; }
	#customers td { text-align: center; }
	
	#submitBtn 
	{
		height: 150%;
		width: 280px;
		font-size: 18px;
		font-weight: bold;
		font-family: 맑은 고딕;
	}
	
	#error 
	{
		color: red;
		font-size: small;
		display: none;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function()
	{
		$("#submitBtn").click(function()
		{
			// 테스트
			//alert("확인");
			
			// 원래 항상 입력칸이 비워져있을 경우에 아래 구문 작성했었는데
			// 두 항목(이름, 번호) 모두 필수 입력 항목이기 때문에
			// 여기서는 아래 구문 생략 가능
			$("#error").css("display", "none");
			
			if ($("#name").val()=="" || $("#telephone").val()=="")
			{
				$("#error").css("display", "inline");
				return;
			}
			
			$("#memberForm").submit();
		});
	});
</script>
</head>
<body>

<div>
	<h1>회원 관리(MemberList.jsp)</h1>
	<hr />
</div>

<div>
		<form action="memberinsert.action" method="post" id="memberForm">
			이름 <input type="text" name="name" id="name" class="control txt" required="required"/><br />
			전화 <input type="text" name="telephone" id="telephone" class="control txt" required="required"/><br />
			
			<button type="button" id="submitBtn" class="btn">회원 추가</button>
			<span id="error">모든 항목을 입력해야 합니다.</span>
		</form>
		<br /><br />
		
		<!-- EL 표현에 의한 인원 수 출력 부분 -->
		<!-- <p>전체 인원 수 : 5명</p> -->
		<p>전체 인원 수 : ${count }</p>
		
		<table id="customers" class="table" style="width: 500px;">
		<tr>
			<th>번호</th><th>이름</th><th>전화번호</th>
		</tr>
		
		<%-- EL, JSTL 표현에 의한 회원 명단 출력 부분 --%>
		<!-- 
		<tr>
			<td>1</td>
			<td>민찬우</td>
			<td>010-1111-1111</td>
		</tr>
		<tr>
			<td>2</td>
			<td>김태민</td>
			<td>010-2222-2222</td>
		</tr>
		-->
		<c:forEach var="member" items="${memberList }">
		<tr>
			<%-- MemberDTO 객체의 getMid(), getName, getTelephone() 메소드를 호출하는 EL 표현 --%>
			<td>${member.mid }</td>
			<td>${member.name }</td>
			<td>${member.telephone }</td>
		</tr>
		</c:forEach>
	</table>
		
		
	</div>

</body>
</html>