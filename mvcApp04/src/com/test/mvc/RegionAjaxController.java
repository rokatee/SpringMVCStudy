/*=================================================
	#38. RegionAjaxController.java
	- 사용자 정의 컨트롤러 클래스
	- 지역 리스트의 지역명 중복검사 결과 반환 액션
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

public class RegionAjaxController implements Controller
{
	private IRegionDAO dao;
	
	public void setDao(IRegionDAO dao)
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
	
		// 이전 페이지(RegionInsertForm.jsp) 로부터 데이터 수신
		//-- regionName
		String regionName = request.getParameter("regionName");
		
		ArrayList<Region> regionList = new ArrayList<Region>();
		
		String regionResult = "";
		
		try
		{
			regionList = dao.list();
			
			for (Region region : regionList)
			{
				if(region.getRegionName().equals(regionName))
				{
					regionResult = "이미 사용중인 지역명이 존재합니다";
					break;
				}
				else
				{
					regionResult = "사용할 수 있는 지역명입니다.";
				}
			}
			
			mav.addObject("regionResult", regionResult);
			
			mav.setViewName("RegionAjax");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
