/*============================================
	#18. MemberRecordInsertFormController.java
	- 사용자 정의 컨트롤러 클래스
============================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class MemberRecordInsertFormController implements Controller
{
	private IMemberListDAO listDAO;
	//private IMemberRecordDAO recordDAO;
	
	public void setListDAO(IMemberListDAO listDAO)
	{
		this.listDAO = listDAO;
	}
	
//	public void setRecordDAO(IMemberRecordDAO recordDAO)
//	{
//		this.recordDAO = recordDAO;
//	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리과정 추가 ---------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name") == null)
		{
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		else if (session.getAttribute("admin") == null)
		{
			mav.setViewName("redirect:logout.action");
			return mav;
		}
		// --------------------------------------------------- 세션 처리과정 추가
		
		ArrayList<MemberListDTO> memberListDTO = new ArrayList<MemberListDTO>();
		//ArrayList<MemberRecordDTO> memberRecordDTO = new ArrayList<MemberRecordDTO>();
		
		// 이전 페이지(MemberList.jsp)로부터 데이터 수신
		//-- id, name
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		
		// 이전 페이지(MemberRecordList.jsp)로부터 데이터 수신
		//-- scoreId
		//String scoreId = request.getParameter("scoreId");
		
		try
		{
			memberListDTO = listDAO.list();
			//memberRecordDTO = recordDAO.list();
			
			mav.addObject("id", id);
			mav.addObject("name", name);
			//mav.addObject("scoreIda", scoreId);
			mav.addObject("memberListDTO", memberListDTO);
			//mav.addObject("memberRecordDTO", memberRecordDTO);
			
			mav.setViewName("MemberRecordInsertForm");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
