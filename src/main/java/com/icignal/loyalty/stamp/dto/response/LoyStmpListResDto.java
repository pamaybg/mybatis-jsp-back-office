package com.icignal.loyalty.stamp.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
* @name : infavor.loyalty.stamp.dto.response.LOYStmpListResponseDTO
* @date : 2019. 3. 5.
* @author : hy.jun
* @description :
*/
public class LoyStmpListResDto extends GridPagingItemResDto {

	private static final long serialVersionUID = -5584509182497343930L;

	private String rid;
	private String stmpNo;
	private String stmpNm;
	private String stmpStatusNm;
	private String stmpStatus;
	private String stmpStartDt;
	private String stmpEndDt;
	private String stmpCnt;
	private int mbrCnt;
	private String calcTypeCdNm;
	private String calcTypeSubCdNm;
	private String stmpProgStatusNm; //스탬프 진행상태명
	private int selfTotAmtSum; //혜택포인트
	private int acrlPntSum; //적립포인트금액
	private String mbrTgtYn;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getStmpNo() {
		return stmpNo;
	}
	public void setStmpNo(String stmpNo) {
		this.stmpNo = stmpNo;
	}
	public String getStmpNm() {
		return stmpNm;
	}
	public void setStmpNm(String stmpNm) {
		this.stmpNm = stmpNm;
	}
	public String getStmpStatusNm() {
		return stmpStatusNm;
	}
	public void setStmpStatusNm(String stmpStatusNm) {
		this.stmpStatusNm = stmpStatusNm;
	}
	public String getStmpStartDt() {
		return stmpStartDt;
	}
	public void setStmpStartDt(String stmpStartDt) {
		this.stmpStartDt = stmpStartDt;
	}
	public String getStmpEndDt() {
		return stmpEndDt;
	}
	public void setStmpEndDt(String stmpEndDt) {
		this.stmpEndDt = stmpEndDt;
	}
	public String getStmpCnt() {
		return stmpCnt;
	}
	public void setStmpCnt(String stmpCnt) {
		this.stmpCnt = stmpCnt;
	}
	public int getMbrCnt() {
		return mbrCnt;
	}
	public void setMbrCnt(int mbrCnt) {
		this.mbrCnt = mbrCnt;
	}
	public String getStmpStatus() {
		return stmpStatus;
	}
	public void setStmpStatus(String stmpStatus) {
		this.stmpStatus = stmpStatus;
	}
	public String getStmpProgStatusNm() {
		return stmpProgStatusNm;
	}
	public void setStmpProgStatusNm(String stmpProgStatusNm) {
		this.stmpProgStatusNm = stmpProgStatusNm;
	}
	public String getCalcTypeCdNm() {
		return calcTypeCdNm;
	}
	public void setCalcTypeCdNm(String calcTypeCdNm) {
		this.calcTypeCdNm = calcTypeCdNm;
	}
	public String getCalcTypeSubCdNm() {
		return calcTypeSubCdNm;
	}
	public void setCalcTypeSubCdNm(String calcTypeSubCdNm) {
		this.calcTypeSubCdNm = calcTypeSubCdNm;
	}
	public int getSelfTotAmtSum() {
		return selfTotAmtSum;
	}
	public void setSelfTotAmtSum(int selfTotAmtSum) {
		this.selfTotAmtSum = selfTotAmtSum;
	}
	public int getAcrlPntSum() {
		return acrlPntSum;
	}
	public void setAcrlPntSum(int acrlPntSum) {
		this.acrlPntSum = acrlPntSum;
	}
	public String getMbrTgtYn() {
		return mbrTgtYn;
	}
	public void setMbrTgtYn(String mbrTgtYn) {
		this.mbrTgtYn = mbrTgtYn;
	}
}
