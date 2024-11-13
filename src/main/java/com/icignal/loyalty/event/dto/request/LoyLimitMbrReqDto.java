package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class LoyLimitMbrReqDto extends CommonDataAuthReqDto{
	
	private String rid;//RID
	private String evtRid;//이벤트 RID
	private String ridMbr;//회원 RID
	private String startDt;//시작일
	private String endDt;//종료일
	private String limitDesc;//제한 사유
	private String releaDesc;//해지 사유
	private String cipherKey;
	
	/*public LoyLimitMbrReqDto() {
		try {
			this.setCipherKey(CryptoManager.getCipherKey());
		}catch(Exception e) {
			LogUtil.error(e);
		}
	}*/
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEvtRid() {
		return evtRid;
	}
	public void setEvtRid(String evtRid) {
		this.evtRid = evtRid;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getStartDt() {
		return startDt;
	}
	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}
	public String getEndDt() {
		return endDt;
	}
	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}
	public String getLimitDesc() {
		return limitDesc;
	}
	public void setLimitDesc(String limitDesc) {
		this.limitDesc = limitDesc;
	}
	public String getReleaDesc() {
		return releaDesc;
	}
	public void setReleaDesc(String releaDesc) {
		this.releaDesc = releaDesc;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
}
