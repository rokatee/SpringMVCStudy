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
<title>MemberUpdateForm.jsp</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	#header
	{
		height: 70px;
		width: 100%;
		background: #BDBDBD;
	}
	h1
	{
		height: 70px;
		margin: 0px 20px;
		color: #086A87;
		font-weight: bold;
	}
	#content
	{
		border: 1px solid #ccc;
		border-radius: 5px;
		width: 500px;
		padding: 15px;
		margin: auto;
		margin-top: 20px;
	}
	.title
	{
		font-size: 25px;
		font-weight: bold;
	}
	.input-group
	{
		margin: 10px;
	}
	#submitBtn
	{
		width: 450px;
		background: #086A87;
		color: white;
		font-weight: bold;
	}
	#submitBtn:hover
	{
		background: #0B4C5F;
	}
	#err
	{
		color: red;
		font-size: small;
		font-weight: bold;
		display: none;
	}
	#err2
	{
		color: red;
		font-size: small;
		font-weight: bold;
		display: none;
	}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function()
	{
		$("#submitBtn").click(function()
		{
			// alert("클릭 확인");
			// alert($("input[name=grade]:checked").val());
			
			$("#err").css("display", "none");
			$("#err2").css("display", "none");

			
			// 입력 항목 검사
			if ($("#id").val()=="" || $("#pw").val()=="" || $("#name").val()==""
					|| $("#tel").val()=="" || $("#email").val()=="")
			{
				$("#err").html("입력항목을 확인해주세요.");
				$("#err").css("display", "inline");
				return;
			}
			
			// pw 유효성 검사
			validCheck();
			
		});
		
		
	});
	
	function validCheck()
	{
		$.post("pwajax.action", {id : $("#id").val(), pw : $("#pw").val()}, function(data)
		{	
			// alert(data.trim());
			if (data.trim()=="")
			{
				$("#err2").html("비밀번호를 확인해주세요.").css("display", "inline");
				return;
			}
			else
			{
				$("#memberForm").submit();
			}
		});
	}
</script>
</head>
<body>

<!-- #22. MemberUpdateForm.jsp -->

<div>
	
	<!-- 상단 메뉴 -->
	<div id="menu">
		<c:import url="Menu.jsp"></c:import>
	</div>
	
	<div id="content">
		
		<form action="memberupdate.action" method="post" id="memberForm">
			<div class="form-group">
				<div class="input-group">
					<label class="title">멤버 정보 수정</label>
				</div>
				<div class="input-group">
					<input type="radio" name="grade" id="grade0" value="0"
					${member.grade==0 ? "checked=\"checked\"" : ""}>
					<label for="grade0">관리자</label>
					<input type="radio" name="grade" id="grade1" value="1"
					${member.grade==1 ? "checked=\"checked\"" : ""}>
					<label for="grade1">학생</label>
				</div>
				<div class="input-group">
					<div class="input-group-addon">아이디</div>
					<input type="text" id="id" name="id" class="form-control"
					value="${member.id }" readonly="readonly">
				</div>
				<div class="input-group">
					<div class="input-group-addon">비밀번호</div>
					<input type="password" id="pw" name="pw" class="form-control"
					placeholder="비밀번호">
				</div>
				<div class="input-group">
					<div class="input-group-addon">이름</div>
					<input type="text" id="name" name="name" class="form-control"
					value="${member.name }">
				</div>
				<div class="input-group">
					<div class="input-group-addon">전화번호</div>
					<input type="text" id="tel" name="tel" class="form-control"
					value="${member.tel }">
				</div>
				<div class="input-group">
					<div class="input-group-addon">이메일</div>
					<input type="text" id="email" name="email" class="form-control"
					value="${member.email }">
				</div>
				<div class="input-group">
					<span id="err"></span>
					<span id="err2"></span>
					<br><br>
					<button type="button" class="btn" id="submitBtn">정보 수정</button>
				</div>
			</div>
		</form>
		
	</div>

</div>

</body>
</html>