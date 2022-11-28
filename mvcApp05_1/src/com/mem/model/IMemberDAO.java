package com.mem.model;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IMemberDAO
{
	public ArrayList<Member> list() throws SQLException;
	
	public int add(Member member) throws SQLException;
	public int modify(Member member) throws SQLException;
	public int remove(String id) throws SQLException;
	
	public Member search(String id) throws SQLException;
	
	public String login(String id, String pw) throws SQLException;
	public String AdminLogin(String id, String pw) throws SQLException;
}
