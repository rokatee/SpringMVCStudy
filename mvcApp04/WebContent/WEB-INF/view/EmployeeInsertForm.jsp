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
<title>EmployeeInsertForm.jsp</title>

<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/jquery-ui.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	
	#content
	{
		border: 1px solid #ccc;
		border-radius: 5px;
		width: 500px;
		padding: 15px;
		margin: 30px;
	}
	
	.input-group
	{
		margin: 10px;
	}
		
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="<%=cp%>/js/jquery-ui.js"></script>
<script type="text/javascript">
	/*
	// 방법 1
	$(function()
	{
		$("#positionId").change(function()
		{
			//alert("변경확인");
			var params = "positionId=" + $("#positionId").val();
			
			$.ajax(
			{
				type:"POST"
				, url:"ajax.action"
				, data:param
				, dataType:"json"
				, success:function(args)
				{
					//var.minBasicPay = args.result;
					$("#minBasicPay").html(args);
				}
				, error:function(e)
				{
					alert(e.responseText);
				}
			})
		});
	});
	*/
	
	// 방법 2
	$(document).ready(function()
	{
		// Ajax 요청 및 응답 처리
		ajaxRequest();
		//-- 지금은 페이지 최초 요청되었을 때만 minBasicPay 뿌려주는 형태
		//   그게 아니라 selectbox 바뀔 때마다 뿌려줘야 한다. (Line 51에 작성)
		
		// 테스트
		//alert("확인");
		
		// jQuery-UI 캘린더를 불러오는 함수 처리(datepicker())
		//-- id가 birthday인 걸 클릭하면 달력 나오게 하고 싶은 거
		$("#birthday").datepicker(
		{
			//-- 여기까지하고 확인해보면 생년월일 클릭하면 달력나오고
			//   날짜 선택하면 달력 사라지고 텍스트박스에 해당 날짜 들어감
			//   날짜 05/01/2022 로 들어가고 있음
			//   jquery-ui.js 의 dateFormat: "mm/dd/yy" 에 구문에 의해서
			// 아래와 같이 해당 속성 이름 쓰고 변경해줄 수 있다~
			
			dateFormat: "yy-mm-dd"
			, changeMonth: true
			, changeYear: true
		});
		
		// 먼저, 아래에서 ajax요청과 관련된 함수 만들고 오자
		
		// 직위(select)의 선택된 내용이 변경되었을 경우 수행해야 할 코드 처리
		$("#positionId").change(function()
		{	
			// 테스트
			//alert("변경~!!!");
			
			// Ajax 요청 및 응답 처리
			ajaxRequest();
		});
		
		
		// 직원 추가 버튼이 클릭되었을 때 수행해야 할 코드 처리
		$("#submitBtn").click(function()
		{
			// 테스트
			//alert("버튼 클릭~!!!");
			
			// 테스트
			//alert($("#minBasicPay").val());		//--(Ⅹ)
			// └→ 아무것도 안나옴. 이렇게 얻어낼 수 없다.
			//alert($("#minBasicPay").text());		//--(○)
			
			// 1. 데이터 검사
			//-- 공란(입력항목 누락) 없이 모두 작성되었는지에 대한 여부 확인
			if ($("#name").val()=="" || $("#ssn1").val()=="" || $("#ssn2").val()==""
					|| $("#birthday").val()=="" || $("#telephone").val()==""
					|| $("#basicPay").val()=="" || $("#extraPay").val()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;								//-- submit 액션 처리 중단
			}
			
			// 2. 최소 기본급 유효성 검사
			//-- 입력한 기본급이 최소 기본급보다 작은지에 대한 여부 확인
			// if (사용자가입력한기본급 > 직급별최소기본급) {return;}
			// $("#basicPay").val() ) < $("#minBasicPay").text() 그냥 이대로 산술비교 불가
			// 정수형태로 변환 해줘야 한다.
			if ( parseInt($("#minBasicPay").text()) > parseInt($("#basicPay").val()) )
			{
				$("#err").html("입력하신 기본급이 최소 기본급보다 작습니다.");
				$("#err").css("display", "inline");
				return;								//-- submit 액션 처리 중단
			}
			
			// 폼 submit 액션 처리 수행
			$("#employeeForm").submit();
			
		});
	
		// 직원 리스트 버튼이 클릭되었을 경우 수행할 코드 처리
		//onclick="location.href='employeeinsertform.action'"
		$("#listBtn").click(function()
		{
			//alert("버튼클릭확인");
			$(location).attr("href", "employeelist.action");
			
		});
		
	});
	
	function ajaxRequest()
	{
		//alert("Ajax 요청 및 응답 처리");
		
		// 『jquery.post()』 / 『jquery.get()』
		// 『$.post()』 / 『$.get()』
		//-- jQuery 에서 AJAX 를 사용해야 할 경우 지원해 주는 함수
		//   (서버측에서 요청한 데이터를 받아오는 기능의 함수)
		
		// ※ 이 함수(『$.post()』) 의 사용 방법(방식)
		//-- 『$.post(요청주소, 전송데이터, 응답액션처리)』
		//    · 요청주소(url)
		//       → 데이터를 요청할 파일에 대한 정보
		//    · 전송데이터(data)
		//       → 서버 측에 요청하는 과정에서 내가 전달할 파라미터
		//    · 응답액션처리(function)
		//       → 응답을 받을 수 있는 함수
		//			여기서는 익명의 함수를 사용 → 단순 기능 구현 및 적용
		
		//	※ 참고로 data 는 파라미터의 데이터타입을 그대로 취하게 되므로
		//     html 이든, 문자열 이든 상관이 없다
		$.post("ajax.action"
			, {
				positionId: $("#positionId").val()}
				, function(data)
				  {
						$("#minBasicPay").html(data);
		});
		//--① ~~.action 이라는 약속은 지켜서 구성해야 한다.
		//  ② 직위의 selectBox 에 선택된 Id를 넘겨주면 된다.
		//  ③ position 넘겨주고 받은거 파라미터로 받는 함수
		//     id가 minBasicPay인 거에 그 값 넣어서 출력되게 해주면 된다.
		
		// 그러면 ajax.action 에 응답하는 뭔가가 있어야 한다.
		// → dispatcher-servlet 건드려야 한다.
	}
	
