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
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	#content
	{
		margin: 10px 5px;
	}
	#addBtn
	{
		background: #086A87;
		color: white;
		font-weight: bold;
	}
	#addBtn:hover
	{
		background: #0B4C5F;
	}
	#td:hover
	{
		background: #F2F2F2;
	}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function()
	{
		// 멤버 추가 버튼 클릭 액션
		$("#addBtn").click(function()
		{
			$(location).attr("href", "memberinsertform.action");
		});
		
		// 수정 버튼 클릭 액션
		$(".updateBtn").click(function()
		{
			// alert("클릭 확인");
			
			$(location).attr("href", "memberupdateform.action?id=" + $(this).val());
		});
		
		// 삭제 버튼 클릭 액션
		$(".deleteBtn").click(function()
		{
			// alert("클릭 확인");
			
			$(location).attr("href", "memberdelete.action?id=" + $(this).val());
		});
		
	});
</script>

</head>
<body>

<!-- #15. MemberList.jsp -->

<div>
	
	<!-- 상단 메뉴 -->
	<div id="menu">
		<c:import url="Menu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 -->
	<div id="content">
		<div>
			<input type="button" value="신규 멤버" class="btn" id="addBtn">
		</div>
		<br>
		
		<!-- ID, NAME, TEL, EMAIL, GRADE, DELCHECK -->
		
		<table id="members" class="table">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>등급</th>
				<th>수정/삭제</th>
			</tr>
			<c:forEach var="member" items="${memberList }">
				<tr id="td">
					<td>${member.id }</td>
					<td>${member.name }</td>
					<td>${member.tel }</td>
					<td>${member.email }</td>
					<td>${member.grade==0 ? "관리자" : "학생" }</td>
					<td>
						<div class="btn-group">
							<button type="button" class="btn btn-primary btn-sm updateBtn"
							value="${member.id }">수정</button>
							<button type="button" class="btn btn-danger btn-sm deleteBtn" 
							value="${member.id }">삭제</button>
						</div>
					</td>
				</tr>
			</c:forEach>
		</table>
		
	</div>
	
</div>

</body>
</html>