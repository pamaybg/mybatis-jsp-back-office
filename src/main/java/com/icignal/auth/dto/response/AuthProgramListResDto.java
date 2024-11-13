package com.icignal.auth.dto.response;

import java.io.Serializable;


public class AuthProgramListResDto implements Serializable {
	
	private static final long serialVersionUID = 6572224165418022820L;
	
	private String id;			//프로그램 아이디
	private String progNum;		//프로그램 번호
	private String progName;	//프로그래명
	private String progTypeCd;	//프로그램 유형 코드
	private String progPath;	//프로그램 path
	private String applyType;	//유형

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProgNum() {
		return progNum;
	}

	public void setProgNum(String progNum) {
		this.progNum = progNum;
	}

	public String getProgName() {
		return progName;
	}

	public void setProgName(String progName) {
		this.progName = progName;
	}

	public String getProgTypeCd() {
		return progTypeCd;
	}

	public void setProgTypeCd(String progTypeCd) {
		this.progTypeCd = progTypeCd;
	}

	public String getProgPath() {
		return progPath;
	}

	public void setProgPath(String progPath) {
		this.progPath = progPath;
	}

	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}
	
	

}
