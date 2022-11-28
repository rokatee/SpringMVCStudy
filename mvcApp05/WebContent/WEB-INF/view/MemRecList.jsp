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
<title>MemRecList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
</head>
<body>
<!---------------------------------------------------------------------------------
	#38. MemRecList.jsp
	- 성적 리스트 출력 페이지
	- 일반 학생이 접근하는 성적 데이터 출력 페이지
----------------------------------------------------------------------------------->
<div>
	
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="MemberMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1>[성적 정보] > [성적 리스트]</h1>
		<hr />
		
		<!-------------------
			KOR ENG MAT ID 
		-------------------->
		
		<table id="customers" class="table">
			<tr>
				<!-- 항목 5EA -->
				<th>국어점수</th>
				<th>영어점수</th>
				<th>수학점수</th>
				<th>아이디</th>
			</tr>
			<!-- 
			<tr>
				<td>90</td>
				<td>80</td>
				<td>70</td>
				<td>superman</td>
			</tr>
			-->
			<c:forEach var="member" items="${memberRecord }">
				<tr>
					<td>${member.kor }</td>
					<td>${member.eng }</td>
					<td>${member.mat }</td>
					<td>${member.id }</td>
				</tr>
			</c:forEach>
		</table>
		
	</div>
	
	<!-- 회사 소개 및 어플리케이션 소개 -->
	<div id="footer"></div>

</div>


</body>
</html>