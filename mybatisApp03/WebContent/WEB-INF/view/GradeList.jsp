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
<!-- 뷰포트 메타엘리먼트로 구성 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>GradeList.jsp</title>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- jquery -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/main.css">

<script type="text/javascript">
	$(function()
	{
		$(".btnUpdate").click(function()
		{
			$(location).attr("href", "gradeupdate.action?sid=" + $(this).val());
			
		});
		
		$(".btnDelete").click(function()
		{
			if (confirm("정말 삭제하시겠습니까?"))
				/* $(location).attr("href", "gradedelete.action?sid=" + $(this).val); */
				$(location).attr("href", "gradedelete.action?sid=" + $(this).val());

		});
	});
</script>
</head>
<body>

<div>
	<h1>성적 정보</h1>
</div>

<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
			
			<div class="panel-heading" id="title">
				성적 정보 입력
			</div>
			
			<div class="panel-body">
				<form role="form" action="gradeinsert.action" method="post">
				<!-- <form id="gradeForm" role="form" action="gradeinsert.action" method="post"> -->
					
					<!-- name 속성 값이 컨트롤러로 바인딩되어 들어가야 한다. -->
					<div class="form-group">
						<label for="sid">
							SID : 
						</label>
						<input type="text" class="form-control" id="sid" name="sid"/>
					</div>
					
					<div class="form-group">
						<label for="sub1">
							SUB1 :
						</label>
						<input type="text" class="form-control" id="sub1" name="sub1"/>
					</div>
					
					<div class="form-group">
						<label for="sub2">
							SUB2 :
						</label>
						<input type="text" class="form-control" id="sub2" name="sub2"/>
					</div>
					
					<div class="form-group">
						<label for="sub3">
							SUB3 :
						</label>
						<input type="text" class="form-control" id="sub3" name="sub3"/>
					</div>
					
					<button type="submit" class="btn btn-default btn-sm">SUBMIT</button>
					<button type="reset" class="btn btn-default btn-sm btnCancel">CANCEL</button>
					
				</form>
			</div>
			
		</div><!-- close .panel .panel-default -->
		
		<div class="panel panel-default">
			
			<div class="panel-heading">
				성적 정보 출력
			</div>
			
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th>SID</th>
							<th>SUB1</th>
							<th>SUB2</th>
							<th>SUB3</th>
							<th>TOT</th>
							<th>AVG</th>
							<th>CH</th>
							<th>삭제 / 수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="grade" items="${list }">
						<tr>
							<td>${grade.sid }</td>
							<td>${grade.sub1 }</td>
							<td>${grade.sub2 }</td>
							<td>${grade.sub3 }</td>
							<td>${grade.tot }</td>
							<td>${grade.avg }</td>
							<td>${grade.ch }</td>
							<td>
								<button type="button" class="btn btn-default btn-xs btnDelete"
								value="${grade.sid }">삭제</button>
								<button type="button" class="btn btn-default btn-xs btnUpdate"
								value="${grade.sid }">수정</button>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<button type="button" class="btn btn-default btn-sm" role="badgeFrame">
					Count <span class="badge" role="badge">${count }</span>
				</button>
				<button type="button" class="btn btn-default btn-sm" role="badgeFrame"
				onclick="location.href='studentlist.action'">
				학생 정보
				</button>
			</div>
			
		</div>
		
	</div>
</div>

</body>
</html>