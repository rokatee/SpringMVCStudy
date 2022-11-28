/*=========================================================
	#32. LoginController.java.java
	- 사용자 정의 컨트롤러 클래스
	- 로그인 액션 처리 전용 클래스
	- 로그인 액션 처리 이후
	  『memberlist.action』 / 『memlist.action』 을 요청할 수 있도록 안내.
	- DAO 에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 구성
========================================================*/
package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class LoginController implements Controller
{
	private IMemberListDAO listDAO;
	private IMemberRecordDAO recordDAO;
	
	public void setListDAO(IMemberListDAO listDAO)
	{
		this.listDAO = listDAO;
	}

	public void setRecordDAO(IMemberRecordDAO recordDAO)
	{
		this.recordDAO = recordDAO;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		// 이전 페이지(LoginForm.jsp)로부터 데이터 수신
		//-- id, pw, admin
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String admin = request.getParameter("admin");
		
		String name = null;
		
		try
		{
			if (admin == null)
			{
				name = listDAO.login(id, pw);
			}
			else
			{
				name = listDAO.loginAdmin(id, pw);				
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		if (name == null)
		{
			mav.setViewName("redirect:loginform.action");
		}
		else
		{
			HttpSession session = request.getSession();
			session.setAttribute("name", name);
			
			if (admin == null)
			{
				mav.setViewName("redirect:memlist.action");
			}
			else
			{
				session.setAttribute("admin", "");
				
				mav.setViewName("redirect:memberlist.action");
			}
		}
		
		return mav;
	}
	
}
