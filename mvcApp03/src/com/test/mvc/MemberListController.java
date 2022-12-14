/*=================================
	MemberListController.java
	- 사용자 정의 컨트롤러
	- 리스트 출력 액션
	- DAO 객체에 대한 의존성 주입
	  준비 → setter 메소드 추가
==================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class MemberListController implements Controller
{
	// ※ DAO 객체에 대한 의존성 주입을 위한 준비
	
	// 인터페이스 자료형을 취하는 속성 구성
	private IMemberDAO dao;
	
	// setter 메소드 구성
	public void setDao(IMemberDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse responses) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		
		ModelAndView mav = new ModelAndView();
		
		// 주입받은 setter 통해서 작업
		int count = 0;
		ArrayList<MemberDTO> memberList = new ArrayList<MemberDTO>();
		
		try
		{
			count = dao.count();
			memberList = dao.list();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// MemberList.jsp 뷰한테 count와 memberList 넘겨줌
		mav.setViewName("/WEB-INF/view/MemberList.jsp");
		mav.addObject("count", count);
		mav.addObject("memberList", memberList);
		
		return mav;
	}
	
}
