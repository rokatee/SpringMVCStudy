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
		
		<!-- ID, NAME, TEL, EMAIL, GRADE, DELCHECK -->
		
		<table id="members" class="table">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
				<th>등급</th>
			</tr>
			<c:forEach var="member" items="${memberList }">
				<tr id="td">
					<td>${member.id }</td>
					<td>${member.name }</td>
					<td>${member.tel }</td>
					<td>${member.email }</td>
					<td>${member.grade==0 ? "관리자" : "학생" }</td>
				</tr>
			</c:forEach>
		</table>
		
	</div>
	
</div>

</body>
</html>