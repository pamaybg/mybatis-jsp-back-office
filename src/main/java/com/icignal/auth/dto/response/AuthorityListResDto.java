package com.icignal.auth.dto.response;

import java.io.Serializable;

public class AuthorityListResDto  implements Serializable {

	private static final long serialVersionUID = 3839637187262982378L;
	
	private String id;				//권한 아이디
	private String authNo;			//권한 번호
	private String authName;		//권한명
	private String authDesc;		//권한 설명
	
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
}
