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
<title>GradeInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
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
				<li>
					<a href="studentlist.action">학생 관리</a>
				</li>
			</ul>
			<ul class="nav navbar-nav">
				<li class="active">
					<a href="gradelist.action"> 
						성적 관리 <span class="sr-only">(current)</span>
					</a>
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
					성적 데이터 입력
				</span>
				<span class="col-md-9">
					<a href="gradelist.action" role="button"
					class="btn btn-success btn-sx" id="btnAdd"
					style="vertical-align: bottom;">
						성적 리스트 출력
					</a>
				</span>
			</div> <!-- .panel-heading row -->

			<div class="panel-body">
				
				<form action="gradeinsert.action" method="post" id="myForm">
					<table class="table table-striped">
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon1">
										번호
										<sup style="color: red;">※</sup>
									</span>
									<input type="text" id="sid" name="sid" class="form-control"
									value="${sid }" maxlength="30">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon2">
										과목1
										<sup style="color: red;">※</sup>
									</span>
									<input type="text" id="sub1" name="sub1" class="form-control"
									placeholder="sub1" maxlength="30" required="required">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon3">
										과목2
										<sup style="color: red;">※</sup>
									</span>
									<input type="text" id="sub2" name="sub2" class="form-control"
									placeholder="sub2" maxlength="30" required="required">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td>
								<div class="input-group" role="group">
									<span class="input-group-addon" id="basic-addon4">
										과목3
										<sup style="color: red;">※</sup>
									</span>
									<input type="text" id="sub3" name="sub3" class="form-control"
									placeholder="sub3" maxlength="30" required="required">
									<span class="input-group-addon"></span>
								</div>
							</td>
						</tr>
						
						<tr style="height: 10px;">
						</tr>
						
						<tr>
							<td colspan="2" style="text-align: center;">
								<button type="submit" class="btn btn-success">등록</button>
								<button type="reset" class="btn btn-default">취소</button>
								<br />
								
								<span style="font-size: small;">(※)는 필수입력 사항입니다.</span>
								<span style="font-size: small; color: red; display: none;">
									필수 입력 사항을 모두 입력해야 합니다
								</span>
								
							</td>
						</tr>
						
					</table>
					
					
				</form>
				
			</div> <!-- .panel-body -->

		</div> <!-- .panel panel-default -->
	</div> <!-- .panel-group -->
</div> <!-- .container -->


</body>
</html>