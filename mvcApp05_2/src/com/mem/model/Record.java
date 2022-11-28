package com.mem.model;

public class Record
{
	/*
	NAME       VARCHAR2(50) 
	KOR        NUMBER(3)    
	ENG        NUMBER(3)    
	MAT        NUMBER(3)    
	AVG        NUMBER       
	SCOREID    NUMBER
	ID		   VARCHAR2(20)     
	*/
	
	String name, scoreId, id;
	int kor, eng, mat, avg, grade;
	
	// getter / setter 구성
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getScoreId()
	{
		return scoreId;
	}
	public void setScoreId(String scoreId)
	{
		this.scoreId = scoreId;
	}
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
	public int getKor()
	{
		return kor;
	}
	public void setKor(int kor)
	{
		this.kor = kor;
	}
	public int getEng()
	{
		return eng;
	}
	public void setEng(int eng)
	{
		this.eng = eng;
	}
	public int getMat()
	{
		return mat;
	}
	public void setMat(int mat)
	{
		this.mat = mat;
	}
	public int getAvg()
	{
		return avg;
	}
	public void setAvg(int avg)
	{
		this.avg = avg;
	}
	public int getGrade()
	{
		return grade;
	}
	public void setGrade(int grade)
	{
		this.grade = grade;
	}
	
	
}
