/*==================================================================================================
	#22. MemberRecordDeleteController.java
	- 사용자 정의 컨트롤러 클래스
	- 성적 데이터 삭제 액션 처리 → 처리 후 memberrecordlist.action 을 다시 요청할 수 있도록 안내
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 구성
==================================================================================================*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class MemberRecordDeleteController implements Controller
{
	private IMemberRecordDAO dao;

	public void setDao(IMemberRecordDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리과정 추가 ---------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name") == null)
		{
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		else if (session.getAttribute("admin") == null)
		{
			mav.setViewName("redirect:logout.action");
			return mav;
		}
		// --------------------------------------------------- 세션 처리과정 추가
		
		// 이전 페이지(MemberRecordList.jsp)로부터 데이터 수신
		//-- id
		String id = request.getParameter("id");
		
		try
		{
			dao.remove(id);
			
			mav.setViewName("redirect:memberrecordlist.action");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
