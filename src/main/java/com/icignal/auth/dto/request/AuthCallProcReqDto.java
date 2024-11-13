package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class AuthCallProcReqDto extends MKTBaseReqDto {
	
	
	private String pAuthID;
	private String pAtuhCopyID;

	public String getpAuthID() {
		return pAuthID;
	}
	public void setpAuthID(String pAuthID) {
		this.pAuthID = pAuthID;
	}
	public String getpAtuhCopyID() {
		return pAtuhCopyID;
	}
	public void setpAtuhCopyID(String pAtuhCopyID) {
		this.pAtuhCopyID = pAtuhCopyID;
	}

	
	

}
