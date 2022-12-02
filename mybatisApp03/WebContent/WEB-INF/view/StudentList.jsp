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
<title>StudentList.jsp</title>

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
			$(location).attr("href", "studentupdate.action?sid=" + $(this).val());
			
		});
		
		$(".btnDelete").click(function()
		{
			if (confirm("정말 삭제하시겠습니까?"))
				/* $(location).attr("href", "studentdelete.action?sid=" + $(this).val); */
				$(location).attr("href", "studentdelete.action?sid=" + $(this).val());

		});
	});
</script>
</head>
<body>

<div class="panel title">
	<h1>성적관리(SpringMVC + Annotation + Mybatis 버전)</h1>
</div>

<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
			
			<div class="panel-heading" id="title">
				학생 정보 입력
			</div>
			
			<div class="panel-body">
				<form role="form" action="studentinsert.action" method="post">
				<!-- <form id="studentForm" role="form" action="studentinsert.action" method="post"> -->
					
					<!-- name 속성 값이 컨트롤러로 바인딩되어 들어가야 한다. -->
					<div class="form-group">
						<label for="name">
							NAME : 
						</label>
						<input type="text" class="form-control" id="name" name="name"/>
					</div>
					
					<div class="form-group">
						<label for="tel">
							TELEPHONE :
						</label>
						<input type="tel" class="form-control" id="tel" name="tel"/>
					</div>
					
					<button type="submit" class="btn btn-default btn-sm">SUBMIT</button>
					<button type="reset" class="btn btn-default btn-sm btnCancel">CANCEL</button>
					
				</form>
			</div>
			
		</div><!-- close .panel .panel-default -->
		
		<div class="panel panel-default">
			
			<div class="panel-heading">
				학생 정보 출력
			</div>
			
			<div class="panel-body">
				<table class="table">
					<thead>
						<tr>
							<th>SID</th>
							<th>NAME</th>
							<th>TELEPHONE</th>
							<th>SUB</th>
							<th>삭제 / 수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="student" items="${list }">
						<tr>
							<td>${student.sid }</td>
							<td>${student.name }</td>
							<td>${student.tel }</td>
							<td>${student.sub }</td>
							<td>
								<button type="button" class="btn btn-default btn-xs btnDelete"
								value="${student.sid }">삭제</button>
								<button type="button" class="btn btn-default btn-xs btnUpdate"
								value="${student.sid }">수정</button>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<button type="button" class="btn btn-default btn-sm" role="badgeFrame">
					Count <span class="badge" role="badge">${count }</span>
				</button>
				<button type="button" class="btn btn-default btn-sm" role="badgeFrame"
				onclick="location.href='gradelist.action'">
				성적 정보
				</button>
			</div>
			
		</div>
		
	</div>
</div>

</body>
</html>