package com.mem.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class RecordDAO implements IRecordDAO
{
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	@Override
	public ArrayList<Record> list() throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		ArrayList<Record> result = new ArrayList<Record>();
		
		String sql = "SELECT ID, NAME, KOR, ENG, MAT, AVG, SCOREID, GRADE"
				  + " FROM MEMBERRECORD_VIEW"
				  + " WHERE GRADE = 1"
				  + " ORDER BY SCOREID";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Record record = new Record();
			
			record.setId(rs.getString("ID"));
			record.setName(rs.getString("NAME"));
			record.setKor(rs.getInt("KOR"));
			record.setEng(rs.getInt("ENG"));
			record.setMat(rs.getInt("MAT"));
			record.setAvg(rs.getInt("AVG"));
			record.setScoreId(rs.getString("SCOREID"));
			record.setGrade(rs.getInt("GRADE"));
			
			result.add(record);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public int add(Record record) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "INSERT INTO MEMBERRECORD(SCOREID, KOR, ENG, MAT, ID)"
				  + " VALUES(MEMBERRECORDSEQ.NEXTVAL, ?, ?, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, record.getKor());
		pstmt.setInt(2, record.getEng());
		pstmt.setInt(3, record.getMat());
		pstmt.setString(4, record.getId());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public int modify(Record record) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "UPDATE MEMBERRECORD"
				  + " SET KOR = ?, ENG = ?, MAT = ?"
				  + " WHERE SCOREID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, record.getKor());
		pstmt.setInt(2, record.getEng());
		pstmt.setInt(3, record.getMat());
		pstmt.setString(4, record.getScoreId());

		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public int remove(String scoreId) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		int result = 0;
		
		String sql = "DELETE"
				  + " FROM MEMBERRECORD"
				  + " WHERE SCOREID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, scoreId);
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public Record search(String scoreId) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		Record result = new Record();
		
		String sql = "SELECT ID, NAME, KOR, ENG, MAT, AVG, SCOREID"
				  + " FROM MEMBERRECORD_VIEW"
				  + " WHERE SCOREID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, scoreId);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setId(rs.getString("ID"));
			result.setName(rs.getString("NAME"));
			result.setKor(rs.getInt("KOR"));
			result.setEng(rs.getInt("ENG"));
			result.setMat(rs.getInt("MAT"));
			result.setAvg(rs.getInt("AVG"));
			result.setScoreId(rs.getString("SCOREID"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public String searchId(String id) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		String result = "";
		
		String sql = "SELECT SCOREID"
				  + " FROM MEMBERRECORD_VIEW"
				  + " WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result = rs.getString("SCOREID");
		}
		
		return result;
	}
	
	
}
