package com.icignal.loyalty.promotion.offer.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * @name : LOYLoyOfferExpDividResponseDTO.java
 * @date : 2017. 01. 02.
 * @author : dg.ryu
 * @description : 로얄티 오퍼 분담률 ResponseDTO
 */

@CommCode
public class LoyOfferExpDividResDto extends MKTBaseReqDto {

	private String rid;                //RID
	private String ridMktOfferMst;     //RID_오퍼마스터
	private String settleTypeCd;       //정산 유형 코드
	@MarkName(groupCode = "LOY_SETTLE_TYPE_CD", codeField = "settleTypeCd")
	private String settleTypeNm;       //정산 유형명
	private String settleDtlTypeCd;    //정산 상세 유형 코드
	@MarkName(groupCode = "LOY_SETTLE_DTL_TYPE_CD", codeField = "settleDtlTypeCd")
	private String settleDtlTypeNm;    //정산 상세 유형 코드명
	private String dividorTypeCd;      //분담처 유형 코드
	@MarkName(groupCode = "LOY_SHCHN_TYPE_CD", codeField = "dividorTypeCd")
	private String dividorTypeNm;      //분담처 유형 코드명
	private String ridDividorChnl;     //RID_분담처 채널
	private String dividor;            //분담처
	private String dividVal;           //분담 값
	private String dividUnit;          //분담 단위
	@MarkName(groupCode = "LOY_ACRL_TYPE", codeField = "dividUnit")
	private String dividUnitNm;        //분담 단위
	private String createDate;         //CREATE_DATE
	private String createByNm;         //CREATE_BY
	
	private String dividDesc;          //비고
	
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

	public String getSettleTypeNm() {
		return settleTypeNm;
	}

	public void setSettleTypeNm(String settleTypeNm) {
		this.settleTypeNm = settleTypeNm;
	}

	public String getSettleDtlTypeCd() {
		return settleDtlTypeCd;
	}

	public void setSettleDtlTypeCd(String settleDtlTypeCd) {
		this.settleDtlTypeCd = settleDtlTypeCd;
	}

	public String getSettleDtlTypeNm() {
		return settleDtlTypeNm;
	}

	public void setSettleDtlTypeNm(String settleDtlTypeNm) {
		this.settleDtlTypeNm = settleDtlTypeNm;
	}

	public String getDividorTypeCd() {
		return dividorTypeCd;
	}

	public void setDividorTypeCd(String dividorTypeCd) {
		this.dividorTypeCd = dividorTypeCd;
	}

	public String getDividorTypeNm() {
		return dividorTypeNm;
	}

	public void setDividorTypeNm(String dividorTypeNm) {
		this.dividorTypeNm = dividorTypeNm;
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

	public String getDividUnitNm() {
		return dividUnitNm;
	}

	public void setDividUnitNm(String dividUnitNm) {
		this.dividUnitNm = dividUnitNm;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}

    public String getDividDesc() {
        return dividDesc;
    }

    public void setDividDesc(String dividDesc) {
        this.dividDesc = dividDesc;
    }

}
