package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.MKTBaseReqDto;
/**
 * @name : MktCampaignStampListReqDto.java
 * @date : 2018. 04. 19.
 * @author : 이필수
 * @description : B2C 이벤트 캠페인 스탬프형  ReqDto
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignStampListReqDto extends MKTBaseReqDto {
    
	private String createDate;				//생성일시
	private String modifyDate;				//수정일시
	
	private String ridCam;					//캠페인 RID
	private String ridEventMst;				//이벤트 RID
	private String rid;						//응모형 RID
	
	private String stampSeq;				//스탬프 노출 번호
	private String stampTypeCd;				//스탬프 유형
	private String stampCnt;				//스탬프 지급 횟수
	private String stampPeriod;				//스탬프 기간
	private String stampPeriodCd;			//스탬프 기간 코드
	private String totStampCnt;				//Total 스탬프 수
	private String stampGiveCnt;			//스탬프 지급 조건 횟수
	private String stampGiveCriteria;		//스탬프 지급 조건 기준
	private String stampGiveCriteriaCd;		//스탬프 지급 조건 기준 코드
	private String totGiveStampCnt;		//Total 지급 스탬프 수
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
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

	public String getRidCam() {
		return ridCam;
	}


	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}


	public String getRidEventMst() {
		return ridEventMst;
	}


	public void setRidEventMst(String ridEventMst) {
		this.ridEventMst = ridEventMst;
	}


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
