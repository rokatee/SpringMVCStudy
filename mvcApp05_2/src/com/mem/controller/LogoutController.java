/*
#36. LogoutController.java
	- 사용자 정의 컨트롤러 클래스
*/

package com.mem.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring이 제공하는 『Controller』 인터페이스를 구현함으로써
//	  사용자 정의 컨트롤러 클래스를 구성한다.

public class LogoutController implements Controller
{

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		session.removeAttribute("name");
		session.removeAttribute("admin");
		
		mav.setViewName("redirect:loginform.action");
		
		return mav;
	}
	
}
