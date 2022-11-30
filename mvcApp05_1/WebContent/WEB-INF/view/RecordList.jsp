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
<title>RecordList.jsp</title>
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
		// 입력 버튼 클릭 액션
		$(".addBtn").click(function()
		{
			// alert("클릭 확인");
			
			$(location).attr("href", "recordinsertform.action?id=" + $(this).val());
		});
		
		// 수정 버튼 클릭 액션
		$(".updateBtn").click(function()
		{
			// alert("클릭 확인");
			
			$(location).attr("href", "recordupdateform.action?scoreId=" + $(this).val());
		});
		
		// 삭제 버튼 클릭 액션
		$(".deleteBtn").click(function()
		{
			// alert("클릭 확인");

			$(location).attr("href", "recorddelete.action?scoreId=" + $(this).val());
		});
		
	});
</script>

</head>
<body>

<!-- #28. RecordList.jsp -->

<div>
	
	<!-- 상단 메뉴 -->
	<div id="menu">
		<c:import url="Menu.jsp"></c:import>
	</div>
	
	<!-- 콘텐츠 -->
	<div id="content">
		
		<!-- ID, NAME, KOR, ENG, MAT, AVG, SCOREID, DELCHECK -->
		
		<table id="members" class="table">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>국어</th>
				<th>영어</th>
				<th>수학</th>
				<th>평균</th>
				<th>입력 여부</th>
				<th></th>
			</tr>
			<c:forEach var="record" items="${recordList }">
				<tr id="td">
					<td>${record.id }</td>
					<td>${record.name }</td>
					<td>${record.kor }</td>
					<td>${record.eng }</td>
					<td>${record.mat }</td>
					<td>${record.avg }</td>
					<td>${record.scoreId==null ? "미입력" : "입력 완료" }</td>
					<td>
						<div class="btn-group">
							<c:choose>
								<c:when test="${record.scoreId==null }">
									<button type="button" class="btn btn-primary btn-sm addBtn"
									value="${record.id }">등록</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-primary btn-sm updateBtn"
									value="${record.scoreId }">수정</button>
								</c:otherwise>
							</c:choose>
							<button type="button" class="btn btn-danger btn-sm deleteBtn" 
							value="${record.scoreId }">삭제</button>
						</div>
					</td>
				</tr>
			</c:forEach>
		</table>
		
	</div>
	
</div>

</body>
</html>