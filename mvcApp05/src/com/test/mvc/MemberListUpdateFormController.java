/*=====================================================================
	#10. MemberListUpdateFormController.java
	- 사용자 정의 컨트롤러 클래스
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 준비
======================================================================*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class MemberListUpdateFormController implements Controller
{
	private IMemberListDAO dao;
	
	public void setDao(IMemberListDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		// 이전 페이지(MemberList.jsp)로부터 데이터 수신
		String id = request.getParameter("id");
		
		try
		{
			MemberListDTO dto = new MemberListDTO();
			
			dto = dao.searchId(id);
			
			mav.addObject("dto", dto);
			
			mav.setViewName("MemberListUpdateForm");
			
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
