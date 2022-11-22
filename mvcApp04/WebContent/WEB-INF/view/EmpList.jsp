<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EmpList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/mainStyle.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<!-- 스타일 적용이 안된다면 크롬 > 설정 > 개인정보 및 보안 > 인터넷 기록 삭제 -->
</head>
<body>

<!-- 
	basicpay, extrapay, pay 천의자리마다 『,』 찍어줄거라
	taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"
	등록해서 포맷사용할것이다 
--> 


<!---------------------------------------------------------------------------------
	#14. EmployeeList.jsp
	- 직원 리스트 출력 페이지
	- 관리자가 접근하는 직원 데이터 출력 페이지
	  (일반 직원이 접근하는 직원 데이터 출력 페이지는 EmpList.jsp 로 구성 예정)
----------------------------------------------------------------------------------->

<div>

	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1>[직원 정보] 일반직원 전용</h1>
		<hr>
		
		<!-- 일반 사원 전용이니 직원추가 버튼 제거 -->
		<!-- 
		<div>
			<form action="">
				<input type="button" value="직원 추가" class="btn btn-primary control"
				onclick="location.href='employeeinsertform.action'">
			</form>
		</div>
		<br /><br />
		-->
		
		<!-----------------------------------------------------
		EMPLOYEEID NAME SSN BIRTHDAY LUNAR LUNARNAME TELEPHONE    
		DEPARTMENTNAME POSITIONNAME REGIONNAME 
		BASICPAY EXTRAPAY PAY GRADE  
		------------------------------------------------------->               
		<table id="customers" class="table">
			<tr>
				<!-- 항목 15EA -->
				<th>번호</th>	
				<th>이름</th>	
				<!-- 
				<th>주민번호</th>	
				<th>생년월일</th>	
				<th>양음력</th>	
				<th>전화번호</th>	
				-->
				<th>지역</th>	
				<th>부서</th>	
				<th>직위</th>	
				<!-- 
				<th>기본급</th>	
				<th>수당</th>	
				<th>급여</th>
				-->	
				<th>등급</th>	
				<!--
				<th>수정</th>	
				<th>삭제</th>
				-->	
			</tr>
			<!-- 
			<tr>
				<td>1</td>
				<td>민찬우</td>
				<td>951212</td>
				<td>1995-12-12</td>
				<td>양력</td>
				<td>010-1234-1234</td>
				<td>서울</td>
				<td>개발부</td>
				<td>사원</td>
				<td>1,500,000</td>
				<td>1,500,000</td>
				<td>3,000,000</td>
				<td>관리자</td>
				<td><button type="button" class="btn">수정</button></td>  
				<td><button type="button" class="btn">삭제</button></td>  
			</tr>
			<tr>
				<td>2</td>
				<td>김태민</td>
				<td>941212</td>
				<td>1998-11-11</td>
				<td>양력</td>
				<td>010-9876-9876</td>
				<td>경기</td>
				<td>인사부</td>
				<td>대리</td>
				<td>2,500,000</td>
				<td>500,000</td>
				<td>3,000,000</td>
				<td>일반사원</td>
				<td><button type="button" class="btn">수정</button></td>  
				<td><button type="button" class="btn">삭제</button></td>  
			</tr>
			<tr>
				<td>3</td>
				<td>유동현</td>
				<td>941010</td>
				<td>1994-10-10</td>
				<td>양력</td>
				<td>010-5678-5678</td>
				<td>서울</td>
				<td>개발부</td>
				<td>사원</td>
				<td>1,500,000</td>
				<td>1,500,000</td>
				<td>3,000,000</td>
				<td>관리자</td>
				<td><button type="button" class="btn">수정</button></td>  
				<td><button type="button" class="btn">삭제</button></td>  
			</tr>
			-->
			<c:forEach var="employee" items="${employeeList }">
				<tr>
					<td>${employee.employeeId }</td>
					<td>${employee.name }</td>
					<%-- 
					<td>${employee.ssn }-*******</td>
					<td>${employee.birthday }</td>
					<td>${employee.lunarName }</td>
					<td>${employee.telephone }</td>
					--%>
					<td>${employee.regionName }</td>
					<td>${employee.departmentName }</td>
					<td>${employee.positionName }</td>
					
					<%-- 
					<td>
						<fmt:formatNumber value="${employee.basicPay }" groupingUsed="true"></fmt:formatNumber>
					</td>
					
					<td>
						<fmt:formatNumber value="${employee.extraPay }" groupingUsed="true"></fmt:formatNumber>
					</td>
					<td>
						<fmt:formatNumber value="${employee.pay }" groupingUsed="true"></fmt:formatNumber>
					</td>
					--%>
					
					<%-- <td>${employee.grade }</td> --%>
					<td>${employee.grade==0? "관리자" : "일반사원" }</td>
					<%-- 삼항 연산자 활용 --%>
					
					<%-- 
					<td>
						<button type="button" class="btn btn-primary control updateBtn"
						value="${employee.employeeId }">수정</button>
					</td>
					
					<td>
						<button type="button" class="btn btn-primary control deleteBtn"
						value="${employee.employeeId }">삭제</button>
					</td>
					--%>
				</tr>
			</c:forEach>
		</table>
	</div>
	
	<!-- 회사 소개 및 어플리케이션 소개 -->
	<div id="footer"></div>
	

</div>

</body>
</html>