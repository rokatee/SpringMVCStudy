/*
#12. LoginController.java
	- 사용자 정의 컨트롤러 클래스
*/

package com.mem.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import com.mem.model.IMemberDAO;

public class LoginController implements Controller
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
		
		// 이전 페이지(LoginForm.jsp)로부터 데이터 수신
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String gradeStr = request.getParameter("grade");
		
		int grade = Integer.parseInt(gradeStr);
		
		String name = null;
		
		try
		{
			if (grade==1)
			{
				name = dao.login(id, pw);
			}
			else if (grade==0)
			{
				name = dao.AdminLogin(id, pw);
			}
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// 로그인 성공 여부에 따른 view 분기 처리
		if (name=="")
		{
			// 로그인 실패
			mav.setViewName("redirect:loginform.action");
			
		}
		else
		{
			// 로그인 성공 : 관리자 여부 확인
			
			HttpSession session = request.getSession();
			session.setAttribute("name", name);
			session.setAttribute("id", id);
			
			if (grade==1)
			{
				// 일반 학생
				mav.setViewName("redirect:memberlist.action");
				
			} else
			{
				// 관리자
				session.setAttribute("admin", "");
				
				mav.setViewName("redirect:memberlist.action");
			}
		}
		
		return mav;
	}
	
}
