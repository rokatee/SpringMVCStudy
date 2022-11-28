/*
#14. MemberListController.java
	- 사용자 정의 컨트롤러 클래스
*/

package com.mem.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.mem.model.IMemberDAO;
import com.mem.model.Member;

// ※ Spring이 제공하는 『Controller』 인터페이스를 구현함으로써
//	  사용자 정의 컨트롤러 클래스를 구성한다.

public class MemberListController implements Controller
{
	private IMemberDAO dao;
	
	public void setDao(IMemberDAO dao)
	{
		this.dao = dao;
	}

	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		
		ModelAndView mav = new ModelAndView();
		
		// 로그인 여부 확인 -------------------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name")==null)
		{
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		
		// ------------------------------------------------------------------- 로그인 여부 확인
		
		ArrayList<Member> memberList = new ArrayList<Member>();
		
		// 관리자 로그인 여부에 따른 분기
		if (session.getAttribute("admin")==null)
		{
			try
			{
				memberList = dao.list();
				
				mav.addObject("memberList", memberList);
				mav.setViewName("MemList");
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
		}
		else
		{
			try
			{
				memberList = dao.list();
				
				mav.addObject("memberList", memberList);
				mav.setViewName("MemberList");
				
			} catch (Exception e)
			{
				System.out.println(e.toString());
			}
		}
		
		return mav;
	}
	
}
