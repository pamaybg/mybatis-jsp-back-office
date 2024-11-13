package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : MktCampaignB2CInfoResDto.java
 * @date : 2018. 4. 23.
 * @author : 이필수
 * @description : B2C 이벤트 캠페인 ResDto
 */
public class MktCampaignEntryInfoResDto extends StatusResDto {
	
	private String rid;						//아이디
	private String createDate;				//생성일시
	private String modifyDate;				//수정일시
	private String accountId;				//Account ID
	private String ridCam;					//캠페인 RID
	private String ridEventMst;				//이벤트 RID
	private String applyCriteriaCd;			//응모 조건
	private String loginFlg;				//로그인 확인 여부
	private String replyMethodCd;			//댓글방식
	private String replyMaxLength;			//최대댓글글자수
	private String starPntFlg;				//별점사용 여부
	private String maxStarPnt;				//최대별점점수
	private String halfStarPntFlg;			//0.5점 적용 여부
	
	private String buttonImgUrl;			//버튼 이미지URL
	private String inactiveStarImgUrl;		//비활성별점 이미지URL
	private String activeStarImgUrl;		//활성별점 이미지URL
	
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

	public String getRidEventMst() {
		return ridEventMst;
	}

	public void setRidEventMst(String ridEventMst) {
		this.ridEventMst = ridEventMst;
	}

	public String getApplyCriteriaCd() {
		return applyCriteriaCd;
	}

	public void setApplyCriteriaCd(String applyCriteriaCd) {
		this.applyCriteriaCd = applyCriteriaCd;
	}

	public String getLoginFlg() {
		return loginFlg;
	}

	public void setLoginFlg(String loginFlg) {
		this.loginFlg = loginFlg;
	}

	public String getReplyMethodCd() {
		return replyMethodCd;
	}

	public void setReplyMethodCd(String replyMethodCd) {
		this.replyMethodCd = replyMethodCd;
	}

	public String getReplyMaxLength() {
		return replyMaxLength;
	}

	public void setReplyMaxLength(String replyMaxLength) {
		this.replyMaxLength = replyMaxLength;
	}

	public String getStarPntFlg() {
		return starPntFlg;
	}

	public void setStarPntFlg(String starPntFlg) {
		this.starPntFlg = starPntFlg;
	}

	public String getMaxStarPnt() {
		return maxStarPnt;
	}

	public void setMaxStarPnt(String maxStarPnt) {
		this.maxStarPnt = maxStarPnt;
	}

	public String getHalfStarPntFlg() {
		return halfStarPntFlg;
	}

	public void setHalfStarPntFlg(String halfStarPntFlg) {
		this.halfStarPntFlg = halfStarPntFlg;
	}

	public String getButtonImgUrl() {
		return buttonImgUrl;
	}

	public void setButtonImgUrl(String buttonImgUrl) {
		this.buttonImgUrl = buttonImgUrl;
	}

	public String getInactiveStarImgUrl() {
		return inactiveStarImgUrl;
	}

	public void setInactiveStarImgUrl(String inactiveStarImgUrl) {
		this.inactiveStarImgUrl = inactiveStarImgUrl;
	}

	public String getActiveStarImgUrl() {
		return activeStarImgUrl;
	}

	public void setActiveStarImgUrl(String activeStarImgUrl) {
		this.activeStarImgUrl = activeStarImgUrl;
	}
    
}
