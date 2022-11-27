/*=================================================
	#49. DepartmentAjaxController.java
	- 사용자 정의 컨트롤러 클래스
	- 부서 리스트의 부서명 중복검사 결과 반환 액션
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

public class DepartmentAjaxController implements Controller
{
	private IDepartmentDAO dao;
	
	public void setDao(IDepartmentDAO dao)
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
	
		// 이전 페이지(DepartmentInsertForm.jsp) 로부터 데이터 수신
		//-- departmentName
		String departmentName = request.getParameter("departmentName");
		
		ArrayList<Department> departmentList = new ArrayList<Department>();
		
		String departmentResult = "";
		
		try
		{
			departmentList = dao.list();
			
			for (Department department : departmentList)
			{
				if(department.getDepartmentName().equals(departmentName))
				{
					departmentResult = "이미 사용중인 부서명이 존재합니다";
					break;
				}
				else
				{
					departmentResult = "사용할 수 있는 부서명입니다.";
				}
			}
			
			mav.addObject("departmentResult", departmentResult);
			
			mav.setViewName("DepartmentAjax");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
