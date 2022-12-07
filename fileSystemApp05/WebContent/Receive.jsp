<%@page import="java.io.DataInputStream"%>
<%@page import="java.util.Enumeration"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	// Receive.jsp
								// ┏어떤 컨텐트로 되어있는지 확인
	String contentType = request.getContentType();
	Enumeration e = request.getHeaderNames();
	
	out.println("contentType : " + contentType + "<br><br>");
	
	out.println("[[ 브라우저로부터 날아오는 헤더 정보들 ]]<br><br>");
	
	while(e.hasMoreElements())
	{
		String key = (String)e.nextElement();
		String value = request.getHeader(key);
		
		out.println(key + " : " + value + "<br>");
	}
	
	out.println("<br>[[ request 로 넘어오는 데이터들 ]]<br><br>");
	
	DataInputStream di = new DataInputStream(request.getInputStream());
	String line = null;
	while( (line = di.readLine() ) != null )
	{
		//out.println(new String(line.getBytes("UTF-8"), "UTF-8" ) + "<br>" );
		// --> 한글이 깨져 나옴
		out.println(new String(line.getBytes("ISO-8859-1"), "UTF-8") + "<br>");
		// --> 한글까지 모두 온전하게 나옴
	}
	
	
	
%>