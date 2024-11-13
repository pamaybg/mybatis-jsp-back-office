package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : MktCampaignB2CInfoResDto.java
 * @date : 2018. 4. 23.
 * @author : 이필수
 * @description : B2C 이벤트 캠페인 ResDto
 */
public class MktCampaignB2CInfoResDto extends StatusResDto {
	
	private String rid;						//아이디
	private String createDate;				//생성일시
	private String modifyDate;				//수정일시
	private String accountId;				//Account ID
	private String ridCam;					//캠페인 RID
	
	private String eventDesc;				//디스플레이 설명
	private String eventStartDate;			//이벤트 시작일자
	private String eventStartTime;			//이벤트 시작시간
	private String eventEndDate;			//이벤트 종료일자
	private String eventEndTime;			//이벤트 종료시간
	private String winDate;					//당첨자 발표 일자
	private String applyChnlCd;				//응모채널
	private String apply1tierFlg;			//응모가능1등급 여부
	private String apply2tierFlg;			//응모가능2등급 여부
	private String apply3tierFlg;			//응모가능3등급 여부
	private String limitCnt;				//선착순제한수
	private String applyCnt;				//1인응모횟수
	private String applyPeriod;				//1인응모기간
	private String applyPeriodCd;			//1인응모기간구분
	private String totApplyCnt;				//총응모횟수
	private String privacyCheckFlg;			//개인정보확인여부
	private String targetEventFlg;			//대상자 이벤트 여부
	private String targetCd;				//대상자 코드
	private String comments;				//비고
	private String eventTypeCd;				//이벤트 유형
	private String applyRdmPnt;				//응모시 차감 포인트
	private String chnlCardFlg;				//제휴카드 보유 여부
	
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
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

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public String getRidCam() {
		return ridCam;
	}

	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}

	public String getEventDesc() {
		return eventDesc;
	}

	public void setEventDesc(String eventDesc) {
		this.eventDesc = eventDesc;
	}

	public String getEventStartDate() {
		return eventStartDate;
	}

	public void setEventStartDate(String eventStartDate) {
		this.eventStartDate = eventStartDate;
	}

	public String getEventEndDate() {
		return eventEndDate;
	}

	public void setEventEndDate(String eventEndDate) {
		this.eventEndDate = eventEndDate;
	}

	public String getWinDate() {
		return winDate;
	}

	public void setWinDate(String winDate) {
		this.winDate = winDate;
	}

	public String getApplyChnlCd() {
		return applyChnlCd;
	}

	public void setApplyChnlCd(String applyChnlCd) {
		this.applyChnlCd = applyChnlCd;
	}

	public String getApply1tierFlg() {
		return apply1tierFlg;
	}

	public void setApply1tierFlg(String apply1tierFlg) {
		this.apply1tierFlg = apply1tierFlg;
	}

	public String getApply2tierFlg() {
		return apply2tierFlg;
	}

	public void setApply2tierFlg(String apply2tierFlg) {
		this.apply2tierFlg = apply2tierFlg;
	}

	public String getApply3tierFlg() {
		return apply3tierFlg;
	}

	public void setApply3tierFlg(String apply3tierFlg) {
		this.apply3tierFlg = apply3tierFlg;
	}

	public String getLimitCnt() {
		return limitCnt;
	}

	public void setLimitCnt(String limitCnt) {
		this.limitCnt = limitCnt;
	}

	public String getApplyCnt() {
		return applyCnt;
	}

	public void setApplyCnt(String applyCnt) {
		this.applyCnt = applyCnt;
	}

	public String getApplyPeriod() {
		return applyPeriod;
	}

	public void setApplyPeriod(String applyPeriod) {
		this.applyPeriod = applyPeriod;
	}

	public String getApplyPeriodCd() {
		return applyPeriodCd;
	}

	public void setApplyPeriodCd(String applyPeriodCd) {
		this.applyPeriodCd = applyPeriodCd;
	}

	public String getTotApplyCnt() {
		return totApplyCnt;
	}

	public void setTotApplyCnt(String totApplyCnt) {
		this.totApplyCnt = totApplyCnt;
	}

	public String getPrivacyCheckFlg() {
		return privacyCheckFlg;
	}

	public void setPrivacyCheckFlg(String privacyCheckFlg) {
		this.privacyCheckFlg = privacyCheckFlg;
	}

	public String getTargetEventFlg() {
		return targetEventFlg;
	}

	public void setTargetEventFlg(String targetEventFlg) {
		this.targetEventFlg = targetEventFlg;
	}

	public String getTargetCd() {
		return targetCd;
	}

	public void setTargetCd(String targetCd) {
		this.targetCd = targetCd;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(String comments) {
		this.comments = comments;
	}

	public String getEventTypeCd() {
		return eventTypeCd;
	}

	public void setEventTypeCd(String eventTypeCd) {
		this.eventTypeCd = eventTypeCd;
	}

	public String getApplyRdmPnt() {
		return applyRdmPnt;
	}

	public void setApplyRdmPnt(String applyRdmPnt) {
		this.applyRdmPnt = applyRdmPnt;
	}

	public String getChnlCardFlg() {
		return chnlCardFlg;
	}

	public void setChnlCardFlg(String chnlCardFlg) {
		this.chnlCardFlg = chnlCardFlg;
	}

	public String getEventStartTime() {
		return eventStartTime;
	}

	public void setEventStartTime(String eventStartTime) {
		this.eventStartTime = eventStartTime;
	}

	public String getEventEndTime() {
		return eventEndTime;
	}

	public void setEventEndTime(String eventEndTime) {
		this.eventEndTime = eventEndTime;
	}
    
}
