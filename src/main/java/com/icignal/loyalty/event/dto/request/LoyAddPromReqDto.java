package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyAddPromReqDto extends CommonDataAuthReqDto{
	
	private String rid;//RID
	private String camNm;//캠페인명
	private String camRid;//캠페인 RID
	private String conCd;//조건타입코드
	private String condType;//조건유형
	private String condVal;//조건값
	private String evtRid;//이벤트 RID
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamRid() {
		return camRid;
	}
	public void setCamRid(String camRid) {
		this.camRid = camRid;
	}
	public String getConCd() {
		return conCd;
	}
	public void setConCd(String conCd) {
		this.conCd = conCd;
	}
	public String getCondType() {
		return condType;
	}
	public void setCondType(String condType) {
		this.condType = condType;
	}
	public String getCondVal() {
		return condVal;
	}
	public void setCondVal(String condVal) {
		this.condVal = condVal;
	}
	public String getEvtRid() {
		return evtRid;
	}
	public void setEvtRid(String evtRid) {
		this.evtRid = evtRid;
	}
}
