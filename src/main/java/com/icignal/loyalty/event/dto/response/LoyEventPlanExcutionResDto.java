package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyEventPlanExcutionResDto extends GridPagingItemResDto {
	private String rid;
	private String evtNo;
	private String evtType;
	private String evtCategory;
	private String evtNm;
	private String evtStatus;
	private String evtStatusCd;
	private String evtStartDt;
	private String evtEndDt;
	private String evtApplCnt;
	private String evtApplTicketCnt;
	private String evtApplMbrCnt;
	private String evtSeq;
	
	private String id;
	private String dispNo;
	private String camNm;
	private String startDd;
	private String endDd;
	private String accntSmlType;
	private String accntDetailType;
	private String offerType;
	private String promType;
	private String promSubType;
	private String selfTotAmt;
	private String winCmpltYn;
	private String winCmpltDt;
	private String tierLimitYn;
    private String mainImageYn;
    private String evtCatcd;
    @MarkName(groupCode = "LNL_EVT_CD", codeField = "evtCatcd")
    private String evtCatNm;
    private String createDate;
    private String modifyDate;
	private String evtWinnerCnt;
    
	
	public String getEvtWinnerCnt() {
		return evtWinnerCnt;
	}
	public void setEvtWinnerCnt(String evtWinnerCnt) {
		this.evtWinnerCnt = evtWinnerCnt;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getSelfTotAmt() {
		return selfTotAmt;
	}
	public void setSelfTotAmt(String selfTotAmt) {
		this.selfTotAmt = selfTotAmt;
	}
	public String getEvtApplMbrCnt() {
		return evtApplMbrCnt;
	}
	public void setEvtApplMbrCnt(String evtApplMbrCnt) {
		this.evtApplMbrCnt = evtApplMbrCnt;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEvtNo() {
		return evtNo;
	}
	public void setEvtNo(String evtNo) {
		this.evtNo = evtNo;
	}
	public String getEvtType() {
		return evtType;
	}
	public void setEvtType(String evtType) {
		this.evtType = evtType;
	}
	public String getEvtCategory() {
		return evtCategory;
	}
	public void setEvtCategory(String evtCategory) {
		this.evtCategory = evtCategory;
	}
	public String getEvtNm() {
		return evtNm;
	}
	public void setEvtNm(String evtNm) {
		this.evtNm = evtNm;
	}
	public String getEvtStatus() {
		return evtStatus;
	}
	public void setEvtStatus(String evtStatus) {
		this.evtStatus = evtStatus;
	}
	public String getEvtStartDt() {
		return evtStartDt;
	}
	public void setEvtStartDt(String evtStartDt) {
		this.evtStartDt = evtStartDt;
	}
	public String getEvtEndDt() {
		return evtEndDt;
	}
	public void setEvtEndDt(String evtEndDt) {
		this.evtEndDt = evtEndDt;
	}
	public String getEvtApplCnt() {
		return evtApplCnt;
	}
	public void setEvtApplCnt(String evtApplCnt) {
		this.evtApplCnt = evtApplCnt;
	}
	public String getEvtApplTicketCnt() {
		return evtApplTicketCnt;
	}
	public void setEvtApplTicketCnt(String evtApplTicketCnt) {
		this.evtApplTicketCnt = evtApplTicketCnt;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDispNo() {
		return dispNo;
	}
	public void setDispNo(String dispNo) {
		this.dispNo = dispNo;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getStartDd() {
		return startDd;
	}
	public void setStartDd(String startDd) {
		this.startDd = startDd;
	}
	public String getEndDd() {
		return endDd;
	}
	public void setEndDd(String endDd) {
		this.endDd = endDd;
	}
	public String getAccntSmlType() {
		return accntSmlType;
	}
	public void setAccntSmlType(String accntSmlType) {
		this.accntSmlType = accntSmlType;
	}
	public String getAccntDetailType() {
		return accntDetailType;
	}
	public void setAccntDetailType(String accntDetailType) {
		this.accntDetailType = accntDetailType;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public String getPromType() {
		return promType;
	}
	public void setPromType(String promType) {
		this.promType = promType;
	}
	public String getPromSubType() {
		return promSubType;
	}
	public void setPromSubType(String promSubType) {
		this.promSubType = promSubType;
	}
	public String getEvtSeq() {
		return evtSeq;
	}
	public void setEvtSeq(String evtSeq) {
		this.evtSeq = evtSeq;
	}
	public String getEvtStatusCd() {
		return evtStatusCd;
	}
	public void setEvtStatusCd(String evtStatusCd) {
		this.evtStatusCd = evtStatusCd;
	}
	public String getWinCmpltYn() {
		return winCmpltYn;
	}
	public void setWinCmpltYn(String winCmpltYn) {
		this.winCmpltYn = winCmpltYn;
	}
	public String getWinCmpltDt() {
		return winCmpltDt;
	}
	public void setWinCmpltDt(String winCmpltDt) {
		this.winCmpltDt = winCmpltDt;
	}
	public String getTierLimitYn() {
		return tierLimitYn;
	}
	public void setTierLimitYn(String tierLimitYn) {
		this.tierLimitYn = tierLimitYn;
	}
	public String getMainImageYn() {
		return mainImageYn;
	}
	public void setMainImageYn(String mainImageYn) {
		this.mainImageYn = mainImageYn;
	}
	public String getEvtCatcd() {
		return evtCatcd;
	}
	public void setEvtCatcd(String evtCatcd) {
		this.evtCatcd = evtCatcd;
	}
	public String getEvtCatNm() {
		return evtCatNm;
	}
	public void setEvtCatNm(String evtCatNm) {
		this.evtCatNm = evtCatNm;
	}
	
	

	
	
}