</script>
</head>
<body>

<!--------------------------------------------------
	#19. EmployeeInsertForm.jsp
	- 직원 데이터 입력 페이지
	- 관리자가 접근하는 직원 데이터 입력 폼 페이지
--------------------------------------------------->

<!-- 메뉴 영역 -->
<div>
	<c:import url="EmployeeMenu.jsp"></c:import>
</div>

<label style="text-align: left;">직원 관리 > 직원 정보 입력</label>
<hr />

<div align="center">
	
	<!-- 콘텐츠 영역 -->
	<div id="content" align="left">
		
		<form action="employeeinsert.action" method="post" id="employeeForm">
			<div class="form-group">
			
				<div class="input-group">
					<div class="input-group-addon">이름</div>
					<input type="text" id="name" name="name" class="form-control" placeholder="이름"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">주민번호</div>
					<input type="text" id="ssn1" name="ssn1" class="form-control" />
					<div class="input-group-addon"> - </div>
					<input type="text" id="ssn2" name="ssn2" class="form-control" />
				</div>
					
					
				<div class="input-group">
					<div class="input-group-addon">생년월일</div>
					<input type="text" id="birthday" name="birthday" class="form-control" placeholder="생년월일"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">양 / 음력</div>
					<div class="form-control">
						<input type="radio" value="0" name="lunar" id="lunar0" checked="checked"/>
						<label for="lunar0">양력</label>
						<input type="radio" value="1" name="lunar" id="lunar1"/>
						<label for="lunar1">음력</label>
					</div>
				</div>

				<div class="input-group">
					<div class="input-group-addon">전화번호</div>
					<input type="tel" id="telephone" name="telephone" class="form-control" placeholder="ex) 010-1234-1234"/>
				</div>

				<div class="input-group">
					<div class="input-group-addon">지역</div>
					<select name="regionId" id="regionId" class="form-control">
						<!-- 
						<option value="1">마포</option>
						<option value="2">서초</option>
						<option value="3">은평</option>
						-->
						<c:forEach var="region" items="${regionList }">
							<option value="${region.regionId }">
								${region.regionName }
							</option>
						</c:forEach>
					</select>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">부서</div>
					<select name="departmentId" id="departmentId" class="form-control"> 
						<!-- 
						<option value="1">독서부</option>
						<option value="2">바둑부</option>
						<option value="3">축구부</option>
						 -->
						 <c:forEach var="department" items="${departmentList }">
						 	<option value="${department.departmentId }">
						 		${department.departmentName }
						 	</option>
						 </c:forEach>
					</select>
				</div>
						
				<div class="input-group">
					<div class="input-group-addon">직위</div>
					<select name="positionId" id="positionId" class="form-control">
						<!-- 
						<option value="1">반장</option>
						<option value="2">부반장</option>
						<option value="3">팀장</option>
						 -->
						 <c:forEach var="position" items="${positionList }">
						 	<option value="${position.positionId }">
						 		${position.positionName }
						 	</option>
						 </c:forEach>
					</select>
				</div>
						
				<div class="input-group">
					<div class="input-group-addon">기본급</div>
					<input type="text" id="basicPay" name="basicPay" class="form-control"/>
					<div class="input-group-addon">원</div>
					
					<div class="input-group-addon">수당</div>
					<input type="text" id="extraPay" name="extraPay" class="form-control" />
					<div class="input-group-addon">원</div>
				</div>
					
					
				<div class="input-group" style="text-align: left;">
					(최소 기본급
					<span id="minBasicPay" style="color: red; font-weight: bold;">0</span>
					원)
				</div>
				<br /><br />
				
				<span id="err" style="color: red; font-weight: bold; display: none;">
				</span>
				
				<div class="input-group">
					<div class="btn-group" role="group" style="width: 100%;">
						<button type="button" class="btn btn-primary btn-lg" id="submitBtn">직원 추가</button>
						<button type="button" class="btn btn-default btn-lg" id="listBtn">직원 리스트</button>
					</div>
				</div>
				<br /><br />
						
				
			</div>
		</form>
		
	</div>	
	
	<!-- 회사 소개 및 어플리케이션 소개 영역 -->
	<div id="footer">
	</div>

</div>

</body>
</html>