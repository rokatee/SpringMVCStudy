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
<title>LoginForm.jsp</title>
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
		padding: 15px 0px;
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
	}
</style>

<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function()
	{
		$("#submitBtn").click(function()
		{
			// alert("클릭 확인");
			
			$("#err").css("display", "none");
			
			if ($("#id").val()=="")
			{
				$("#err").html("아이디를 입력해주세요.");
				$("#err").css("display", "inline");
				$("#id").focus();
				return;
			}
			
			if ($("#pw").val()=="")
			{
				$("#err").html("패스워드를 입력해주세요.");
				$("#err").css("display", "inline");
				$("#pw").focus();
				return;
			}
			
			// alert($("#id").val() + $("#pw").val() + $("input[name=grade]").val());
			
			$("#loginForm").submit();
		});
	});
	
</script>
</head>
<body>

<!-- #11. LoginForm.jsp -->

<div id="header">
	<h1>mvcApp05</h1>
</div>

<div id="content">
	
	<form action="login.action" method="post" id="loginForm">
		<div class="form-group">
			<div class="input-group">
				<label class="title">로그인</label>
			</div>
			<div class="input-group">
				<input type="radio" name="grade" id="grade0" value="0">
				<label for="grade0">관리자</label>
				<input type="radio" name="grade" id="grade1" value="1" checked="checked">
				<label for="grade1">학생</label>
			</div>
			<div class="input-group">
				<div class="input-group-addon">ID</div>
				<input type="text" id="id" name="id" class="form-control"
				placeholder="아이디">
			</div>
			<div class="input-group">
				<div class="input-group-addon">PW</div>
				<input type="password" id="pw" name="pw" class="form-control"
				placeholder="비밀번호">
			</div>
			<div class="input-group">
				<span id="err"></span><br><br>
				<button type="button" class="btn" id="submitBtn">로그인</button>
			</div>
		</div>
	</form>
	
</div>

</body>
</html>