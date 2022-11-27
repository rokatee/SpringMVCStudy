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

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class MemberRecordInsertAjaxController implements Controller
{
	private IMemberListDAO listDAO;
	private IMemberRecordDAO recordDAO;
	
	public void setListDAO(IMemberListDAO listDAO)
	{
		this.listDAO = listDAO;
	}

	public void setRecordDAO(IMemberRecordDAO recordDAO)
	{
		this.recordDAO = recordDAO;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		ModelAndView mav = new ModelAndView();

		// 이전 페이지(MemberRecordListForm.jsp)로부터 데이터 수신
		//-- id
		String id = request.getParameter("id");

		ArrayList<MemberListDTO> memberListDTO = new ArrayList<MemberListDTO>();
		ArrayList<MemberRecordDTO> memberRecordDTO = new ArrayList<MemberRecordDTO>();
		
		String idResult = "";
		String delCheckResult = "";
		
		try
		{
			memberListDTO = listDAO.list();
			memberRecordDTO = recordDAO.list();
			/*
			for (MemberRecordDTO memberRecord : memberRecordDTO)
			{
				if(memberRecord.getId().equals(id))
				{
					for (MemberListDTO memberList : memberListDTO)
					{
						if(memberList.getDelCheck() > 0 )
						{
							delCheckResult = "이미 성적이 등록된 아이디 입니다.";
							break;
						}
						else
						{
							delCheckResult = "성적 등록이 가능한 아이디 입니다.";
						}
					}
					//idResult = "존재하는 아이디 입니다.";
					break;
				}
				else
				{
					idResult = "존재하지 않는 아이디 입니다.";
				}
			}
			*/
			for (MemberListDTO memberList : memberListDTO)
			{
				if(memberList.getId().equals(id))
				{
					idResult = "존재하는 아이디 이며, ";

					if(memberList.getDelCheck() == 0 )
					{
						delCheckResult = "성적 등록이 가능한 아이디 입니다.";
					}
					else
					{
						delCheckResult = "이미 성적이 등록된 아이디 입니다.";
					}
					break;
				}
				else
				{
					idResult = "존재하지 않는 아이디 입니다.";
				}
			}
			mav.addObject("delCheckResult", delCheckResult);
			mav.addObject("idResult", idResult);
			
			mav.setViewName("MemberRecordInsertAjax");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
