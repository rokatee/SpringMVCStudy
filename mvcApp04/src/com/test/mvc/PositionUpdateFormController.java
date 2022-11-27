/*=====================================================================
	#64. PositionUpdateFormController.java
	- 사용자 정의 컨트롤러 클래스
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 준비
======================================================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class PositionUpdateFormController implements Controller
{
	// 주요 속성 구성
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
		
		ArrayList<Position> positionList = new ArrayList<Position>();

		// 위의 list 값들을 각각의 dao 한테서 얻어내야 한다.
		// updateformController는 insertformController와는 달리
		// 일단 먼저 data를 일단 수신해야한다.
		
		// 이전 페이지(PositionList.jsp)로부터 데이터 수신
		//-- positionId 
		String positionId = request.getParameter("positionId");
		String positionName = request.getParameter("positionName");

		try
		{
			positionList = dao.list();
			
			mav.addObject("positionId", positionId);
			mav.addObject("positionName", positionName);
			mav.addObject("positionList", positionList);

			mav.setViewName("PositionUpdateForm");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		
		
		return mav;
	}
	
}
