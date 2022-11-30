package com.mem.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.sql.DataSource;

public class MemberDAO implements IMemberDAO
{
	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource)
	{
		this.dataSource = dataSource;
	}

	@Override
	public ArrayList<Member> list() throws SQLException
	{
		Connection conn = dataSource.getConnection();

		ArrayList<Member> result = new ArrayList<Member>();
		
		String sql = "SELECT ID, NAME, TEL, EMAIL, GRADE, DELCHECK"
				  + " FROM MEMBERLIST_VIEW"
				  + " ORDER BY ID";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			Member member = new Member();
			
			member.setId(rs.getString("ID"));
			member.setName(rs.getString("NAME"));
			member.setTel(rs.getString("TEL"));
			member.setEmail(rs.getString("EMAIL"));
			member.setGrade(rs.getInt("GRADE"));
			member.setDelCheck(rs.getInt("DELCHECK"));
			
			result.add(member);
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public int add(Member member) throws SQLException
	{
		Connection conn = dataSource.getConnection();

		int result = 0;
		
		String sql = "INSERT INTO MEMBERLIST(ID, PW, NAME, TEL, EMAIL, GRADE)"
				  + " VALUES(?, CRYPTPACK.ENCRYPT(?, ?), ?, ?, ?, ?)";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, member.getId());
		pstmt.setString(2, member.getPw());
		pstmt.setString(3, member.getPw());
		pstmt.setString(4, member.getName());
		pstmt.setString(5, member.getTel());
		pstmt.setString(6, member.getEmail());
		pstmt.setInt(7, member.getGrade());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public int modify(Member member) throws SQLException
	{
		Connection conn = dataSource.getConnection();

		int result = 0;
		
		String sql = "UPDATE MEMBERLIST"
				  + " SET PW = CRYPTPACK.ENCRYPT(?, ?), NAME = ?, TEL = ?, EMAIL = ?"
				  + " WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, member.getPw());
		pstmt.setString(2, member.getPw());
		pstmt.setString(3, member.getName());
		pstmt.setString(4, member.getTel());
		pstmt.setString(5, member.getEmail());
		pstmt.setString(6, member.getId());
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public int remove(String id) throws SQLException
	{
		Connection conn = dataSource.getConnection();

		int result = 0;
		
		String sql = "DELETE"
				  + " FROM MEMBERLIST"
				  + " WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		result = pstmt.executeUpdate();
		
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public Member search(String id) throws SQLException
	{
		Connection conn = dataSource.getConnection();

		Member result = new Member();
		
		String sql = "SELECT ID, NAME, TEL, EMAIL, DELCHECK"
				  + " FROM MEMBERLIST_VIEW"
				  + " WHERE ID = ?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
			result.setId(rs.getString("ID"));
			result.setName(rs.getString("NAME"));
			result.setTel(rs.getString("TEL"));
			result.setEmail(rs.getString("EMAIL"));
			result.setDelCheck(rs.getInt("DELCHECK"));
		}
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public String login(String id, String pw) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		String result = "";
		
		String sql = "SELECT NAME"
				  + " FROM MEMBERLIST"
				  + " WHERE ID = ?"
				  + " AND PW = CRYPTPACK.ENCRYPT(?, ?)"
				  + " AND GRADE = 1";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, pw);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getString("NAME");

		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}

	@Override
	public String AdminLogin(String id, String pw) throws SQLException
	{
		Connection conn = dataSource.getConnection();
		
		String result = "";
		
		String sql = "SELECT NAME"
				  + " FROM MEMBERLIST"
				  + " WHERE ID = ?"
				  + " AND PW = CRYPTPACK.ENCRYPT(?, ?)"
				  + " AND GRADE = 0";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pw);
		pstmt.setString(3, pw);
		
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
			result = rs.getString("NAME");
		
		rs.close();
		pstmt.close();
		conn.close();
		
		return result;
	}


}
