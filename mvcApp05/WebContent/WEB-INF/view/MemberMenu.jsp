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
<title>MemberMenu.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">

   .btn-group{width: 100%;}
   .menubtn {width: 20%; font-weight: bold;}
   
</style>
</head>
<body>
<!--------------------------------------------------
    #04. MemberMenu.jsp
    - 메인 메뉴 페이지 구성
    - 로그아웃 기능(버튼) 추가 구성
---------------------------------------------------->
<div class="btn-group" role="group">
   <a href="memberlist.action" role="button" class="menubtn btn btn-success btn-lg">학생 관리</a>
   <a href="memberrecordlist.action" role="button" class="menubtn btn btn-success btn-lg">성적 관리</a>
   
   <a href="logout.action" class="menubtn btn btn-success btn-lg">로그 아웃</a>
</div>

<%-- <span>${sessionScope.admin==null ? "normal" : "admin" }</span> --%>
<%-- 
<c:choose>
	<c:when test = "${sessionScope.admin != null }">
		<div class="btn-group" role="group">
		   <a href="memberlist.action" role="button" class="menubtn btn btn-success btn-lg">학생 관리</a>
		   <a href="memberrecordlist.action" role="button" class="menubtn btn btn-success btn-lg">성적 관리</a>
		   
		   <a href="logout.action" class="menubtn btn btn-success btn-lg">로그 아웃</a>
		</div>
	</c:when>
	<c:otherwise>
		<div class="btn-group" role="group">
		   <a href="memlist.action" role="button" class="menubtn btn btn-success btn-lg">학생 정보</a>
		   <a href="memreclist.action" role="button" class="menubtn btn btn-success btn-lg">성적 정보</a>
		   <a href="logout.action" class="menubtn btn btn-success btn-lg">로그 아웃</a>
		</div>
	</c:otherwise>
</c:choose>
--%>
</body>
</html>