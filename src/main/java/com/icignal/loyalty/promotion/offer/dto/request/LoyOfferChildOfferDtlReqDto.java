package com.icignal.loyalty.promotion.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyOfferChildOfferDtlReqDto extends CommonDataAuthReqDto {
    
    private String rid;               //RID
    private String ridMktOfferMst;    //RID_오퍼마스터
    private String dataStatus;        //수정상태
    
    private String parentOfferId;     	//상위 오퍼 아이디
    private String childOfferId;     	//하위 오퍼 아이디
    private Integer selfMinAmt;     	//최소 해택 범위
    private Integer selfMaxAmt;     	//최대 해택 범위
    private String selfUnitCd;     		//단위
    private Integer selfGiftAmt;     	//사은품금액
    private Integer selfValueRate;     	//가치 비율
    
    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getRidMktOfferMst() {
        return ridMktOfferMst;
    }

    public void setRidMktOfferMst(String ridMktOfferMst) {
        this.ridMktOfferMst = ridMktOfferMst;
    }

    public String getDataStatus() {
        return dataStatus;
    }

    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }

	public String getParentOfferId() {
		return parentOfferId;
	}

	public void setParentOfferId(String parentOfferId) {
		this.parentOfferId = parentOfferId;
	}

	public String getChildOfferId() {
		return childOfferId;
	}

	public void setChildOfferId(String childOfferId) {
		this.childOfferId = childOfferId;
	}

	public Integer getSelfMinAmt() {
		return selfMinAmt;
	}

	public void setSelfMinAmt(Integer selfMinAmt) {
		this.selfMinAmt = selfMinAmt;
	}

	public Integer getSelfMaxAmt() {
		return selfMaxAmt;
	}

	public void setSelfMaxAmt(Integer selfMaxAmt) {
		this.selfMaxAmt = selfMaxAmt;
	}

	public String getSelfUnitCd() {
		return selfUnitCd;
	}

	public void setSelfUnitCd(String selfUnitCd) {
		this.selfUnitCd = selfUnitCd;
	}

	public Integer getSelfGiftAmt() {
		return selfGiftAmt;
	}

	public void setSelfGiftAmt(Integer selfGiftAmt) {
		this.selfGiftAmt = selfGiftAmt;
	}

	public Integer getSelfValueRate() {
		return selfValueRate;
	}

	public void setSelfValueRate(Integer selfValueRate) {
		this.selfValueRate = selfValueRate;
	}

	@Override
	public String toString() {
		return "MKTOfferChildOfferDtlRequestDTO [" + (rid != null ? "rid=" + rid + ", " : "")
				+ (ridMktOfferMst != null ? "ridMktOfferMst=" + ridMktOfferMst + ", " : "")
				+ (dataStatus != null ? "dataStatus=" + dataStatus + ", " : "")
				+ (parentOfferId != null ? "parentOfferId=" + parentOfferId + ", " : "")
				+ (childOfferId != null ? "childOfferId=" + childOfferId + ", " : "")
				+ (selfMinAmt != null ? "selfMinAmt=" + selfMinAmt + ", " : "")
				+ (selfMaxAmt != null ? "selfMaxAmt=" + selfMaxAmt + ", " : "")
				+ (selfUnitCd != null ? "selfUnitCd=" + selfUnitCd + ", " : "")
				+ (selfGiftAmt != null ? "selfGiftAmt=" + selfGiftAmt + ", " : "")
				+ (selfValueRate != null ? "selfValueRate=" + selfValueRate : "") + "]";
	}
    
}
