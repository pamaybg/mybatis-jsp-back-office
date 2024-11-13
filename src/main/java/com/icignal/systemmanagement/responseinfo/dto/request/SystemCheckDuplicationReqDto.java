package com.icignal.systemmanagement.responseinfo.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class SystemCheckDuplicationReqDto extends MKTBaseReqDto{

	private String id;
	private String dpSeq;
	private String camRspnsNm;
	private String camRspnsCd;
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getDpSeq() {
		return dpSeq;
	}

	public void setDpSeq(String dpSeq) {
		this.dpSeq = dpSeq;
	}

	public String getCamRspnsNm() {
		return camRspnsNm;
	}

	public void setCamRspnsNm(String camRspnsNm) {
		this.camRspnsNm = camRspnsNm;
	}

	public String getCamRspnsCd() {
		return camRspnsCd;
	}

	public void setCamRspnsCd(String camRspnsCd) {
		this.camRspnsCd = camRspnsCd;
	}

	
	
}
