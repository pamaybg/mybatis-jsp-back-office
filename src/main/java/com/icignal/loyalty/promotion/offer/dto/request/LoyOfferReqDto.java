package com.icignal.loyalty.promotion.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MKTOfferRequestDTO
 * @date : 2015. 09. 24.
 * @author : 박지열
 * @description : 오퍼 정보 조회
 */

public class LoyOfferReqDto  extends CommonDataAuthReqDto {
	private String id;             //아이디
	private String type;           //유형
	private String offerNo;        //오퍼번호
	private String offerName;      //오퍼명
	private String mktOfferCostGbn;//오퍼비용구분
	private String offerTypeCd;    //오퍼분류
	private String discountType;   //할인유형
	private double discountAmt;    //할인금액
	private String description;    //설명
	private String commStatus;     //상태
	private String applyStrDate;   //적용시작일자
	private String applyEndDate;   //적용종료일자
	private String offerFownerId;  //오퍼재원회사 및 부서코드
	private String parOfferId;     //상위오퍼ID
	private String memId;          //접속 ID
	private String idfyNO;         //쿠폰 번호
	private String accntId;        //어카운트 Id
	private String chnlId;         //채널 아이디
	private String fileType;       //파일 확장아
	private String couponId;       //ym연동 쿠폰 목록 rowId
	
	private String offerStatusCd;  //오퍼상태코드

	public String getOfferStatusCd() {
        return offerStatusCd;
    }
    public void setOfferStatusCd(String offerStatusCd) {
        this.offerStatusCd = offerStatusCd;
    }
    public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public double getDiscountAmt() {
		return discountAmt;
	}
	public void setDiscountAmt(double discountAmt) {
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
	public String getIdfyNO() {
		return idfyNO;
	}
	public void setIdfyNO(String idfyNO) {
		this.idfyNO = idfyNO;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getChnlId() {
		return chnlId;
	}
	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public String getCouponId() {
		return couponId;
	}
	public void setCouponId(String couponId) {
		this.couponId = couponId;
	}
	

	
}
