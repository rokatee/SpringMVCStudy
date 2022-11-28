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
<title>Menu.jsp</title>
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	.header
	{
		height: 70px;
		width: 100%;
		background: #BDBDBD;
		color: white;
	}
	h1
	{
		color: #086A87;
		font-weight: bold;
		float: left;
		margin: 15px 20px;
	}
	.menu
	{
		float: right;
	}
	a
	{
		color: white;
		font-size: 20px;
		font-weight: bold;
		float: right;
		padding-top: 20px;
		padding: 20px;
	}
	a:hover 
	{
		color: #086A87;
		text-decoration: none;
	}
</style>
</head>
<body>

<!-- #10. Menu.jsp -->

<div class="header">
	<h1>mvcApp05</h1>
	<div class="menu">
		<a href="logout.action">Logout</a>
		<a href="recordlist.action">Score</a>
		<a href="memberlist.action">Member</a>
	</div>
</div>

</body>
</html>