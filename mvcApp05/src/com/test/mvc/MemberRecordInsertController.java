/*=====================================================
	#21. MemberRecordInsertFormController.java
	- 사용자 정의 컨트롤러 클래스
	- 성적 데이터 입력 액션 수행 및 해당 액션 처리 이후
     『memberrecordlist.action』을 다시 요청할 수 있도록 처리
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
      → 인터페이스 자료형 구조
      → setter 메소드 정의
======================================================*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class MemberRecordInsertController implements Controller
{
	private IMemberRecordDAO dao;
	
	public void setDao(IMemberRecordDAO dao)
	{
		this.dao = dao;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		
		ModelAndView mav = new ModelAndView();
		
		// 이전 페이지(MemberListInsertForm.jsp)로부터 데이터 수신
		//--id, pw, name, tel, email
		String id = request.getParameter("id");
		String kor = request.getParameter("kor"); 
		String eng = request.getParameter("eng");
		String mat = request.getParameter("mat");
		
		try
		{
			MemberRecordDTO dto = new MemberRecordDTO();
			
			dto.setId(id);
			dto.setKor(Integer.parseInt(kor));
			dto.setEng(Integer.parseInt(eng));
			dto.setMat(Integer.parseInt(mat));
			
			dao.add(dto);
			
			mav.setViewName("redirect:memberrecordlist.action");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
