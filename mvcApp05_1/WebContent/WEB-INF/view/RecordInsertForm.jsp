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
<title>RecordInsertForm.jsp</title>
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
		// ID 중복 여부 검사
		$("#id").keyup(function()
		{
			var search = $(this).val();
			
			// 입력 내용이 존재할 경우에만 서버로 전송할 수 있도록 처리
			if (search.replace(" ", "")=="")
			{
				return;
			}
			
			// ajax 처리
			validCheck();
		});
		
		$("#submitBtn").click(function()
		{
			// alert("클릭 확인");
			// alert($("input[name=grade]:checked").val());
			
			$("#err").css("display", "none");
			$("#err2").css("display", "none");

			
			// 입력 항목 검사
			if ($("#kor").val()=="" || $("#eng").val()=="" || $("#mat").val()=="")
			{
				$("#err").html("입력항목을 확인해주세요.");
				$("#err").css("display", "inline");
				return;
			}
			
			if (parseInt($("#kor").val())<0 || parseInt($("#kor").val())>100
					|| parseInt($("#eng").val())<0 || parseInt($("#eng").val())>100
					|| parseInt($("#mat").val())<0 || parseInt($("#mat").val())>100)
			{
				$("#err").html("유효한 점수를 입력해주세요.");
				$("#err").css("display", "inline");
				return;
			}
			
			$("#recordForm").submit();
			
		});
		
		
	});
	
	function validCheck()
	{
		$.post("idajax.action", {id : $("#id").val()}, function(data)
		{
			$("#err2").html(data);
			// alert($("#err2").html().trim());
		});
	}
</script>
</head>
<body>

<!-- #30. RecordInsertForm.jsp -->

<div>
	
	<!-- 상단 메뉴 -->
	<div id="menu">
		<c:import url="Menu.jsp"></c:import>
	</div>
	
	<div id="content">
		
		<form action="recordinsert.action" method="post" id="recordForm">
			<div class="form-group">
				<div class="input-group">
					<label class="title">성적 신규 등록</label>
				</div>
				<div class="input-group">
					<div class="input-group-addon">아이디</div>
					<input type="text" id="id" name="id" class="form-control"
					value="${id }" readonly="readonly">
				</div>
				<div class="input-group">
					<div class="input-group-addon">국어</div>
					<input type="text" id="kor" name="kor" class="form-control"
					placeholder="0 ~ 100">
				</div>
				<div class="input-group">
					<div class="input-group-addon">영어</div>
					<input type="text" id="eng" name="eng" class="form-control"
					placeholder="0 ~ 100">
				</div>
				<div class="input-group">
					<div class="input-group-addon">수학</div>
					<input type="text" id="mat" name="mat" class="form-control"
					placeholder="0 ~ 100">
				</div>
				<div class="input-group">
					<span id="err"></span>
					<span id="err2"></span>
					<br><br>
					<button type="button" class="btn" id="submitBtn">신규 입력</button>
				</div>
			</div>
		</form>
		
	</div>

</div>

</body>
</html>