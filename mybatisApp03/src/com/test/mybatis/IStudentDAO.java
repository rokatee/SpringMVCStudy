/*====================
 	IStudentDAO.java
=====================*/

package com.test.mybatis;

import java.util.ArrayList;

public interface IStudentDAO
{
	// 인원 수 확인
	public int count();
	
	// 학생 명단 확인
	public ArrayList<StudentDTO> list();
	
	// 학생 정보 입력(추가)
	public int add(StudentDTO s);
	
	// 학생정보 확인(sid를 활용하여 학생 정보 검색)
	public StudentDTO search(String id);
	
}
