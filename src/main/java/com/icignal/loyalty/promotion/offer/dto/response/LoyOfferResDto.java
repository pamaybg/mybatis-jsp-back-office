package com.icignal.loyalty.promotion.offer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * @name : MKTOfferResponseDTO
 * @date : 2015. 09. 24.
 * @author : 박지열
 * @description : 오퍼 정보 조회
 */
@CommCode
public class LoyOfferResDto extends GridPagingItemResDto{
	private String id;             //아이디
	private String type;           //유형
	private String offerNo;        //오퍼번호
	private String offerName;      //오퍼명
	
	@MarkName(groupCode = "MKT_OFFER_COST_GBN", codeField = "mktOfferCostGbnCd")
	private String mktOfferCostGbn;//오퍼비용구분
	private String mktOfferCostGbnCd;//오퍼비용구분
	
	@MarkName(groupCode = "OFFER_TYPE_CD", codeField = "offerType")
	private String offerTypeCd;    //오퍼분류
	private String offerType;    //오퍼분류
	
	@MarkName(groupCode = "OFFER_DISCOUNT_TYPE_CD", codeField = "discountTypeCd")
	private String discountType;   //할인유형
	private String discountTypeCd;   //할인유형
	
	
	private double discountAmt;    //할인금액/할인율
	private String description;    //설명
	
	@MarkName(groupCode = "COMM_STATUS", codeField = "commStatusCd")
	private String commStatus;     //상태
	private String commStatusCd;     //상태
	
	private String applyStrDate;   //적용시작일자
	private String applyEndDate;   //적용종료일자
	private String offerFownerId;  //오퍼재원회사
	private String fownerName;     //오퍼재원조직명
	private String parOfferId;     //상위오퍼ID
	private String parOfferName;   //상위오퍼명
	private String memId;          //접속 ID
	private String offerlimit;     //목록 갯수
	private String modifyBy;       //수정자
	private String modifyDate;     //수정일
	private String createBy;       //생성자
	private String createDate;     //생성일
	private String modifyId;       //수정 아이디
	private String idfyNO;         //쿠폰 번호
	private boolean camCehck;      //캠페인 체크
	private String conId;          //캠페인 연결 Id
	private String offerAplyDdTypeNm;   //오퍼적용일자구분명
    private String offerAplyDdTypeCd;   //오퍼적용일자구분코드
    private String offerAplyDay;    //오퍼적용일
    private String offerSubTypeCd;	//오퍼상세유형코드
    
	@MarkName(groupCode = "OFFER_SUB_TYPE_CD", codeField = "offerSubTypeCd")
    private String offerSubTypeNm;	//오퍼상세유형명
	
    private String offerEcnrsDivCd;     //오퍼재원 구분 코드
	@MarkName(groupCode = "OFFER_ECNRS_DIV_CD", codeField = "offerEcnrsDivCd")
    private String offerEcnrsDivNm;     //오퍼재원 구분명
	
	
    private String offerUseDeskDivCd;   //오퍼 사용처 구분코드
    
	@MarkName(groupCode = "OFFER_USE_DESK_DIV_CD", codeField = "offerUseDeskDivCd")
    private String offerUseDeskDivNm;   //오퍼 사용처 구분명

	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getOfferlimit() {
		return offerlimit;
	}
	public void setOfferlimit(String offerlimit) {
		this.offerlimit = offerlimit;
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
	public String getParOfferName() {
		return parOfferName;
	}
	public void setParOfferName(String parOfferName) {
		this.parOfferName = parOfferName;
	}
	public String getModifyId() {
		return modifyId;
	}
	public void setModifyId(String modifyId) {
		this.modifyId = modifyId;
	}
	public String getIdfyNO() {
		return idfyNO;
	}
	public void setIdfyNO(String idfyNO) {
		this.idfyNO = idfyNO;
	}
	public String getFownerName() {
		return fownerName;
	}
	public void setFownerName(String fownerName) {
		this.fownerName = fownerName;
	}
	public boolean isCamCehck() {
		return camCehck;
	}
	public void setCamCehck(boolean camCehck) {
		this.camCehck = camCehck;
	}
	public String getConId() {
		return conId;
	}
	public void setConId(String conId) {
		this.conId = conId;
	}
	public String getOfferAplyDdTypeNm() {
		return offerAplyDdTypeNm;
	}
	public void setOfferAplyDdTypeNm(String offerAplyDdTypeNm) {
		this.offerAplyDdTypeNm = offerAplyDdTypeNm;
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
	public String getMktOfferCostGbnCd() {
		return mktOfferCostGbnCd;
	}
	public void setMktOfferCostGbnCd(String mktOfferCostGbnCd) {
		this.mktOfferCostGbnCd = mktOfferCostGbnCd;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public String getDiscountTypeCd() {
		return discountTypeCd;
	}
	public void setDiscountTypeCd(String discountTypeCd) {
		this.discountTypeCd = discountTypeCd;
	}
	public String getCommStatusCd() {
		return commStatusCd;
	}
	public void setCommStatusCd(String commStatusCd) {
		this.commStatusCd = commStatusCd;
	}




}
