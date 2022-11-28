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
<title>MemList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
</head>
<body>
<!---------------------------------------------------------------------------------
	#36. MemberList.jsp
	- 학생 리스트 출력 페이지
	- 일반 회원이 접근하는 학생 데이터 출력 페이지
----------------------------------------------------------------------------------->
<div>
	
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="MemberMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1>[학생 정보] > [학생 리스트]</h1>
		<hr />
		
		<!-------------------------
			ID NAME TEL EMAIL 
		-------------------------->
		
		<table id="customers" class="table">
			<tr>
				<!-- 항목 5EA -->
				<th>아이디</th>
				<th>이름</th>
				<th>전화번호</th>
				<th>이메일</th>
			</tr>
			<!-- 
			<tr>
				<td>superman</td>
				<td>김태민</td>
				<td>010-1111-1111</td>
				<td>ktm@test.com</td>
			</tr>
			-->
			<c:forEach var="member" items="${memberList }">
				<tr>
					<td>${member.id }</td>
					<td>${member.name }</td>
					<td>${member.tel }</td>
					<td>${member.email }</td>
				</tr>
			</c:forEach>
			
		</table>
		
	</div>
	
	
	
	<!-- 회사 소개 및 어플리케이션 소개 -->
	<div id="footer"></div>

</div>


</body>
</html>