/*
#25. MemberUpdateController.java
	- 사용자 정의 컨트롤러 클래스
*/

package com.mem.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.mem.model.IMemberDAO;
import com.mem.model.Member;

// ※ Spring이 제공하는 『Controller』 인터페이스를 구현함으로써
//	  사용자 정의 컨트롤러 클래스를 구성한다.

public class MemberUpdateController implements Controller
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
		// -- id, pw, name, tel, email, grade
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String tel = request.getParameter("tel");
		String email = request.getParameter("email");
		String grade = request.getParameter("grade");
		
		try
		{
			Member member = new Member();
			
			member.setId(id);
			member.setPw(pw);
			member.setName(name);
			member.setTel(tel);
			member.setEmail(email);
			member.setGrade(Integer.parseInt(grade));
			
			dao.modify(member);
			
			mav.setViewName("redirect:memberlist.action");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
