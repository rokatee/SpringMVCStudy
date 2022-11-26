/*===================================
	#13. MemberRecordDTO.java
	- 학생 데이터 자료형 클래스(DTO)
====================================*/

package com.test.mvc;

public class MemberRecordDTO
{
	// 주요 속성 구성
	private int scoreId, kor, eng, mat;
	private String id;
	
	// getter / setter
	public int getScoreId()
	{
		return scoreId;
	}
	public void setScoreId(int scoreId)
	{
		this.scoreId = scoreId;
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
	public String getId()
	{
		return id;
	}
	public void setId(String id)
	{
		this.id = id;
	}

	

}
