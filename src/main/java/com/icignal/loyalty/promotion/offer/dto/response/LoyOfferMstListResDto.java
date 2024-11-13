package com.icignal.loyalty.promotion.offer.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * @name : LOYLoyOfferMstListResponseDTO.java
 * @date : 2017. 01. 02.
 * @author : dg.ryu
 * @description : 로얄티 오퍼 마스터 목록 ResponseDTO
 */

@CommCode
public class LoyOfferMstListResDto extends GridPagingItemResDto {
	
	private String id;                    //아이디
	private String offerNo;               //오퍼번호
	private String offerNm;               //오퍼명
	
	private String offerCostDivCd;        //오퍼비용구분코드
	@MarkName(groupCode = "MKT_OFFER_COST_GBN", codeField = "offerCostDivCd")
	private String offerCostDivNm;        //오퍼비용구분명
	
	private String offerTypeCd;           //오퍼유형코드
	@MarkName(groupCode = "OFFER_TYPE_CD", codeField = "offerTypeCd")
	private String offerTypeNm;           //오퍼유형명
	
	private String dcTypeCd;              //할인유형코드
	@MarkName(groupCode = "OFFER_DISCOUNT_TYPE_CD", codeField = "dcTypeCd")
	private String dcTypeNm;              //할인유형명
	
	private String dcAmt;                 //할인금액/할인율
	private String offerDesc;             //설명
	
	private String offerStatusCd;         //오퍼상태코드
	@MarkName(groupCode = "COMM_STATUS", codeField = "offerStatusCd")
	private String offerStatusNm;         //오퍼상태명
	
	private String aplyStartDd;           //적용시작일자
	private String aplyEndDd;             //적용종료일자
	private String offerEcnrsAccntId;     //오퍼재원회사/부서코드
	private String parOfferId;            //상위오퍼ID
	private String typeIdfyNo;            //오퍼유형식별번호
	private String extrRefId;             //외부참고아이디
	private String offerAplyDdTypeCd;     //오퍼적용일 구분코드 아이디
	private String offerAplyDay;          //오퍼적용기준일
	private String createByNm;			//등록자명
	private String createDate;			//등록일
	
	private String offerSubTypeCd;
	@MarkName(groupCode = "OFFER_SUB_TYPE_CD", codeField = "offerSubTypeCd")
	private String offerSubTypeNm;
	
	
	public String getOfferSubTypeCd() {
		return offerSubTypeCd;
	}

	public void setOfferSubTypeCd(String offerSubTypeCd) {
		this.offerSubTypeCd = offerSubTypeCd;
	}

	public String getOfferSubTypeNm() {
		return offerSubTypeNm;
	}

	public void setOfferSubTypeNm(String offerSubTypeNm) {
		this.offerSubTypeNm = offerSubTypeNm;
	}
	 
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOfferNo() {
		return offerNo;
	}

	public void setOfferNo(String offerNo) {
		this.offerNo = offerNo;
	}

	public String getOfferNm() {
		return offerNm;
	}

	public void setOfferNm(String offerNm) {
		this.offerNm = offerNm;
	}

	public String getOfferCostDivCd() {
		return offerCostDivCd;
	}

	public void setOfferCostDivCd(String offerCostDivCd) {
		this.offerCostDivCd = offerCostDivCd;
	}

	public String getOfferCostDivNm() {
		return offerCostDivNm;
	}

	public void setOfferCostDivNm(String offerCostDivNm) {
		this.offerCostDivNm = offerCostDivNm;
	}

	public String getOfferTypeCd() {
		return offerTypeCd;
	}

	public void setOfferTypeCd(String offerTypeCd) {
		this.offerTypeCd = offerTypeCd;
	}

	public String getOfferTypeNm() {
		return offerTypeNm;
	}

	public void setOfferTypeNm(String offerTypeNm) {
		this.offerTypeNm = offerTypeNm;
	}

	public String getDcTypeCd() {
		return dcTypeCd;
	}

	public void setDcTypeCd(String dcTypeCd) {
		this.dcTypeCd = dcTypeCd;
	}

	public String getDcTypeNm() {
		return dcTypeNm;
	}

	public void setDcTypeNm(String dcTypeNm) {
		this.dcTypeNm = dcTypeNm;
	}

	public String getDcAmt() {
		return dcAmt;
	}

	public void setDcAmt(String dcAmt) {
		this.dcAmt = dcAmt;
	}

	public String getOfferDesc() {
		return offerDesc;
	}

	public void setOfferDesc(String offerDesc) {
		this.offerDesc = offerDesc;
	}

	public String getOfferStatusCd() {
		return offerStatusCd;
	}

	public void setOfferStatusCd(String offerStatusCd) {
		this.offerStatusCd = offerStatusCd;
	}

	public String getOfferStatusNm() {
		return offerStatusNm;
	}

	public void setOfferStatusNm(String offerStatusNm) {
		this.offerStatusNm = offerStatusNm;
	}

	public String getAplyStartDd() {
		return aplyStartDd;
	}

	public void setAplyStartDd(String aplyStartDd) {
		this.aplyStartDd = aplyStartDd;
	}

	public String getAplyEndDd() {
		return aplyEndDd;
	}

	public void setAplyEndDd(String aplyEndDd) {
		this.aplyEndDd = aplyEndDd;
	}

	public String getOfferEcnrsAccntId() {
		return offerEcnrsAccntId;
	}

	public void setOfferEcnrsAccntId(String offerEcnrsAccntId) {
		this.offerEcnrsAccntId = offerEcnrsAccntId;
	}

	public String getParOfferId() {
		return parOfferId;
	}

	public void setParOfferId(String parOfferId) {
		this.parOfferId = parOfferId;
	}

	public String getTypeIdfyNo() {
		return typeIdfyNo;
	}

	public void setTypeIdfyNo(String typeIdfyNo) {
		this.typeIdfyNo = typeIdfyNo;
	}

	public String getExtrRefId() {
		return extrRefId;
	}

	public void setExtrRefId(String extrRefId) {
		this.extrRefId = extrRefId;
	}

	public String getOfferAplyDdTypeCd() {
		return offerAplyDdTypeCd;
	}

	public void setOfferAplyDdTypeCd(String offerAplyDdTypeCd) {
		this.offerAplyDdTypeCd = offerAplyDdTypeCd;
	}

	public String getOfferAplyDay() {
		return offerAplyDay;
	}

	public void setOfferAplyDay(String offerAplyDay) {
		this.offerAplyDay = offerAplyDay;
	}

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	
}
