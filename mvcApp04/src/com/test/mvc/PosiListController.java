/*=================================================
	#71. PosiListController.java
	- 사용자 정의 컨트롤러 클래스
	- 직위 리스트 페이지 요청에 대한 액션 처리
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 자료형 구성
	  → setter 메소드 구성
=================================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class PosiListController implements Controller
{
	private IPositionDAO dao;
	
	public void setDao(IPositionDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리 과정 추가 (로그인에 대한 확인 과정) ----------------------
		HttpSession session = request.getSession();
		
		// 로그인이 되어있지 않은 상황
		if (session.getAttribute("name") == null)
		{
			// 로그인이 되어있지 않은 상황에서의 처리
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		// ---------------------- 세션 처리 과정 추가 (로그인에 대한 확인 과정)
		
		ArrayList<Position> positionList = new ArrayList<Position>();
		
		try
		{
			positionList = dao.list();
			
			mav.addObject("positionList", positionList);
			
			mav.setViewName("PosiList");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
