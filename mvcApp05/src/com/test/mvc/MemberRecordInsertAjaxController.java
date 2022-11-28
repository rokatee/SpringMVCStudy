/*=================================================
	#28. MemberRecordInsertAjaxController.java
	- 사용자 정의 컨트롤러 클래스
	- 성적 리스트의 아이디 유무검사 결과 반환 액션
	- 점수 입력칸에 숫자 유효성 검사 반환 액션
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

public class MemberRecordInsertAjaxController implements Controller
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
		
		// 이전 페이지(MemberRecordListForm.jsp)로부터 데이터 수신
		//-- id
		String id = request.getParameter("id");

		ArrayList<MemberListDTO> memberListDTO = new ArrayList<MemberListDTO>();
		
		String result = "";
		
		try
		{
			memberListDTO = dao.list();

			for (MemberListDTO memberList : memberListDTO)
			{
				if(memberList.getId().equals(id))
				{

					if(memberList.getDelCheck() == 0 )
					{
						result = "성적 등록이 가능한 아이디 입니다.";
					}
					else
					{
						result = "이미 성적이 등록된 아이디 입니다.";
					}
					break;
				}
				else
				{
					result = "존재하지 않는 아이디 입니다.";
				}
			}
			
			mav.addObject("result", result);
			
			mav.setViewName("MemberRecordInsertAjax");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
