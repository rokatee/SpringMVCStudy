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
<title>MemberRecordList.jsp</title>
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
			$(location).attr("href", "memberrecordupdateform.action?id=" + $(this).val());
		});
		
		$(".deleteBtn").click(function()
		{
			//alert("삭제버튼클릭");
			//alert($(this).val());
			if (confirm("현재 선택한 데이터를 정말 삭제하시겠습니까?"))
			{
				$(location).attr("href", "memberrecorddelete.action?id=" + $(this).val());
			}
		});
	});
	

</script>
</head>
<body>
<!---------------------------------------------------------------------------------
	#17. MemberRecordList.jsp
	- 성적 리스트 출력 페이지
	- 관리자가 접근하는 성적 데이터 출력 페이지
	  (일반 학생이 접근하는 성적 데이터 출력 페이지는 MemRecList.jsp 로 구성 예정)
----------------------------------------------------------------------------------->
<div>
	
	<!-- 메뉴 영역 -->
	<div>
		<c:import url="MemberMenu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
		<h1>[성적 관리] > [성적 리스트]</h1>
		<hr />
		
		<div>
			<form action="">
				<input type="button" value="성적 입력" class="btn btn-primary control"
				onclick="location.href='memberrecordinsertform.action'"/>
			</form>
		</div>
		<br /><br />
		
		<!---------------------------------------------
			SCOREID KOR ENG MAT ID 
		---------------------------------------------->
		
		<table id="customers" class="table">
			<tr>
				<!-- 항목 5EA -->
				<th>성적번호</th>
				<th>국어점수</th>
				<th>영어점수</th>
				<th>수학점수</th>
				<th>아이디</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<!-- 
			<tr>
				<td>1</td>
				<td>90</td>
				<td>80</td>
				<td>70</td>
				<td>superman</td>
				<td><button type="button" class="btn">수정</button></td>  
				<td><button type="button" class="btn">삭제</button></td> 
			</tr>
			-->
			<c:forEach var="member" items="${memberRecord }">
				<tr>
					<td>${member.scoreId }</td>
					<td>${member.kor }</td>
					<td>${member.eng }</td>
					<td>${member.mat }</td>
					<td>${member.id }</td>
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