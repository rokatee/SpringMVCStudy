/*=========================
	#14. IMemberRecordDAO.java
	- 인터페이스
==========================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IMemberRecordDAO
{
	// 출력 - 학생 리스트 조회
	public ArrayList<MemberRecordDTO> list() throws SQLException;
	
	// 입력
	public int add(MemberRecordDTO dto) throws SQLException;
	
	// 삭제
	public int remove(String id) throws SQLException;
	
	// 수정
	public int modify(MemberRecordDTO dto) throws SQLException;
	
	// 아이디 검색
	public MemberRecordDTO searchId(String id) throws SQLException;
}
