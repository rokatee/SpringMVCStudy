/*=======================================================
	#30. LoginController.java.java
	- 사용자 정의 컨트롤러 클래스
	- 로그인 액션 처리 전용 클래스
	- 로그인 액션 처리 이후
	  『employeelist.action』 / 『emplist.action』 을 요청할 수 있도록 안내.
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
		
		// 이전 페이지(LoginForm.jsp)로부터 데이터 수신
		//-- id(employeeId), pw(ssn2), admin
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String admin = request.getParameter("admin");
		
		String name = null;
		
		try
		{
			// 로그인 처리 → 처리 대상에 따른 로그인 처리 방식 분기 / 구분
			// → 메소드 따로따로 만들어놨기 때문에
			// 일반사원은 일반사원대로 로그인
			if(admin == null)
			{
				// 일반사원 로그인
				name = dao.login(id, pw);
			}
			else
			{
				// 관리자 로그인
				name = dao.loginAdmin(id, pw);
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// 로그인 성공했는지 실패했는지에 대한 분기
		// 로그인 수행에 따른 성공 여부 확인 및 구분 / 분기
		if (name == null)
		{
			// 로그인 실패 → 로그인 폼을 다시 요청할 수 있도록 안내
			mav.setViewName("redirect:loginform.action");
		}
		else
		{
			// 로그인 성공 → 세션 구성 → 리스트 페이지를 다시 요청할 수 있도록 안내
			HttpSession session = request.getSession();
			session.setAttribute("name", name);
			
			// 로그인 성공한 것도, 관리자/일반직원 분기 해줘야 한다.
			// 관리자인지 일반 직원인지의 여부 확인
			// 이름을 얻어내서 아래 조건 확인
			// 이름을 얻어내고, admin 이 null 인지 확인
			if (admin == null)		//-- 일반 직원으로 로그인을 성공한 상황
			{
				// emplist.action 페이지를 요청할 수 있도록 안내
				mav.setViewName("redirect:emplist.action");
			}
			else					//-- 관리자로 로그인을 성공한 상황
			{
				// line 81 에서 name 속성만 넣었기 때문에
				// admin 속성을 세션에 추가
				session.setAttribute("admin", "");
				
				// employeelist.action 페이지를 요청할 수 있도록 안내
				mav.setViewName("redirect:employeelist.action");
			}
		}
		
		return mav;
	}
	
}
