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
<title>MemberRecordUpdateForm.jsp</title>
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
	
	$(function()
	{
		$("#submitBtn").click(function()
		{
			//alert("버튼클릭확인");
			
			// 1. 데이터 검사
			//-- 공란(입력항목 누락) 없이 모두 작성되었는지 확인
			if ($("#kor").val()=="" || $("#eng").val()==""
				|| $("#mat").val()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;
			}
			
			// 2. 입력항목 유형 확인
			//    → 점수는 숫자인지, 범위 안에 들어가는지
			var checkNum = /^[0-9]*$/;
			
			if ( !checkNum.test($("#kor").val() )
				|| !checkNum.test($("#eng").val() )
				|| !checkNum.test($("#mat").val() )
				|| $("#kor").val() < 0 || $("#kor").val() > 100
				|| $("#eng").val() < 0 || $("#eng").val() > 100
				|| $("#mat").val() < 0 || $("#mat").val() > 100
			   )
			{
				$("#err").html("0~100 사이의 숫자만 입력 가능합니다.");				
				$("#err").css("display", "inline");				
				return;			
			}
			
			// 폼 submit 액션 처리 수행
			$("#memberForm").submit();
		});
		
		$("#listBtn").click(function()
		{
			//alert("버튼클릭확인");
			$(location).attr("href", "memberrecordlist.action");
		});
	});

</script>
</head>
<body>
<!--------------------------------------------------
	#24. MemberRecordUpdateForm.jsp
	- 성적 데이터 수정 페이지
	- 관리자가 접근하는 성적 데이터 수정 폼 페이지
--------------------------------------------------->
<!-- 메뉴 영역 -->
<div>
	<c:import url="MemberMenu.jsp"></c:import>
</div>

<label style="text-align: left;">성적 관리 > 성적 정보 수정</label>
<hr />

<div align="center">
	
	<!-- 콘텐츠 영역 -->
	<div id="content" align="left">
		
		<form action="memberrecordupdate.action" method="post" id="memberForm">
			<div class="form-group">
				
				<div class="input-group">
					<div class="input-group-addon">성적 번호</div>
					<input type="text" id="scoreId" name="scoreId" class="form-control" value="${recordDTO.scoreId }" readonly="readonly"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">아이디</div>
					<input type="text" id="id" name="id" class="form-control" value="${recordDTO.id }" readonly="readonly"/>
				</div>

				<div class="input-group">
					<div class="input-group-addon">국어점수</div>
					<input type="text" id="kor" name="kor" class="form-control" value="${recordDTO.kor }"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">영어점수</div>
					<input type="text" id="eng" name="eng" class="form-control" value="${recordDTO.eng }"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">수학점수</div>
					<input type="text" id="mat" name="mat" class="form-control" value="${recordDTO.mat }"/>
				</div>
				
				<!-- 숫자만 입력 가능합니다 -->
				<span id="err" style="color: red; font-weight: bold; display: none;"></span>
				
				<div class="input-group">
					<div class="btn-group" role="btn-group" style="width: 100%;">
						<button type="button" class="btn btn-primary btn-lg" id="submitBtn">성적 수정</button>
						<button type="button" class="btn btn-default btn-lg" id="listBtn">성적 리스트</button>
					</div>
				</div>
				<br /><br />
			</div>
		
		</form>
	</div>
	
</div>

<!-- 회사 소개 및 어플리케이션 소개 영역 -->
<div id="footer">
</div>


</body>
</html>