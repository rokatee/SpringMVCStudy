/*=========================
	#06. IDepartmentDAO.java
	- 인터페이스
==========================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IDepartmentDAO
{
	// 추후 DepartmentDAO 에서 정의할 것으로 예상되는 메소드에 대한 선언
	public ArrayList<Department> list() throws SQLException;		// 출력
	
	public int add(Department department) throws SQLException;		// 입력
	public int remove(String departmentId) throws SQLException;		// 삭제
	public int modify(Department department) throws SQLException;	// 수정
}
