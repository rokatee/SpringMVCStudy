<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	//Test_ok.jsp
	
	//
	String root = pageContext.getServletContext().getRealPath("/");
	String savePath = root + "pds" + File.separator + "saveFile";
	
	//서버에 제대로 업로드됐는지 확인하기 위해서
	System.out.println(savePath);
	//-- 콘솔에 찍히는 경로 따서 들어가서 확인해보면 된다.
	//   이 경로 따서 <img> 태그로 감싸주면 이미지 얻어낼 수 있다.

	String encType = "UTF-8";		// 인코딩 방식
	int maxFileSize = 5*1024*1024;	// 업로드 파일 최대 용량 5mb
	
	// 구성한 경로를 기반으로 파일 객체 생성
	File dir = new File(savePath);
	
	// 지정한 경로대로 디렉터리가 존재하지 않는 상황이라면
	if (!dir.exists())
		dir.mkdirs();
		// 디렉터리 생성
	
	MultipartRequest req = null;
	
	try
	{
		req = new MultipartRequest(request, savePath, maxFileSize, encType, new DefaultFileRenamePolicy());
		
		out.println("<h2>작성자 : " + req.getParameter("userName") + "</h2>" + "<br>");
		out.println("<h2>제목 : " + req.getParameter("subject") + "</h2>" + "<br>");
		out.println("***********************************************************<br>");
		
		out.println("<h2>업로드된 파일</h2><br>");
		
		// check~!!! ★★★
		// 다중 파일 업로드 구조에서 체크해야 할 사항
		// MultipartRequest 객체의 『getFileNames()』
		// → 요청으로 넘어온 파일들의 이름을 Enumeration 타입으로 반환 
		Enumeration files = req.getFileNames();
		
		while(files.hasMoreElements())
		{
			String name = (String)files.nextElement();
			if (req.getFilesystemName(name) != null)
			{
				out.println("<h3>서버에 저장된 파일명 : " + req.getFilesystemName(name) + "</h3>" + "<br>");
				out.println("<h3>업로드한 실제 파일명 : " + req.getOriginalFileName(name) + "</h3>" + "<br>");
				out.println("<h3>파일 타입 : " + req.getContentType(name) + "</h3>" + "<br>");
				
				File f = req.getFile(name);
				
				if (f != null)
					out.println("<h3>파일 크기 : " + f.length() + " Bytes. </h3><br>");
					out.println("----------------------------------------------------<br>");
			}
			
		}
	}
	catch(Exception e)
	{
		System.out.println(e.toString());
	}
%>