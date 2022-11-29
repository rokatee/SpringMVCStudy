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
<title>MemberInsertForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/main.css">
</head>
<body>

<div>
	<h1>회원 등록</h1>
	<hr />
	
	<h2><a href="memberlist.action">회원 리스트</a></h2>
</div>

<div>
	<form action="memberinsert.action" method="post">
		<table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="id" />
				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" name="pw" />
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="name" />
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="tel" name="tel" />
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="email" name="email" />
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">입력</button>
				</td>
			</tr>
		</table>
	</form>
</div>

</body>
</html>