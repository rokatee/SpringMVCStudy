/*=================================
	#21. AjaxController.java
	- 사용자 정의 컨트롤러 클래스
==================================*/
/*
	EmployeeDAO.java 에 만들어놨던 내용 중에
	직위 아이디에 따른 최소 기본급 확인/검색해주는 메소드를 비즈니스 로직삼아서 일함 
	→ getMinBasicpay()
	그 값을 Ajax.jsp 에 두면 된다.

*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class AjaxController implements Controller
{
	private IEmployeeDAO dao;
	
	public void setDao(IEmployeeDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리과정 추가 -----------------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name") == null)		// 로그인이 되어있지 않은 상황
		{
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		else if (session.getAttribute("admin") == null)	// 로그인은 되었지만 관리자가 아닌 상황
		{
			mav.setViewName("redirect:logout.action");
			return mav;
		}
		// ----------------------------------------------------------------- 세션 처리과정 추가
	
		// 이전 페이지(EmployeeInsertForm.jsp) 로부터 데이터 수신
		//-- positionId
		String positionId = request.getParameter("positionId");
		int result = 0;
		
		try
		{
			result = dao.getMinBasicPay(positionId);
			
			mav.addObject("result", result);
			
			mav.setViewName("Ajax");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
