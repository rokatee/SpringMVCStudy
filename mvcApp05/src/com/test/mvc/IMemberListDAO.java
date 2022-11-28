/*=========================
	#02. IMemberListDAO.java
	- 인터페이스
==========================*/

package com.test.mvc;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IMemberListDAO
{
	// 출력 - 학생 리스트 조회
	public ArrayList<MemberListDTO> list() throws SQLException;
	
	// 입력
	public int add(MemberListDTO dto) throws SQLException;
	
	// 삭제
	public int remove(String id) throws SQLException;
	
	// 수정
	public int modify(MemberListDTO dto) throws SQLException;
	
	// 아이디 검색
	public MemberListDTO searchId(String id) throws SQLException;
	
	// 학생 데이터 수정시 비밀번호 맞는지 확인
	// 맞으면 변경, 틀리면 페이지 그대로 남기
	public String pw(String id, String pw) throws SQLException;
	
	// 관리자 로그인
	public String loginAdmin(String id, String pw) throws SQLException;
	
	// 일반 학생 로그인
	public String login(String id, String pw) throws SQLException;
	
	// 일반 학생이 볼 수 있는 학생 리스트
	// 여기에 성적도 포함? 하려면 DTO에서부터 설계 다시 해야함
	public ArrayList<MemberListDTO> memList() throws SQLException;
	
}
