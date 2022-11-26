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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	
	$(function()
	{
		$(".updateBtn").click(function()
		{
			//alert("수정버튼클릭");
			//alert($(this).val());
			$(location).attr("href", "memberlistupdateform.action?id=" + $(this).val());
		});
		
		$(".deleteBtn").click(function()
		{
			//alert("삭제버튼클릭");
			//alert($(this).val());
			$(location).attr("href", "memberlistdelete.action?id=" + $(this).val());
		});
	});
	

</script>
</head>
<body>
<!---------------------------------------------------------------------------------
	#05. MemberList.jsp
	- 학생 리스트 출력 페이지
	- 관리자가 접근하는 학생 데이터 출력 페이지
	  (일반 학생이 접근하는 학생 데이터 출력 페이지는 MemList.jsp 로 구성 예정)
----------------------------------------------------------------------------------->
<div>
	
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="MemberMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1>[학생 관리] > [학생 리스트]</h1>
		<hr />
		
		<div>
			<form action="">
				<input type="button" value="학생 추가" class="btn btn-primary control"
				onclick="location.href='memberlistinsertform.action'"/>
			</form>
		</div>
		<br /><br />
		
		<!---------------------------------------------
		ID PW NAME TEL EMAIL GRADE 
		---------------------------------------------->
		
		<table id="customers" class="table">
			<tr>
				<!-- 항목 5EA -->
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>등급</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<!-- 
			<tr>
				<td>superman</td>
				<td>1234567</td>
				<td>김태민</td>
				<td>010-1111-1111</td>
				<td>ktm@test.com</td>
				<td>0</td>
				<td><button type="button" class="btn">수정</button></td>  
				<td><button type="button" class="btn">삭제</button></td> 
			</tr>
			-->
			<c:forEach var="member" items="${memberList }">
				<tr>
					<td>${member.id }</td>
					<td>${member.pw }</td>
					<td>${member.name }</td>
					<td>${member.tel }</td>
					<td>${member.email }</td>
					<td>${member.grade==0? "관리자" : "일반회원" }</td>
					<td>
						<button type="button" class="btn btn-primary control updateBtn"
						value="${member.id }">수정</button>
					</td>  
					<td>
						<button type="button" class="btn btn-primary control deleteBtn"
						value="${member.id }">삭제</button>
					</td> 
				</tr>
			</c:forEach>
			
		</table>
		
	</div>
	
	
	
	<!-- 회사 소개 및 어플리케이션 소개 -->
	<div id="footer"></div>

</div>


</body>
</html>