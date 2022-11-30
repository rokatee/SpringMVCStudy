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
<title>Sidebar.jsp</title>
</head>
<body>
	<!-- Sidebar -->
	<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
	
	    <!-- Sidebar - Brand -->
	    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="<%=cp %>/tables.jsp">
	        <div class="sidebar-brand-icon rotate-n-15">
	            <i class="fas fa-laugh-wink"></i>
	        </div>
	        <div class="sidebar-brand-text mx-3">성적관리<br>프로그램</div>
	    </a>
	
	    <!-- Divider -->
	    <hr class="sidebar-divider my-0">
	
	    <!-- Nav Item - Dashboard -->
	    <li class="nav-item">
	        <a class="nav-link" href="<%=cp %>/tables.jsp">
	            <i class="fas fa-fw fa-tachometer-alt"></i>
	            <span>쌍용교육센터</span>
			</a>
	    </li>
	
	    <!-- Divider -->
	    <hr class="sidebar-divider">
	
	    <!-- Heading -->
	    <div class="sidebar-heading">
	        메    뉴
	    </div>
	
	    <!-- Nav Item - Tables -->
	    <li class="nav-item active">
	        <a class="nav-link" href="tables.html">
	            <i class="fas fa-fw fa-table"></i>
	            <span>내 정보(학생 / 교수)</span>
			</a>
	    </li>
	
	    <li class="nav-item active">
	        <a class="nav-link" href="tables.html">
	            <i class="fas fa-fw fa-table"></i>
	            <span>교수 / 학생 평가</span>
			</a>
	    </li>
	
	    <li class="nav-item active">
	        <a class="nav-link" href="tables.html">
	            <i class="fas fa-fw fa-table"></i>
	            <span>교수 정보</span>
			</a>
	    </li>
	
	    <li class="nav-item active">
	        <a class="nav-link" href="tables.html">
	            <i class="fas fa-fw fa-table"></i>
	            <span>학생 정보</span>
			</a>
	    </li>
	
	    <!-- Divider -->
	    <hr class="sidebar-divider d-none d-md-block">
	
	    <!-- Sidebar Toggler (Sidebar) -->
	    <div class="text-center d-none d-md-inline">
	        <button class="rounded-circle border-0" id="sidebarToggle"></button>
	    </div>
	
	</ul>
	<!-- End of Sidebar -->
</body>
</html>