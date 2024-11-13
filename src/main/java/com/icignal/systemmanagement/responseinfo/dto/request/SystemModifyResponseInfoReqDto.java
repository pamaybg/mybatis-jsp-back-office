package com.icignal.systemmanagement.responseinfo.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;


public class SystemModifyResponseInfoReqDto extends MKTBaseReqDto{

	private String id;					//아이디
	private String dpSeq;				//노출 순서
	private String parRspnsCd;			//상위 반응코드
	private String camRspnsCd;			//캠페인 반응 코드
	private String camRspnsNm;			//캠페인 반응명
	private String spcfChnlRspnsCd;		//적용채널 타입
	private String camRspnsDesc;		//설명
	
	private String modifyBy;			//변경자

	
	
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
	public String getParRspnsCd() {
		return parRspnsCd;
	}
	public void setParRspnsCd(String parRspnsCd) {
		this.parRspnsCd = parRspnsCd;
	}
	public String getCamRspnsCd() {
		return camRspnsCd;
	}
	public void setCamRspnsCd(String camRspnsCd) {
		this.camRspnsCd = camRspnsCd;
	}
	public String getCamRspnsNm() {
		return camRspnsNm;
	}
	public void setCamRspnsNm(String camRspnsNm) {
		this.camRspnsNm = camRspnsNm;
	}
	public String getSpcfChnlRspnsCd() {
		return spcfChnlRspnsCd;
	}
	public void setSpcfChnlRspnsCd(String spcfChnlRspnsCd) {
		this.spcfChnlRspnsCd = spcfChnlRspnsCd;
	}
	public String getCamRspnsDesc() {
		return camRspnsDesc;
	}
	public void setCamRspnsDesc(String camRspnsDesc) {
		this.camRspnsDesc = camRspnsDesc;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	
}
