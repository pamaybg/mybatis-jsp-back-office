package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktCampaignOfferListResDto extends GridPagingItemResDto {
	
	private String id;         //아이디
	private String createBy;   //생성자
	private String modifyBy;   //수정자
	private String createDate; //생성일시
	private String modifyDate; //수정일시
	
	private String offerId;    //오퍼 ID
	private String offerNo;    //오퍼번호
	private String offerName;  //오퍼명
	
	private String mktOfferCostGbn; //오퍼비용구분
	
	private String offerTypeCd;     //오퍼분류
	private String offerSubTypeNm;  //오퍼분류상세 명
	
	private String discountType;    //할인유형
	
	private String discountAmt;     //할인금액/할인율
	private String description;     //설명
	
	private String commStatus;      //상태
	
	private String applyStrDate;    //적용시작일자
	private String applyEndDate;    //적용종료일자
	
	private String offerFownerId;   //오퍼재원회사/부서코드
	
    private String offerEcnrsDivCd;     //오퍼재원 구분 코드
    private String offerEcnrsDivNm;     //오퍼재원 구분명
    private String offerUseDeskDivCd;   //오퍼 사용처 구분코드
    private String offerUseDeskDivNm;   //오퍼 사용처 구분명
	
	private String parOfferId;      //상위오퍼ID
	
	private String campaignId;      //캠페인 아이디

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
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

    public String getOfferNo() {
        return offerNo;
    }

    public void setOfferNo(String offerNo) {
        this.offerNo = offerNo;
    }

    public String getOfferName() {
        return offerName;
    }

    public void setOfferName(String offerName) {
        this.offerName = offerName;
    }

    public String getMktOfferCostGbn() {
        return mktOfferCostGbn;
    }

    public void setMktOfferCostGbn(String mktOfferCostGbn) {
        this.mktOfferCostGbn = mktOfferCostGbn;
    }

    public String getOfferTypeCd() {
        return offerTypeCd;
    }

    public void setOfferTypeCd(String offerTypeCd) {
        this.offerTypeCd = offerTypeCd;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public String getDiscountAmt() {
        return discountAmt;
    }

    public void setDiscountAmt(String discountAmt) {
        this.discountAmt = discountAmt;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCommStatus() {
        return commStatus;
    }

    public void setCommStatus(String commStatus) {
        this.commStatus = commStatus;
    }

    public String getApplyStrDate() {
        return applyStrDate;
    }

    public void setApplyStrDate(String applyStrDate) {
        this.applyStrDate = applyStrDate;
    }

    public String getApplyEndDate() {
        return applyEndDate;
    }

    public void setApplyEndDate(String applyEndDate) {
        this.applyEndDate = applyEndDate;
    }

    public String getOfferFownerId() {
        return offerFownerId;
    }

    public void setOfferFownerId(String offerFownerId) {
        this.offerFownerId = offerFownerId;
    }

    public String getParOfferId() {
        return parOfferId;
    }

    public void setParOfferId(String parOfferId) {
        this.parOfferId = parOfferId;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getOfferId() {
        return offerId;
    }

    public void setOfferId(String offerId) {
        this.offerId = offerId;
    }

    public String getOfferSubTypeNm() {
        return offerSubTypeNm;
    }

    public void setOfferSubTypeNm(String offerSubTypeNm) {
        this.offerSubTypeNm = offerSubTypeNm;
    }

	public String getOfferEcnrsDivCd() {
		return offerEcnrsDivCd;
	}

	public void setOfferEcnrsDivCd(String offerEcnrsDivCd) {
		this.offerEcnrsDivCd = offerEcnrsDivCd;
	}

	public String getOfferEcnrsDivNm() {
		return offerEcnrsDivNm;
	}

	public void setOfferEcnrsDivNm(String offerEcnrsDivNm) {
		this.offerEcnrsDivNm = offerEcnrsDivNm;
	}

	public String getOfferUseDeskDivCd() {
		return offerUseDeskDivCd;
	}

	public void setOfferUseDeskDivCd(String offerUseDeskDivCd) {
		this.offerUseDeskDivCd = offerUseDeskDivCd;
	}

	public String getOfferUseDeskDivNm() {
		return offerUseDeskDivNm;
	}

	public void setOfferUseDeskDivNm(String offerUseDeskDivNm) {
		this.offerUseDeskDivNm = offerUseDeskDivNm;
	}
	
}
