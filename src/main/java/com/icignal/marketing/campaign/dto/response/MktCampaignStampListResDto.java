package com.icignal.marketing.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : MktCampaignStampListResDto.java
 * @date : 2018. 4. 26.
 * @author : 이필수
 * @description : 캠페인 B2C이벤트 스탬프형 목록 ResDto
 */
public class MktCampaignStampListResDto extends StatusResDto {
	
	private String rid;						//스탬프형 RID
	
	private String stampSeq;				//스탬프 노출 번호
	private String stampTypeCd;				//스탬프 유형
	private String stampCnt;				//스탬프 지급 횟수
	private String stampPeriod;				//스탬프 기간
	private String stampPeriodCd;			//스탬프 기간 코드
	private String totStampCnt;				//Total 스탬프 수
	private String stampGiveCnt;			//스탬프 지급 조건 횟수
	private String stampGiveCriteria;		//스탬프 지급 조건 기준
	private String stampGiveCriteriaCd;		//스탬프 지급 조건 기준 코드
	private String totGiveStampCnt;			//Total 지급 스탬프 수
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getStampSeq() {
		return stampSeq;
	}
	public void setStampSeq(String stampSeq) {
		this.stampSeq = stampSeq;
	}
	public String getStampTypeCd() {
		return stampTypeCd;
	}
	public void setStampTypeCd(String stampTypeCd) {
		this.stampTypeCd = stampTypeCd;
	}
	public String getStampCnt() {
		return stampCnt;
	}
	public void setStampCnt(String stampCnt) {
		this.stampCnt = stampCnt;
	}
	public String getStampPeriod() {
		return stampPeriod;
	}
	public void setStampPeriod(String stampPeriod) {
		this.stampPeriod = stampPeriod;
	}
	public String getStampPeriodCd() {
		return stampPeriodCd;
	}
	public void setStampPeriodCd(String stampPeriodCd) {
		this.stampPeriodCd = stampPeriodCd;
	}
	public String getStampGiveCriteria() {
		return stampGiveCriteria;
	}
	public void setStampGiveCriteria(String stampGiveCriteria) {
		this.stampGiveCriteria = stampGiveCriteria;
	}
	public String getStampGiveCriteriaCd() {
		return stampGiveCriteriaCd;
	}
	public void setStampGiveCriteriaCd(String stampGiveCriteriaCd) {
		this.stampGiveCriteriaCd = stampGiveCriteriaCd;
	}
	public String getTotStampCnt() {
		return totStampCnt;
	}
	public void setTotStampCnt(String totStampCnt) {
		this.totStampCnt = totStampCnt;
	}
	public String getStampGiveCnt() {
		return stampGiveCnt;
	}
	public void setStampGiveCnt(String stampGiveCnt) {
		this.stampGiveCnt = stampGiveCnt;
	}
	public String getTotGiveStampCnt() {
		return totGiveStampCnt;
	}
	public void setTotGiveStampCnt(String totGiveStampCnt) {
		this.totGiveStampCnt = totGiveStampCnt;
	}
	
}
