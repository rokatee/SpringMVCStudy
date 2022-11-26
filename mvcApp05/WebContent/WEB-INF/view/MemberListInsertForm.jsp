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
<title>MemberListInsertForm.jsp</title>
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
			if ($("#id").val()=="" || $("#pw").val()=="" || $("#name").val()=="" 
				|| $("#tel").val()=="" || $("#email").val()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;
			}
			
			
			
			// 아이디 중복검사 ajax 처리-----------------------------
			// 사용 중인 아이디가 있습니다
			//
			//
			//
			//----------------------------- 아이디 중복검사 ajax 처리
			
			
			
			// 폼 submit 액션 처리 수행
			$("#memberForm").submit();
		});
		
		$("#listBtn").click(function()
		{
			//alert("버튼클릭확인");
			$(location).attr("href", "memberlist.action");
		});
	});

</script>
</head>
<body>
<!--------------------------------------------------
	#07. MemberListInsertForm.jsp
	- 학생 데이터 입력 페이지
	- 관리자가 접근하는 학생 데이터 입력 폼 페이지
--------------------------------------------------->
<!-- 메뉴 영역 -->
<div>
	<c:import url="MemberMenu.jsp"></c:import>
</div>

<label style="text-align: left;">학생 관리 > 학생 정보 입력</label>
<hr />

<div align="center">
	
	<!-- 콘텐츠 영역 -->
	<div id="content" align="left">
		
		<form action="memberinsert.action" method="post" id="memberForm">
			<div class="form-group">
				
				<div class="input-group">
					<div class="input-group-addon">아이디</div>
					<input type="text" id="id" name="id" class="form-control" placeholder="아이디"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">비밀번호</div>
					<input type="password" id="pw" name="pw" class="form-control" placeholder="비밀번호"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">이름</div>
					<input type="text" id="name" name="name" class="form-control" placeholder="이름"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">전화번호</div>
					<input type="text" id="tel" name="tel" class="form-control" placeholder="ex) 010-1234-1234"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">이메일</div>
					<input type="text" id="email" name="email" class="form-control" placeholder="ex) email@address.com"/>
				</div>
				
				<!-- 사용 중인 아이디가 있습니다 -->
				<span id="err" style="color: red; font-weight: bold; display: none;"></span>
				
				<div class="input-group">
					<div class="btn-group" role="btn-group" style="width: 100%;">
						<button type="button" class="btn btn-primary btn-lg" id="submitBtn">학생 추가</button>
						<button type="button" class="btn btn-default btn-lg" id="listBtn">학생 리스트</button>
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