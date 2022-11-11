/*============================
	ReceiveController.java
	- 사용자 정의 컨트롤러
=============================*/

package com.test.mvc;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

public class ReceiveController implements Controller
{
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// send.action에서 전송된 거 얘가 수신하게 된다.
		
		ModelAndView mav = new ModelAndView();
		
		request.setCharacterEncoding("UTF-8");
		
		// 이전 페이지(Send.jsp)로부터 데이터 수신
		//-- userName
		String userName = request.getParameter("userName");
		
		// 수신한 데이터 처리(추가 연산이나 가공 → 업무 로직)
		// 넘어온 데이터를 object로 추가함
		mav.addObject("userName", userName);
		mav.setViewName("/WEB-INF/view/Receive.jsp");
		//-- Receive.jsp가 저 object 들고 클라이언트 만나면 되겠다~
		//   그 view 한테 userName 적어놓을게
		
		return mav;
	}

}
