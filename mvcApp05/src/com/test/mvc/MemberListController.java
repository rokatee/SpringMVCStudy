/*===========================================================
	#04. MemberListController.java
	- 사용자 정의 컨트롤러 클래스
	- 리스트 페이지 요청에 대한 액션 처리
	  (관리자 전용)
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 준비
============================================================*/
package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class MemberListController implements Controller
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
		
		ArrayList<MemberListDTO> memberList = new ArrayList<MemberListDTO>();
		
		try
		{
			memberList = dao.list();
			
			mav.addObject("memberList", memberList);
			
			mav.setViewName("MemberList");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
