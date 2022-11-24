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
<title>PositionList.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/mainStyle.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	#customers
	{
		width: 40%;
	}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(g)
	{
		// 수정 버튼 클릭 시 액션 처리
		$(".updateBtn").click(function()
		{
			//alert("수정버튼클릭확인");
			//alert("수정버튼클릭확인" + $(this).val());
			
			// 수정 버튼의 value 값을 split()으로 분리 하여 value값 2개 가져오기
			var data;
			data = $(this).val().split(",");
			var positionId = data[0];
			var positionName = data[1];
			
			$(location).attr("href", "positionupdateform.action?positionId=" + positionId + "&positionName=" + positionName);
		});
		
		
		// 삭제 버튼 클릭 시 액션 처리
		$(".deleteBtn").click(function()
		{
			//alert("삭제버튼클릭확인");
			if (confirm("현재 선택한 데이터를 정말 삭제하시겠습니까?"))
			{
				$(location).attr("href", "positiondelete.action?positionId=" + $(this).val());
			}
		});
		
	});
	
</script>
</head>
<body>

<!---------------------------------------------------------------------------------
	#57. PositionList.jsp
	- 직위 리스트 출력 페이지
	- 관리자가 접근하는 직위 리스트 출력 페이지
	  (일반 직원이 접근하는 직위 리스트 출력 페이지는 PosiList.jsp 로 구성 예정)
----------------------------------------------------------------------------------->
<div>

	<!-- 메뉴 영역 -->
	<div>
		<c:import url="EmployeeMenu.jsp"></c:import>
	</div>
	
	<label>직위 관리 > 직위 리스트</label>
	<hr />
	
	<!-- 콘텐츠 영역 -->
	<div id="content">
	
		<div>
			<form action="">
				<input type="button" value="직위 추가" class="btn btn-primary" 
				onclick="location.href='positioninsertform.action'"/>
			</form>
		</div>
		<br /><br />
		
		<!-----------------------------------
			REGIONID REGIONNAME DELCHECK
		------------------------------------>
		<table id="customers" class="table">
			<tr>
				<th>번호</th>
				<th style="width: 200px;">직위명</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<!-- 
			<tr>
				<td>1</td>
				<td>서울</td>
				
				<td>
					<button type="button" class="btn btn-primary btnUpdate">수정</button>
				</td>
				<td>
					<button type="button" class="btn btn-primary btnDelete">삭제</button>
				</td>
			</tr>
			-->
			<c:forEach var="position" items="${positionList }">
				<tr>
					<td>${position.positionId }</td>
					<td>${position.positionName }</td>
					
					<td>
						<button type="button" class="btn updateBtn"
						value="${position.positionId },${position.positionName}" >수정</button>
						<%-- split()을 사용하여 value 값을 2개 받기 위함 --%>
					</td>
					
					<!-- 입력된 데이터 중 사용 중인 직위 정보는 삭제되지 않도록 처리 -->
					<!-- 방법 1 -->
					<%-- 
					<td>
						<c:choose>
							<c:when test="${position.delCheck > 0}">
								<button type="button" class="btn btn-primary btnDelete"
								value="${position.positionId }" disabled="disabled">삭제</button>
							</c:when>
							<c:otherwise>
								<button type="button" class="btn btn-primary btnDelete"
								value="${position.positionId }">삭제</button>
							</c:otherwise>
						</c:choose>
					</td>
					--%>
					
					<!-- 방법 2 -->
					<td>
						<button type="button" class="btn btn-primary deleteBtn"
						value="${position.positionId }" ${position.delCheck == 0 ? "" : "disabled" }>삭제</button>
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