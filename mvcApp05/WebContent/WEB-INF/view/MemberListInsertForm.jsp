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
		$("#err").css("display", "none");
		
		$("#id").on("keyup", function()
		{
			var search = $(this).val();
			
			//alert(search);
			
			if(search.replace(" ","")=="")
			{
				$("#err").css("display", "none");
				return;
			}
			
			// 입력 내용이 영어일 경우에만 전송할 수 있도록 처리
			var checkEng = /^[a-zA-Z]{1,}$/;
			
			if(!checkEng.test(search))
				return;
			
			// ajax 처리
			ajaxRequest();
			
		});
		
		$("#submitBtn").click(function()
		{
			//alert("버튼클릭확인");
			
			// 0. 데이터 검사
			//-- 공란(입력항목 누락) 없이 모두 작성되었는지 확인
			if ($("#id").val()=="")
			{
				$("#err").html("아이디를 입력하세요.");
				$("#err").css("display", "inline");
				return;
			}
			
			// 1. 입력항목 유형 확인 → 영어인지
			var checkEng = /^[a-zA-Z]{1,}$/;
			
			if ( !checkEng.test($("#id").val() ) )
			{
				$("#err").html("영어만 입력 가능합니다.");				
				$("#err").css("display", "inline");				
				return;			
			}		
			
			// 2. 중복확인 유효성 검사 → 중복된 값임을 확인했는데 추가하는지
			if ( $("#err").html().trim() == "이미 사용 중인 아이디 입니다."
					|| $("#err").html().trim() == "사용 중인 아이디는 등록할 수 없습니다.")
			{
				$("#err").html("사용 중인 아이디는 등록할 수 없습니다.");				
				$("#err").css("display", "inline");				
				return;			
			}
			
			// 3. 데이터 검사
			//-- 공란(입력항목 누락) 없이 모두 작성되었는지 확인
			if ($("#pw").val()=="" || $("#name").val()=="" 
				|| $("#tel").val()=="" || $("#email").val()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
				$("#err").css("display", "inline");
				return;
			}
			
			
			// 위의 모든 확인 과정 통과 했으면
			// 폼 submit 액션 처리 수행
			$("#memberForm").submit();
			
		});
		
		$("#listBtn").click(function()
		{
			//alert("버튼클릭확인");
			$(location).attr("href", "memberlist.action");
		});
		
	});
	
	function ajaxRequest()
	{
		$.post("memberlistinsertajax.action", {id: $("#id").val()}, function(data)
		{
			$("#err").html(data).css("display", "inline");
		});
	}
		

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
		
		<form action="memberlistinsert.action" method="post" id="memberForm">
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