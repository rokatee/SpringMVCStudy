/*=====================================================
	#03. MemberListDAO.java
	- 데이터베이스 액션 처리 클래스
	- 학생 데이터 입력 / 출력 / 수정 / 삭제 액션
	- Connection 객체에 대한 의존성 주입을 위한 준비
	  → 인터페이스 형태의 속성 구성(DataSource)
	  → setter 메소드 정의
======================================================*/

package com.test.mvc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class MemberListDAO implements IMemberListDAO
{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	// 학생 리스트 조회
	@Override
	public ArrayList<MemberListDTO> list() throws SQLException
	{
		ArrayList<MemberListDTO> result = new ArrayList<MemberListDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT ID, PW, NAME, TEL, EMAIL, GRADE, DELCHECK"
				  + " FROM MEMBERLISTVIEW"
				  + " ORDER BY GRADE";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			MemberListDTO dto = new MemberListDTO();
			
			dto.setId(rs.getString("ID"));
			dto.setPw(rs.getString("PW"));
			dto.setName(rs.getString("NAME"));
			dto.setTel(rs.getString("TEL"));
			dto.setEmail(rs.getString("EMAIL"));
			dto.setGrade(rs.getInt("GRADE"));
			dto.setDelCheck(rs.getInt("DELCHECK"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 학생 데이터 등록(입력, 추가)
	@Override
	public int add(MemberListDTO dto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL)"
				  + " VALUES(?, CRYPTPACK.ENCRYPT(?, ?), ?, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, dto.getId());
		pstmt.setString(2, dto.getPw());
		pstmt.setString(3, dto.getPw());
		pstmt.setString(4, dto.getName());
		pstmt.setString(5, dto.getTel());
		pstmt.setString(6, dto.getEmail());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 학생 데이터 제거(삭제)
	@Override
	public int remove(String id) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "DELETE FROM MEMBERLIST WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 학생 데이터 수정(변경)
	@Override
	public int modify(MemberListDTO dto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "UPDATE MEMBERLIST"
				  + " SET PW = CRYPTPACK.ENCRYPT(?, ?)"
				     + ", NAME = ?"
				     + ", TEL = ?"
				     + ", EMAIL = ?"
				  + " WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, dto.getPw());
		pstmt.setString(2, dto.getPw());
		pstmt.setString(3, dto.getName());
		pstmt.setString(4, dto.getTel());
		pstmt.setString(5, dto.getEmail());
		pstmt.setString(6, dto.getId());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 아이디로 학생 검색
	//-- 학생ID는 왜 검색할까?
	//   수정할 때 수정폼에 그 학생의 데이터를 얻어와서
	//   수정폼 안에 내용 채워 넣기 위함
	@Override
	public MemberListDTO searchId(String id) throws SQLException
	{
		MemberListDTO result = new MemberListDTO();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT ID, NAME, TEL, EMAIL"
				  + " FROM MEMBERLIST"
				  + " WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			result.setId(rs.getString("ID"));
			result.setName(rs.getString("NAME"));
			result.setTel(rs.getString("TEL"));
			result.setEmail(rs.getString("EMAIL"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 학생 데이터 수정시 비밀번호 맞는지 확인
	// 맞으면 변경, 틀리면 페이지 그대로 남기
	@Override
	public String pw(String id, String pw) throws SQLException
	{
		String result = null;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT CRYPTPACK.DECRYPT(PW, ?) AS PW"
				  + " FROM MEMBERLIST"
				  + " WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, pw);
		pstmt.setString(2, id);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			result = rs.getString("PW");
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 관리자 로그인
	@Override
	public String loginAdmin(String id, String pw) throws SQLException
	{
		String result = null;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT NAME"
				  + " FROM MEMBERLIST"
				  + " WHERE ID = ?"
				     + "AND PW = CRYPTPACK.ENCRYPT(?, ?)"
				    + " AND GRADE = 0";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, pw);

		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			result = rs.getString("NAME");
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 일반 학생 로그인
	@Override
	public String login(String id, String pw) throws SQLException
	{
		String result = null;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT NAME"
				  + " FROM MEMBERLIST"
				  + " WHERE ID = ?"
				     + "AND PW = CRYPTPACK.ENCRYPT(?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, pw);

		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			result = rs.getString("NAME");
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 일반 학생이 볼 수 있는 학생 리스트
	// 여기에 성적도 포함? 하려면 DTO부터 설계 다르게 해야 함
	@Override
	public ArrayList<MemberListDTO> memList() throws SQLException
	{
		ArrayList<MemberListDTO> result = new ArrayList<MemberListDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT ID, NAME, TEL, EMAIL"
				  + " FROM MEMBERLIST";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			MemberListDTO listDTO = new MemberListDTO();
			
			listDTO.setId(rs.getString("ID"));
			listDTO.setId(rs.getString("NAME"));
			listDTO.setTel(rs.getString("TEL"));
			listDTO.setEmail(rs.getString("EMAIL"));
			
			result.add(listDTO);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	
}
