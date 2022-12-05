/*====================
 	IGradeDAO.java
=====================*/

package com.test.mybatis;

import java.util.ArrayList;

public interface IGradeDAO
{
	// 성적 정보 인원 수 확인
	public int count();
	
	// 성적 정보 리스트 확인
	public ArrayList<GradeDTO> list();
	
	// 성적 정보 입력(추가)
	public int add(GradeDTO g);
	
	// 성적정보 확인(sid를 활용하여 성적 정보 검색)
	public GradeDTO search(GradeDTO dto);
	
	// 성적 정보 수정
	public int update(GradeDTO dto);
	
	// 성적 정보 삭제
	public int delete(String sid);
}
