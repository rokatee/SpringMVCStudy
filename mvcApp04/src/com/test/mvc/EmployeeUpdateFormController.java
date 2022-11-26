/*=====================================================================
	#25. EmployeeUpdateFormController.java
	- 사용자 정의 컨트롤러 클래스
	- DAO 객체에 대한 의존성 주입(DI)을 위한 준비
	  → 인터페이스 형태의 자료형을 속성으로 구성
	  → setter 메소드 준비
======================================================================*/

package com.test.mvc;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

// ※ Spring 이 제공하는 『Controller』 인터페이스를 구현함으로서
//    사용자 정의 컨트롤러 클래스를 구성한다

public class EmployeeUpdateFormController implements Controller
{
	// check~!!!
	// EmployeeInsertFormController 구성과는 다른 방식으로 처리~!!!
	// ----------------------------
	// → 필요한 모든 메소드를 EmployeeDAO 에 정의해 두었던 상태
	
	// insertformController에서는 
	// private IEmployeeDAO 만 썼어서 dao 라고 이름붙였지만,
	// 여기서는 4개 쓸거라 각각 이름 붙여줌
	// → 이 속성의 개수만큼 setter 필요함
	
	// 주요 속성 구성
	private IEmployeeDAO employeeDAO;
	private IRegionDAO regionDAO;
	private IDepartmentDAO departmentDAO;
	private IPositionDAO positionDAO;
	
	public void setEmployeeDAO(IEmployeeDAO employeeDAO)
	{
		this.employeeDAO = employeeDAO;
	}

	public void setRegionDAO(IRegionDAO regionDAO)
	{
		this.regionDAO = regionDAO;
	}

	public void setDepartmentDAO(IDepartmentDAO departmentDAO)
	{
		this.departmentDAO = departmentDAO;
	}

	public void setPositionDAO(IPositionDAO positionDAO)
	{
		this.positionDAO = positionDAO;
	}

	// Controller 인터페이스의 handleRequest() 메소드 재정의
	@Override
	public ModelAndView handleRequest(HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		// 컨트롤러 내부 액션 처리 코드
		
		ModelAndView mav = new ModelAndView();
		
		// 세션 처리과정 추가 -----------------------------------------------------------------
		HttpSession session = request.getSession();
		
		if (session.getAttribute("name") == null)		// 로그인이 되어있지 않은 상황
		{
			mav.setViewName("redirect:loginform.action");
			return mav;
		}
		else if (session.getAttribute("admin") == null)	// 로그인은 되었지만 관리자가 아닌 상황
		{
			mav.setViewName("redirect:logout.action");
			return mav;
		}
		// ----------------------------------------------------------------- 세션 처리과정 추가
		
		ArrayList<Region> regionList = new ArrayList<Region>();
		ArrayList<Department> departmentList = new ArrayList<Department>();
		ArrayList<Position> positionList = new ArrayList<Position>();

		// 위의 list 값들을 각각의 dao 한테서 얻어내야 한다.
		// updateformController는 insertformController와는 달리
		// 일단 먼저 data를 일단 수신해야한다.
		
		// 이전 페이지(EmployeeList.jsp)로부터 데이터 수신
		//-- employeeId 
		String employeeId = request.getParameter("employeeId");

		try
		{
			
			Employee employee = new Employee();
			
			employee = employeeDAO.searchId(employeeId);
			
			// 주입받은 지역,부서,직위 dao로부터 list 들 얻어낸다.
			regionList = regionDAO.list();
			departmentList = departmentDAO.list();
			positionList = positionDAO.list();
			
			//이렇게 얻어낸 거 뷰한테 전달해야 한다.
			mav.addObject("employee", employee);
			mav.addObject("regionList", regionList);
			mav.addObject("departmentList", departmentList);
			mav.addObject("positionList", positionList);
			
			// 이 때 지정하게 되는 뷰
			//mav.setViewName("/WEB-INF/view/EmployeeUpdateForm.jsp");
			mav.setViewName("EmployeeUpdateForm");
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return mav;
	}
	
}
