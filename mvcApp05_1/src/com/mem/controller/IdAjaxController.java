/*
#18. IdAjaxController.java
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

public class IdAjaxController implements Controller
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
		else if (session.getAttribute("admin")==null)
		{
			mav.setViewName("redirect:logout.action");
			return mav;
		}
		// ------------------------------------------------------------------- 로그인 여부 확인
		
		// 이전 페이지(MemberInsertForm.jsp)로부터 데이터 수신
		// -- id
		String id = request.getParameter("id");
		
		ArrayList<Member> memberList = new ArrayList<Member>();
		String result = "";
		
		try
		{
			memberList = dao.list();
			
			for (Member member : memberList)
			{
				if (member.getId().equals(id))
				{
					result = "이미 존재하는 아이디입니다.";
					break;
				}
				else
				{
					result = "사용 가능한 아이디입니다.";
				}
				
			}

			mav.addObject("result", result);
			mav.setViewName("IdAjax");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
