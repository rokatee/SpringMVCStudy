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
	
	
	
}
