/*=================================
	HelloController.java
	- 사용자 정의 컨트롤러 클래스
==================================*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class HelloController implements Controller
{
	// Controller 인터페이스의 handleRequest() 메소드 재정의
	// 예전에 servlet 할 때 doGetPost() 역할을 얘가 하고 있는 거
	@Override
	public ModelAndView handleRequest(HttpServletRequest arg0, HttpServletResponse arg1) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		String message = "Hello, Spring MVC World~!!";
		
		mav.addObject("message", message);
		mav.setViewName("/WEB-INF/view/Hello.jsp");
		
		return mav;
	}
	
}
