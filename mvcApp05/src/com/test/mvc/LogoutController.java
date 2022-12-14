/*===================================================================
	#33. LogoutController.java
	- 사용자 정의 컨트롤러 클래스
	- 로그아웃 액션 처리 → 다시 로그인 폼을 요청할 수 있도록 안내
====================================================================*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class LogoutController implements Controller
{
	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession();
		
		// 방법 1
		//session.invalidate();
		
		// 방법 2
		//session.setAttribute(name, null);
		
		session.removeAttribute("name");
		session.removeAttribute("admin");
		
		mav.setViewName("redirect:loginform.action");
		
		return mav;
	}
	
}
