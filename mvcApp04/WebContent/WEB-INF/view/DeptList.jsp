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
<title>DeptList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/mainStyle.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	#customers
	{
		width: 20%;
	}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
</head>
<body>

<!---------------------------------------------------------------------------------
	#46. DeptList.jsp
	- 부서 리스트 출력 페이지
	- 일반 직원이 접근하는 부서 리스트 출력 페이지
----------------------------------------------------------------------------------->
<div>

	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1>[부서 정보] 일반직원 전용</h1>
		<hr>
		
		<!-----------------------------------
			DEPARTMENTID DEPARTMENTNAME
		------------------------------------>
		<table id="customers" class="table">
			<tr>
				<th>번호</th>
				<th style="width: 200px;">부서명</th>
			</tr>
			<!-- 
			<tr>
				<td>1</td>
				<td>개발부</td>
			</tr>
			-->
			<c:forEach var="department" items="${departmentList }">
				<tr>
					<td>${department.departmentId }</td>
					<td>${department.departmentName }</td>
				</tr>
			</c:forEach>
			
		</table>
	</div>
		
	<!-- 회사 소개 및 어플리케이션 소개 -->
	<div id="footer"></div>
	
</div>

</body>
</html>