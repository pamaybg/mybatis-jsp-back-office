package com.icignal.loyalty.promotion.ruleset.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferChildOfferDtlReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferExpDividReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferGradeDtlReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferProductDtlReqDto;
import com.icignal.loyalty.promotion.offer.dto.request.LoyOfferUseDeskDtlReqDto;

/**
 * @name : MKTOfferRequestDTO
 * @date : 2015. 09. 24.
 * @author : 박지열
 * @description : 오퍼 정보 조회
 */

public class LoyOfferEditReqDto extends CommonDataAuthReqDto {

	private String id;                  //아이디
	private String type;                //유형
	private String offerNo;             //오퍼번호
	private String offerName;           //오퍼명
	private String mktOfferCostGbn;     //오퍼비용구분
	private String offerTypeCd;         //오퍼유형
	private String offerSubTypeCd;      //오퍼유형상세
	private String discountType;        //할인유형
	private double discountAmt;         //할인금액
	private String description;         //설명
	private String commStatus;          //상태
	private String applyStrDate;        //적용시작일자
	private String applyEndDate;        //적용종료일자
	private String offerFownerId;       //오퍼재원회사 및 부서코드
	private String parOfferId;          //상위오퍼ID
	private String memId;               //접속 ID
	private String idfyNO;              //쿠폰 번호
	private String accntId;
	private String couponId;            //ym연동 쿠폰 ID
	private String offerAplyDdTypeCd;   //오퍼적용일자구분코드
    private String offerAplyDay;        //오퍼적용일

    private String offerEcnrsDivCd;     //오퍼재원 구분 코드
    private String offerUseDeskDivCd;   //오퍼 사용처 구분코드
    private String dcProdTypeCd;        //할인상품유형코드
    private String coupnApvTypeCd;      //쿠폰승인유형코드
    private String coupnIssTypeCd;      //쿠폰발급유형코드
    private String settlUsePosblYn;     //결제시사용가능여부
    private Double lowstSettlAmt;       //최저결제금액
    private String refKey;              //참조키
    private String coupnTrnsfrYn;       //쿠폰 양도가능여부

    private String ridCoupn;
    private String offerDivCd;          //오퍼등록유형코드(C:캠페인,T:오퍼관리)

    private String selfTotAmt;          // 총 해택 금액

    private String pntValidPeroidType;  //포인트 유효기간 타입
    private String pntValidPeroidVal;   //포인트 유효기간 값
    private String pntTrnsfrYn;         //포인트 양도 가능 여부
    private Double offerSeqNo;          //오퍼 순서

    // 사용처 목록
    private List<LoyOfferUseDeskDtlReqDto> useDeskList;

    // 할인/교환 목록
    private List<LoyOfferProductDtlReqDto> productList;

    // 등급 차감 목록
    private List<LoyOfferGradeDtlReqDto> gradeList;

    // 제원분담 목록
    private List<LoyOfferExpDividReqDto> expDividList;

    // 하위오퍼 목록
    private List<LoyOfferChildOfferDtlReqDto> childOfferList;


    public String getOfferDivCd() {
        return offerDivCd;
    }
    public void setOfferDivCd(String offerDivCd) {
        this.offerDivCd = offerDivCd;
    }
    public String getCoupnTrnsfrYn() {
        return coupnTrnsfrYn;
    }
    public void setCoupnTrnsfrYn(String coupnTrnsfrYn) {
        this.coupnTrnsfrYn = coupnTrnsfrYn;
    }
    public String getRidCoupn() {
        return ridCoupn;
    }
    public void setRidCoupn(String ridCoupn) {
        this.ridCoupn = ridCoupn;
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
	public String getCouponId() {
		return couponId;
	}
	public void setCouponId(String couponId) {
		this.couponId = couponId;
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
    public String getOfferEcnrsDivCd() {
        return offerEcnrsDivCd;
    }
    public void setOfferEcnrsDivCd(String offerEcnrsDivCd) {
        this.offerEcnrsDivCd = offerEcnrsDivCd;
    }
    public String getRefKey() {
        return refKey;
    }
    public void setRefKey(String refKey) {
        this.refKey = refKey;
    }
    public String getCoupnApvTypeCd() {
        return coupnApvTypeCd;
    }
    public void setCoupnApvTypeCd(String coupnApvTypeCd) {
        this.coupnApvTypeCd = coupnApvTypeCd;
    }
    public String getCoupnIssTypeCd() {
        return coupnIssTypeCd;
    }
    public void setCoupnIssTypeCd(String coupnIssTypeCd) {
        this.coupnIssTypeCd = coupnIssTypeCd;
    }
    public String getOfferUseDeskDivCd() {
        return offerUseDeskDivCd;
    }
    public void setOfferUseDeskDivCd(String offerUseDeskDivCd) {
        this.offerUseDeskDivCd = offerUseDeskDivCd;
    }
    public String getDcProdTypeCd() {
        return dcProdTypeCd;
    }
    public void setDcProdTypeCd(String dcProdTypeCd) {
        this.dcProdTypeCd = dcProdTypeCd;
    }
    public String getSettlUsePosblYn() {
        return settlUsePosblYn;
    }
    public void setSettlUsePosblYn(String settlUsePosblYn) {
        this.settlUsePosblYn = settlUsePosblYn;
    }
    public Double getLowstSettlAmt() {
        return lowstSettlAmt;
    }
    public void setLowstSettlAmt(Double lowstSettlAmt) {
        this.lowstSettlAmt = lowstSettlAmt;
    }
    public List<LoyOfferUseDeskDtlReqDto> getUseDeskList() {
        return useDeskList;
    }
    public void setUseDeskList(List<LoyOfferUseDeskDtlReqDto> useDeskList) {
        this.useDeskList = useDeskList;
    }
    public List<LoyOfferGradeDtlReqDto> getGradeList() {
        return gradeList;
    }
    public void setGradeList(List<LoyOfferGradeDtlReqDto> gradeList) {
        this.gradeList = gradeList;
    }
    public String getAccntId() {
        return accntId;
    }
    public void setAccntId(String accntId) {
        this.accntId = accntId;
    }
    public List<LoyOfferProductDtlReqDto> getProductList() {
        return productList;
    }
    public void setProductList(List<LoyOfferProductDtlReqDto> productList) {
        this.productList = productList;
    }
    public List<LoyOfferExpDividReqDto> getExpDividList() {
        return expDividList;
    }
    public void setExpDividList(List<LoyOfferExpDividReqDto> expDividList) {
        this.expDividList = expDividList;
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
	public List<LoyOfferChildOfferDtlReqDto> getChildOfferList() {
		return childOfferList;
	}
	public void setChildOfferList(List<LoyOfferChildOfferDtlReqDto> childOfferList) {
		this.childOfferList = childOfferList;
	}
	public String getPntValidPeroidType() {
		return pntValidPeroidType;
	}
	public void setPntValidPeroidType(String pntValidPeroidType) {
		this.pntValidPeroidType = pntValidPeroidType;
	}
	public String getPntValidPeroidVal() {
		return pntValidPeroidVal;
	}
	public void setPntValidPeroidVal(String pntValidPeroidVal) {
		this.pntValidPeroidVal = pntValidPeroidVal;
	}
	public String getPntTrnsfrYn() {
		return pntTrnsfrYn;
	}
	public void setPntTrnsfrYn(String pntTrnsfrYn) {
		this.pntTrnsfrYn = pntTrnsfrYn;
	}
	public Double getOfferSeqNo() {
		return offerSeqNo;
	}
	public void setOfferSeqNo(Double offerSeqNo) {
		this.offerSeqNo = offerSeqNo;
	}


}
