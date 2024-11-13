package com.icignal.loyalty.promotion.offer.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : LOYLoyOfferMstRequestDTO.java
 * @date : 2017. 01. 02.
 * @author : dg.ryu
 * @description : loyOffer Mst RequestDTO
 */
public class LoyOfferMstReqDto extends CommonDataAuthReqDto {

	private String id;                    //아이디
	private String type;				   //유형
	private String offerNo;               //오퍼번호
	private String offerNm;               //오퍼명
	private String offerCostDivCd;        //오퍼비용구분코드
	private String offerTypeCd;           //오퍼유형코드
	private String offerSubTypeCd;		   //오퍼상세유형코드
	private String dcTypeCd;              //할인유형코드
	private String dcAmt;                 //할인금액/할인율
	private String offerDesc;             //설명
	private String offerStatusCd;         //오퍼상태코드
	private String aplyStartDd;           //적용시작일자
	private String aplyEndDd;             //적용종료일자
	private String offerEcnrsAccntId;     //오퍼재원회사/부서코드
	private String parOfferId;            //상위오퍼ID
	private String typeIdfyNo;            //오퍼유형식별번호
	private String extrRefId;             //외부참고아이디
	private String offerAplyDdTypeCd;     //오퍼적용일 구분코드 아이디
	private String offerAplyDay;          //오퍼적용기준일
	private String selfTotAmt;			  //혜택 포인트
	private String ridCoupon;			  //쿠폰 ID
	private String camId;			      //캠페인 아이디
	private String offerNotiOne;		  //쿠폰유의사항1
	private String offerNotiTwo;		  //쿠폰유의사항2
	private String offerNotiThree;		  //쿠폰유의사항3
	private String couponNm;			  //쿠폰명
	private String camStartDd;			  //캠페인 시작시간
	private String camEndDd;			  //캠페인 종료시간
	private String offerDivCd;

	private List<LoyOfferExpDividReqDto> expDividList;	//분담률
	private List<LoyGetOfferReqDto> useLmtChnlList;	//제한채널
	private List<LoyGetOfferReqDto> useLmtProdList;	//제한모델
	private List<LoyGetOfferReqDto> pntDtlList;	//포인트
	
	
	
    public String getOfferNotiOne() {
		return offerNotiOne;
	}

	public void setOfferNotiOne(String offerNotiOne) {
		this.offerNotiOne = offerNotiOne;
	}

	public String getOfferNotiTwo() {
		return offerNotiTwo;
	}

	public void setOfferNotiTwo(String offerNotiTwo) {
		this.offerNotiTwo = offerNotiTwo;
	}

	public String getOfferNotiThree() {
		return offerNotiThree;
	}

	public void setOfferNotiThree(String offerNotiThree) {
		this.offerNotiThree = offerNotiThree;
	}

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getOfferDivCd() {
        return offerDivCd;
    }

    public void setOfferDivCd(String offerDivCd) {
        this.offerDivCd = offerDivCd;
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

	public String getOfferTypeCd() {
		return offerTypeCd;
	}

	public void setOfferTypeCd(String offerTypeCd) {
		this.offerTypeCd = offerTypeCd;
	}

	public String getDcTypeCd() {
		return dcTypeCd;
	}

	public void setDcTypeCd(String dcTypeCd) {
		this.dcTypeCd = dcTypeCd;
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

	public List<LoyOfferExpDividReqDto> getExpDividList() {
		return expDividList;
	}

	public void setExpDividList(List<LoyOfferExpDividReqDto> expDividList) {
		this.expDividList = expDividList;
	}

	public List<LoyGetOfferReqDto> getUseLmtChnlList() {
		return useLmtChnlList;
	}

	public void setUseLmtChnlList(List<LoyGetOfferReqDto> useLmtChnlList) {
		this.useLmtChnlList = useLmtChnlList;
	}

	public List<LoyGetOfferReqDto> getUseLmtProdList() {
		return useLmtProdList;
	}

	public void setUseLmtProdList(List<LoyGetOfferReqDto> useLmtProdList) {
		this.useLmtProdList = useLmtProdList;
	}

	public List<LoyGetOfferReqDto> getPntDtlList() {
		return pntDtlList;
	}

	public void setPntDtlList(List<LoyGetOfferReqDto> pntDtlList) {
		this.pntDtlList = pntDtlList;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOfferSubTypeCd() {
		return offerSubTypeCd;
	}

	public void setOfferSubTypeCd(String offerSubTypeCd) {
		this.offerSubTypeCd = offerSubTypeCd;
	}

	public String getSelfTotAmt() {
		return selfTotAmt;
	}

	public void setSelfTotAmt(String selfTotAmt) {
		this.selfTotAmt = selfTotAmt;
	}

	public String getRidCoupon() {
		return ridCoupon;
	}

	public void setRidCoupon(String ridCoupon) {
		this.ridCoupon = ridCoupon;
	}

	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}

	public String getCouponNm() {
		return couponNm;
	}

	public void setCouponNm(String couponNm) {
		this.couponNm = couponNm;
	}

	public String getCamStartDd() {
		return camStartDd;
	}

	public void setCamStartDd(String camStartDd) {
		this.camStartDd = camStartDd;
	}

	public String getCamEndDd() {
		return camEndDd;
	}

	public void setCamEndDd(String camEndDd) {
		this.camEndDd = camEndDd;
	}


}
