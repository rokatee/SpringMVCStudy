/*=========================
 	GradeController.java
==========================*/

package com.test.mybatis;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

// 컨트롤러 등록
@Controller
public class GradeController
{
	// SqlSession 을 활용하여 마이바티스 객체 의존성 (자동) 주입
	@Autowired
	private SqlSession sqlSession;
	
	// 매개변수를 등록하는 과정에서 매개변수 목록에 적혀있는
	// 클래스의 객체 정보는 스프링이 제공한다.
	
	// 사용자의 요청 주소와 메소드를 매핑하는 과정 필요
	// 『@RequestMapping(value = "요청주소", method = 전송방식)』
	// 이 때, 전송 방식은 submit 액션인 경우만 POST 로 설정하고
	// 나머지 모든 전송 방식은 GET 으로 처리한다.
	@RequestMapping(value = "/gradelist.action", method = RequestMethod.GET)
	public String gradeList(Model model)
	{
		String result = null;
		
		IGradeDAO dao = sqlSession.getMapper(IGradeDAO.class);
		
		model.addAttribute("count", dao.count());
		model.addAttribute("list", dao.list());
		
		result = "WEB-INF/view/GradeList.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/gradeinsertform.action", method = RequestMethod.GET)
	public String gradeInsertForm()
	{
		String result = null;
		
		result = "/WEB-INF/view/GradeInsertForm.jsp";
		
		return result;
	}
	
	// form에서의 name 속성들과 dto의 속성이름이 같으면,
	// 일치하는 이름이 있으면 controller에서는 dto를 바로 받을 수 있다. 
	@RequestMapping(value = "/gradeinsert.action", method = RequestMethod.POST)
	public String gradeInsert(GradeDTO grade)
	{
		String result = null;
		
		IGradeDAO dao = sqlSession.getMapper(IGradeDAO.class);
		
		dao.add(grade);
		
		result = "redirect:gradelist.action";
		
		return result;
	}
	
	@RequestMapping(value = "/gradeupdateform.action", method = RequestMethod.GET)
	public String gradeUpdateForm(ModelMap model, GradeDTO grade)
	{
		String result = null;
		
		IGradeDAO dao = sqlSession.getMapper(IGradeDAO.class);
		
		dao.search(grade);
		model.addAttribute("grade", dao.search(grade));
		
		result = "/WEB-INF/view/GradeUpdateForm.jsp";
		
		return result;
	}
	
	@RequestMapping(value = "/gradeupdate.action", method = RequestMethod.POST)
	public String gradeUpdate(GradeDTO grade)
	{
		String result = null;
		
		IGradeDAO dao = sqlSession.getMapper(IGradeDAO.class);
		
		dao.update(grade);
		
		result = "redirect:gradelist.action";
		
		return result;
	}

	@RequestMapping(value = "/gradedelete.action", method = RequestMethod.GET)
	public String gradeDelete(String sid)
	{
		String result = null;
		
		IGradeDAO dao = sqlSession.getMapper(IGradeDAO.class);
		
		dao.delete(sid);
		
		result = "redirect:gradelist.action";
		
		return result;
	}
}
