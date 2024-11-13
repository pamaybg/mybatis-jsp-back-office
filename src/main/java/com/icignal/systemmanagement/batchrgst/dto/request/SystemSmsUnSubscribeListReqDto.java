package com.icignal.systemmanagement.batchrgst.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class SystemSmsUnSubscribeListReqDto extends CommonDataAuthReqDto {
	private String ridPar;	//Loy_upld_file 의 RID
	private String pRid;
	private String pType;
	private String pRst;
	private String pRstCd;
	private String pRstMsg;
	
	public String getpType() {
		return pType;
	}

	public void setpType(String pType) {
		this.pType = pType;
	}

	public String getpRst() {
		return pRst;
	}

	public void setpRst(String pRst) {
		this.pRst = pRst;
	}

	public String getpRstCd() {
		return pRstCd;
	}

	public void setpRstCd(String pRstCd) {
		this.pRstCd = pRstCd;
	}

	public String getpRstMsg() {
		return pRstMsg;
	}

	public void setpRstMsg(String pRstMsg) {
		this.pRstMsg = pRstMsg;
	}

	public String getpRid() {
		return pRid;
	}

	public void setpRid(String pRid) {
		this.pRid = pRid;
	}

	public String getRidPar() {
		return ridPar;
	}

	public void setRidPar(String ridPar) {
		this.ridPar = ridPar;
	}
}
