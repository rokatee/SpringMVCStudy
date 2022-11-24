/*=================================================
	#60. PositionAjaxController.java
	- 사용자 정의 컨트롤러 클래스
	- 직위 리스트의 직위명 중복검사 결과 반환 액션
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 자료형 구성
	  → setter 메소드 정의
==================================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class PositionAjaxController implements Controller
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
	
		// 이전 페이지(PositionInsertForm.jsp) 로부터 데이터 수신
		//-- positionName
		String positionName = request.getParameter("positionName");
		
		ArrayList<Position> positionList = new ArrayList<Position>();
		
		String positionResult = "";
		
		try
		{
			positionList = dao.list();
			
			for (Position position : positionList)
			{
				if(position.getPositionName().equals(positionName))
				{
					positionResult = "이미 사용중인 직위명이 존재합니다";
					break;
				}
				else
				{
					positionResult = "사용할 수 있는 직위명입니다.";
				}
			}
			
			mav.addObject("positionResult", positionResult);
			
			mav.setViewName("PositionAjax");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
