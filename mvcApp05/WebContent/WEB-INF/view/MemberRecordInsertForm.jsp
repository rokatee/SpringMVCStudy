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
<title>MemberRecordInsertForm.jsp</title>
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
			
			// 아이디의 입력 내용이 영어일 경우에만 전송할 수 있도록 처리
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
			
			// 1. 입력항목 유형 확인
			//    → 아이디는 영어인지
			//    → 점수는 숫자인지, 범위 안에 들어가는지
			var checkEng = /^[a-zA-Z]{1,}$/;
			
			if ( !checkEng.test($("#id").val() ) )
			{
				$("#err").html("영어만 입력 가능합니다.");				
				$("#err").css("display", "inline");				
				return;			
			}
			
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
			
			// 2. 성적 등록 유무 검사 → delCheck이 0보다 클경우 성적 등록 불가
			if ( $("#err").html().trim() == "이미 성적이 등록된 아이디 입니다."
					|| $("#err").html().trim() == "성적이 등록된 아이디는 성적 부여가 불가능합니다.")
			{
				$("#err").html("성적이 등록된 아이디는 성적 부여가 불가능합니다.");
				$("#err").css("display", "inline");
				return;			
			}
			
			// 3. 아이디 존재유무 검사 → 존재함을 확인 했을때만 추가하는지
			if ( $("#err").html().trim() == "존재하지 않는 아이디 입니다."
					|| $("#err").html().trim() == "존재하지 않는 아이디는 성적 부여가 불가능합니다.")
			{
				$("#err").html("존재하지 않는 아이디는 성적 부여가 불가능합니다.");
				$("#err").css("display", "inline");
				return;			
			}
			
			// 4. 데이터 검사
			//-- 공란(입력항목 누락) 없이 모두 작성되었는지 확인
			if ($("#kor").val()=="" || $("#eng").val()=="" || $("#mat").val()=="")
			{
				$("#err").html("필수 입력 항목이 누락되었습니다.");
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
	
	function ajaxRequest()
	{
		$.post("memberrecordinsertajax.action", {id: $("#id").val()}, function(data)
		{
			$("#err").html(data).css("display", "inline");
		});
	}

</script>
</head>
<body>
<!--------------------------------------------------
	#19. MemberRecordInsertForm.jsp
	- 성적 데이터 입력 페이지
	- 관리자가 접근하는 성적 데이터 입력 폼 페이지
--------------------------------------------------->
<!-- 메뉴 영역 -->
<div>
	<c:import url="MemberMenu.jsp"></c:import>
</div>

<label style="text-align: left;">성적 관리 > 성적 정보 입력</label>
<hr />

<div align="center">
	
	<!-- 콘텐츠 영역 -->
	<div id="content" align="left">
		
		<form action="memberrecordinsert.action" method="post" id="memberForm">
			<div class="form-group">
				
				<div class="input-group">
					
					<div class="input-group-addon">성적 입력 가능한 아이디 / 이름</div>
					<select name="memberList" id="memberList">
						<c:forEach var="memberList" items="${memberListDTO }">
							<c:choose>
								<c:when test="${memberList.delCheck ==	0 }">
									<option value="${memberList.id }" >${memberList.id } / ${memberList.name }</option>
								</c:when>
							</c:choose>
						</c:forEach>
					</select>
				</div>
				<div class="input-group">
					<div class="input-group-addon">아이디</div>
					<input type="text" id="id" name="id" class="form-control" placeholder="아이디 입력"/>
				</div>

				<div class="input-group">
					<div class="input-group-addon">국어점수</div>
					<input type="text" id="kor" name="kor" class="form-control" placeholder="0~100 사이의 숫자"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">영어점수</div>
					<input type="text" id="eng" name="eng" class="form-control" placeholder="0~100 사이의 숫자"/>
				</div>
				
				<div class="input-group">
					<div class="input-group-addon">수학점수</div>
					<input type="text" id="mat" name="mat" class="form-control" placeholder="0~100 사이의 숫자"/>
				</div>
				
				<!-- 숫자만 입력 가능합니다 -->
				<span id="err" style="color: red; font-weight: bold; display: none;"></span>
				
				<div class="input-group">
					<div class="btn-group" role="btn-group" style="width: 100%;">
						<button type="button" class="btn btn-primary btn-lg" id="submitBtn">성적 입력</button>
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