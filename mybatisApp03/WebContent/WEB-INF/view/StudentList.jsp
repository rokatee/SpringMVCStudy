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
<title>StudentList.jsp</title>
<!-- 뷰포트 메타엘리먼트로 구성 -->
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- jquery -->
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	$(function()
	{
		$(".btn-success").click(function()
		{
			$(location).attr("href", "studentupdateform.action?sid=" + $(this).val());

		});

		$(".btn-danger").click(function()
		{
			if (confirm("정말 삭제하시겠습니까?"))
				$(location).attr("href", "studentdelete.action?sid=" + $(this).val());

		});
	});
</script>
</head>
<body>

<div class="panel title">
	<h1>성적관리(SpringMVC + Annotation + Mybatis 버전)</h1>
</div>

<!-- 메인 메뉴 영역 -->
<nav class="navbar navbar-default">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">Home</a>
		</div>

		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active">
					<a href="studentlist.action"> 
						학생 관리 <span class="sr-only">(current)</span>
					</a>
				</li>
			</ul>
			<ul class="nav navbar-nav">
				<li>
					<a href="gradelist.action">성적 관리</a>
				</li>
			</ul>
		</div> <!-- .collapse navbar-collapse -->

	</div> <!-- .container-fluid -->
</nav> <!-- .navbar navbar-default -->


<div class="container">
	<div class="panel-group">
		<div class="panel panel-default">
			<div class="panel-heading row">
				<span style="font-size: 17pt; font-weight: bold;" class="col-md-3">
					학생 리스트 출력
				</span> 
				<span class="col-md-9"> 
					<a href="studentinsertform.action" role="button"
					class="btn btn-success btn-sx" id="btnAdd"
					style="vertical-align: bottom;"> 
						학생추가 
					</a>
				</span>
			</div> <!-- .panel-heading row -->

			<div class="panel-body">
				전체 학생 수 
				<!-- <span class="badge">3</span> -->
				<span class="badge">${count }</span>
			</div> <!-- .panel-body -->

			<div class="panel-body">
				<table class="table table-hover table-striped">
					<thead>
						<tr class="trTitle">
							<th>번호</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>성적 입력 여부</th>
							<th>수정 및 삭제</th>
						</tr>
						<!-- .trTitle -->
					</thead>
					
					<tbody>
						<!-- 	
						<tr>
							<td>1</td>
							<td>민찬우</td>
							<td>010-1111-1111</td>
							<td>0</td>
							<td>
								<button type="button" class="btn btn-success">수정</button>
								<button type="button" class="btn btn-danger">삭제</button>
							</td>
						</tr>
						<tr>
							<td>2</td>
							<td>유동현</td>
							<td>010-2222-2222</td>
							<td>1</td>
							<td>
								<button type="button" class="btn btn-success">수정</button>
								<button type="button" class="btn btn-danger">삭제</button>
							</td>
						</tr>
						<tr>
							<td>3</td>
							<td>김태민</td>
							<td>010-3333-3333</td>
							<td>1</td>
							<td>
								<button type="button" class="btn btn-success">수정</button>
								<button type="button" class="btn btn-danger">삭제</button>
							</td>
						</tr>
						-->
						<c:forEach var="student" items="${list }">
						<tr>
							<td>${student.sid }</td>
							<td>${student.name }</td>
							<td>${student.tel }</td>
							<c:if test="${student.sub == 0 }">
							<td>X</td>
							</c:if>
							<c:if test="${student.sub == 1 }">
							<td>O</td>
							</c:if>
							<td>
								<button type="button" class="btn btn-success" value="${student.sid }">수정</button>
								<c:if test="${student.sub == 0 }">
								<button type="button" class="btn btn-danger" value="${student.sid }">삭제</button>
								</c:if>
								<c:if test="${student.sub == 1 }">
								<button type="button" class="btn btn-danger" value="${student.sid }" disabled="disabled">삭제</button>
								</c:if>
							</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div> <!-- .panel-body -->

		</div> <!-- .panel panel-default -->
	</div> <!-- .panel-group -->
</div> <!-- .container -->


</body>
</html>