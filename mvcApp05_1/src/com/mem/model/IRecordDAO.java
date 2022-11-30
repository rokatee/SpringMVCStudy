package com.mem.model;

import java.sql.SQLException;
import java.util.ArrayList;

public interface IRecordDAO
{
	public ArrayList<Record> list() throws SQLException;
	
	public int add(Record record) throws SQLException;
	public int modify(Record record) throws SQLException;
	public int remove(String scoreId) throws SQLException;
	
	public Record search(String scoreId) throws SQLException;
	
	public String searchId(String id) throws SQLException;
	
}
