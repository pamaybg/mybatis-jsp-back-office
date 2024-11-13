package com.icignal.auth.dto.response;

import java.io.Serializable;

public class AuthResDto  implements Serializable {

	private static final long serialVersionUID = 1L;
	private String authNo;
	private String authName;
	private String authDesc;
	private String authCreater;
	private String authCreateDate;
	private String id;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAuthNo() {
		return authNo;
	}
	public void setAuthNo(String authNo) {
		this.authNo = authNo;
	}
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}
	public String getAuthDesc() {
		return authDesc;
	}
	public void setAuthDesc(String authDesc) {
		this.authDesc = authDesc;
	}
	public String getAuthCreater() {
		return authCreater;
	}
	public void setAuthCreater(String authCreater) {
		this.authCreater = authCreater;
	}
	public String getAuthCreateDate() {
		return authCreateDate;
	}
	public void setAuthCreateDate(String authCreateDate) {
		this.authCreateDate = authCreateDate;
	}
	
	
}
