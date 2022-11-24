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
<title>RegionInsertForm.jsp</title>

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
	// 이미 등록된 지역 이름 등록금지 시도 (실패)
	$(document).ready(function()
	{
		$("#submitBtn").click(function()
		{
			//alert("버튼클릭확인");
			
			if ($("#regionName").val()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;
			}
			
			ajaxRequest();
		});
		
		$("#listBtn").click(function()
		{
			//alert("버튼클릭확인");
			$(location).attr("href", "regionlist.action");
			
		});
	});
	
	function ajaxRequest()
	{
		$.ajaxSetup({async: false});
		$.post("regionajax.action"
				, {
					regionName: $("#regionName").val()
				}, function(data)
			    { 
					if($("#regionName").val().equals($.trim(data)))
					{
						$("#err").html("이미 등록된 지역이름 입니다");
						$("#err").css("display", "inline");
						return;								//-- submit 액션 처리 중단
					}
					else
					{
						$("#regionForm").submit();
					}
			});
	}
	*/
	
	$(document).ready(function()
	{
		// 에러 span 엘리먼트 안내 초기화
		$("#err").css("display", "none");
		
		// 사용자에 의해 지역명이 입력될 경우 수행할 코드처리
		$("#regionName").on("keyup", function()
		{
		   var search = $(this).val();
		   
		   // 테스트
		   //alert(search);
		   
		   if (search.replace(" ","")=="")
		   {
		      $("#err").css("display", "none");
		      return;
		   }
		   
		   // 입력 내용이 한글 완성형일 경우에만 전송할수있도록 처리
		   var regEx= /^[가-힣]{1,}$/;
		   
		   if (!regEx.test(search))
		      return;
		   
		   // ajax 처리
		   ajaxRequest();
		
		});
		
		$("#submitBtn").click(function()
		{
			//alert("버튼클릭확인");
			
			// 1. 데이터 검사
			// 1-1. 입력항목 누락 여부 확인 → 작성된건지
			if ($("#regionName").val().replace()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;
			}
			
			// 1-2. 입력항목 유형 확인 → 한글 완성형인지
			var regEx= /^[가-힣]{1,}$/;
			
			if ( !regEx.test($("#regionName").val() ) )
			{
				$("#err").html("완성된 한글형을 적어주세요.");
				$("#err").css("display", "inline");
				return;
				
			}
			
			// 2. 중복확인 유효성 검사 → 중복된 값임을 확인했는데 추가하는지
			if ( $("#err").html().trim() == "이미 사용중인 지역명이 존재합니다"
					|| $("#err").html().trim() == "사용 중인 지역명은 등록할 수 없습니다")
			{
				$("#err").html("사용 중인 지역명은 등록할 수 없습니다");
				$("#err").css("display", "inline");
				return;
			}
			
			// 위의 모든 확인 과정을 통과 했으면
			// submit 액션 처리 수행
			$("#regionForm").submit();
			
			
		});
	   
		$("#listBtn").click(function()
		{
			//alert("버튼클릭확인");
			$(location).attr("href", "regionlist.action");
		});
	   
	});
	
	function ajaxRequest()
	{
		$.post("regionajax.action", {regionName: $("#regionName").val()}, function(data)
		{
			$("#err").html(data).css("display", "inline");
		});
	}
	
	
</script>
</head>
<body>

<!--------------------------------------------------
	#37. RegionInsertForm.jsp
	- 지역 데이터 입력 페이지
	- 관리자가 접근하는 지역 데이터 입력 폼 페이지
--------------------------------------------------->

<!-- 메뉴 영역 -->
<div>
	<c:import url="EmployeeMenu.jsp"></c:import>
</div>
<br />

<label style="text-align: left;">지역 관리 > 지역 정보 입력</label>
<hr />

<div align="center">
	
	<!-- 콘텐츠 영역 -->
	<div id="content" align="left">
		
		<form action="regioninsert.action" method="post" id="regionForm">
			<div class="form-group">
			
				<div class="input-group">
					<div class="input-group-addon">지역명</div>
					<input type="text" id="regionName" name="regionName" class="form-control" placeholder="지역명"/>
				</div>

				<!-- 이미 사용 중인 지역명이 존재합니다 -->
				<!-- 사용 중인 지역명은 등록할 수 없습니다 -->
				<!-- → 입력 내용이 있을 때 확인 -->
				<span id="err" style="color: red; font-weight: bold; display: none;">
				</span>
				
				<div class="input-group">
					<div class="btn-group" role="group" style="width: 100%;">
						<button type="button" class="btn btn-primary btn-lg" id="submitBtn">지역 추가</button>
						<button type="button" class="btn btn-default btn-lg" id="listBtn">지역 리스트</button>
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