package com.icignal.marketing.realtime.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktCampaignChnlResDto extends GridPagingItemResDto{

	
	private String rid;
	private String chnlNo;
    private String subSid;    //계열사
    private String brdCd;    //브랜드
    private String storeCd;    //지점
    
    private String sndChnlNo;
    private String sndSubSid;    //계열사
    private String sndBrdCd;    //브랜드
    private String sndStoreCd;    //지점
    private String sndStoreNm;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getSubSid() {
		return subSid;
	}
	public void setSubSid(String subSid) {
		this.subSid = subSid;
	}
	public String getBrdCd() {
		return brdCd;
	}
	public void setBrdCd(String brdCd) {
		this.brdCd = brdCd;
	}
	public String getStoreCd() {
		return storeCd;
	}
	public void setStoreCd(String storeCd) {
		this.storeCd = storeCd;
	}
	public String getSndChnlNo() {
		return sndChnlNo;
	}
	public void setSndChnlNo(String sndChnlNo) {
		this.sndChnlNo = sndChnlNo;
	}
	public String getSndSubSid() {
		return sndSubSid;
	}
	public void setSndSubSid(String sndSubSid) {
		this.sndSubSid = sndSubSid;
	}
	public String getSndBrdCd() {
		return sndBrdCd;
	}
	public void setSndBrdCd(String sndBrdCd) {
		this.sndBrdCd = sndBrdCd;
	}
	public String getSndStoreCd() {
		return sndStoreCd;
	}
	public void setSndStoreCd(String sndStoreCd) {
		this.sndStoreCd = sndStoreCd;
	}
	public String getSndStoreNm() {
		return sndStoreNm;
	}
	public void setSndStoreNm(String sndStoreNm) {
		this.sndStoreNm = sndStoreNm;
	}
    
    
}
