/*=================================================
	#26. MemberListAjaxController.java
	- 사용자 정의 컨트롤러 클래스
	- 학생 리스트의 아이디 중복검사 결과 반환 액션
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 자료형 구성
	  → setter 메소드 정의
==================================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class MemberListAjaxController implements Controller
{
	private IMemberListDAO dao;
	
	public void setDao(IMemberListDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();
		
		ArrayList<MemberListDTO> memberListDTO = new ArrayList<MemberListDTO>();

		// 이전 페이지(MemberListInsertForm.jsp)로부터 데이터 수신
		//-- id
		String id = request.getParameter("id");
		
		String idResult = "";
		
		try
		{
			memberListDTO = dao.list();
			
			for (MemberListDTO memberList : memberListDTO)
			{
				if(memberList.getId().equals(id))
				{
					idResult = "이미 사용 중인 아이디 입니다.";
					break;
				}
				else
				{
					idResult = "사용할 수 있는 아이디 입니다.";
				}
			}
			
			mav.addObject("idResult", idResult);
			
			mav.setViewName("MemberListAjax");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
