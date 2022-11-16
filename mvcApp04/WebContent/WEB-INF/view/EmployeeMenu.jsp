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
<title>EmployeeMenu.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	.btn-group {width: 100%;}
	.menubtn {width: 20%; font-weight: bold;}
</style>

<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery.min.js"></script>
</head>
<body>

<!--------------------------------------------------
    #13. EmployeeMenu.jsp
   -메인 메뉴 페이지 구성
    -로그아웃 기능(버튼) 추가 구성
---------------------------------------------------->

<div class="btn-group" role="group">
   <a href="" role="button" class="menubtn btn-success btn-lg">직원 관리</a>
   <a href="" role="button" class="menubtn btn-success btn-lg">지역 관리</a>
   <a href="" role="button" class="menubtn btn-success btn-lg">부서 관리</a>
   <a href="" role="button" class="menubtn btn-success btn-lg">직위 관리</a>
   
   <a href="" class="menu  btn btn-success btn-lg">로그 아웃</a>
   
</div>


</body>
</html>