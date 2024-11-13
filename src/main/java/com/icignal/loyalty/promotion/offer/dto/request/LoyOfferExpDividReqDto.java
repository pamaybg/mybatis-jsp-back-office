package com.icignal.loyalty.promotion.offer.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;


/**
 * @name : LOYLoyOfferExpDividRequestDTO.java
 * @date : 2017. 01. 02.
 * @author : dg.ryu
 * @description : 로얄티 오퍼 분담률 RequestDTO
 */
public class LoyOfferExpDividReqDto extends MKTBaseReqDto {

	private String rid;                //RID
	private String ridMktOfferMst;     //RID_오퍼마스터
	private String settleTypeCd;       //정산 유형 코드
	private String settleDtlTypeCd;    //정산 상세 유형 코드
	private String dividorTypeCd;      //분담처 유형 코드
	private String ridDividorChnl;     //RID_분담처 채널
	private String dividor;            //분담처
	private String dividVal;           //분담 값
	private String dividUnit;          //분담 단위
	private String offerNo;            //분담 단위
	private String dividDesc;			//비고
    public String getOfferNo() {
        return offerNo;
    }

    public void setOfferNo(String offerNo) {
        this.offerNo = offerNo;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

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

	public String getSettleTypeCd() {
		return settleTypeCd;
	}

	public void setSettleTypeCd(String settleTypeCd) {
		this.settleTypeCd = settleTypeCd;
	}

	public String getSettleDtlTypeCd() {
		return settleDtlTypeCd;
	}

	public void setSettleDtlTypeCd(String settleDtlTypeCd) {
		this.settleDtlTypeCd = settleDtlTypeCd;
	}

	public String getDividorTypeCd() {
		return dividorTypeCd;
	}

	public void setDividorTypeCd(String dividorTypeCd) {
		this.dividorTypeCd = dividorTypeCd;
	}

	public String getRidDividorChnl() {
		return ridDividorChnl;
	}

	public void setRidDividorChnl(String ridDividorChnl) {
		this.ridDividorChnl = ridDividorChnl;
	}

	public String getDividor() {
		return dividor;
	}

	public void setDividor(String dividor) {
		this.dividor = dividor;
	}

	public String getDividVal() {
		return dividVal;
	}

	public void setDividVal(String dividVal) {
		this.dividVal = dividVal;
	}

	public String getDividUnit() {
		return dividUnit;
	}

	public void setDividUnit(String dividUnit) {
		this.dividUnit = dividUnit;
	}

	public String getDividDesc() {
		return dividDesc;
	}

	public void setDividDesc(String dividDesc) {
		this.dividDesc = dividDesc;
	}

}
