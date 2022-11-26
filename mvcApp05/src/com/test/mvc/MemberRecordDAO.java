/*=====================================================
	#15. MemberRecordDAO.java
	- 데이터베이스 액션 처리 클래스
	- 성적 데이터 입력 / 출력 / 수정 / 삭제 액션
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

public class MemberRecordDAO implements IMemberRecordDAO
{
	private DataSource dataSource;

	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}
	
	// 성적 리스트 조회
	@Override
	public ArrayList<MemberRecordDTO> list() throws SQLException
	{
		ArrayList<MemberRecordDTO> result = new ArrayList<MemberRecordDTO>();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT SCOREID, KOR, ENG, MAT, ID"
				  + " FROM MEMBERRECORD"
				  + " ORDER BY SCOREID";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			MemberRecordDTO dto = new MemberRecordDTO();
			
			dto.setScoreId(rs.getInt("SCOREID"));
			dto.setKor(rs.getInt("KOR"));
			dto.setEng(rs.getInt("ENG"));
			dto.setMat(rs.getInt("MAT"));
			dto.setId(rs.getString("ID"));
			
			result.add(dto);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 성적 데이터 등록(입력, 추가)
	@Override
	public int add(MemberRecordDTO dto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "INSERT INTO MEMBERRECORD(SCOREID, KOR, ENG, MAT, ID)"
				  + " VALUES (MEMBERRECORDSEQ.NEXTVAL, ?, ?, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, dto.getKor());
		pstmt.setInt(2, dto.getEng());
		pstmt.setInt(3, dto.getMat());
		pstmt.setString(4, dto.getId());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 성적 데이터 제거(삭제)
	@Override
	public int remove(String id) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "DELETE FROM MEMBERRECORD WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 성적 데이터 수정(변경)
	@Override
	public int modify(MemberRecordDTO dto) throws SQLException
	{
		int result = 0;
		
		Connection conn = dataSource.getConnection();
		
		String sql = "UPDATE MEMBERRECORD"
				  + " SET KOR = ?"
				     + ", ENG = ?"
				     + ", MAT = ?"
				  + " WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setInt(1, dto.getKor());
		pstmt.setInt(2, dto.getEng());
		pstmt.setInt(3, dto.getMat());
		pstmt.setString(4, dto.getId());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	// 아이디로 성적 검색
	//-- 성적ID는 왜 검색할까?
	//   수정할 때 수정폼에 그 성적의 데이터를 얻어와서
	//   수정폼 안에 내용 채워 넣기 위함
	@Override
	public MemberRecordDTO searchId(String id) throws SQLException
	{
		MemberRecordDTO result = new MemberRecordDTO();
		
		Connection conn = dataSource.getConnection();
		
		String sql = "SELECT SCOREID, KOR, ENG, MAT, ID"
				  + " FROM MEMBERRECORD"
				  + " WHERE ID = ?"
				  + " ORDER BY SCOREID";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, id);
		
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next())
		{
			result.setScoreId(rs.getInt("SCOREID"));
			result.setKor(rs.getInt("KOR"));
			result.setEng(rs.getInt("ENG"));
			result.setMat(rs.getInt("MAT"));
			result.setId(rs.getString("ID"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}
	
	
	
}
