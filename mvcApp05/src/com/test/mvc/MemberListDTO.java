/*===================================
	#01. MemberDTO.java
	- 학생 데이터 자료형 클래스(DTO)
====================================*/

package com.test.mvc;

public class MemberListDTO
{
	// 주요 속성 구성
	private String id, pw, name, tel, email;
	private int grade;

	// getter / setter
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}
	public String getPw()
	{
		return pw;
	}
	public void setPw(String pw)
	{
		this.pw = pw;
	}
	public String getName()
	{
		return name;
	}
	public void setName(String name)
	{
		this.name = name;
	}
	public String getTel()
	{
		return tel;
	}
	public void setTel(String tel)
	{
		this.tel = tel;
	}
	public String getEmail()
	{
		return email;
	}
	public void setEmail(String email)
	{
		this.email = email;
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
