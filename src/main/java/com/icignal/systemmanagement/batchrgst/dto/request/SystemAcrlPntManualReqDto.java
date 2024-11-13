package com.icignal.systemmanagement.batchrgst.dto.request;

public class SystemAcrlPntManualReqDto {
	private String camNo;
	private String ridMbr;
	private String promRid;
	private String promNo;
	private String ofrNo;
	
	
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
	public String getPromNo() {
		return promNo;
	}
	public void setPromNo(String promNo) {
		this.promNo = promNo;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getCamNo() {
		return camNo;
	}
	public void setCamNo(String camNo) {
		this.camNo = camNo;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	
	
}
