package com.icignal.onlineapproval.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 승인레포트 : 오퍼 정보 Response DTO
 * 
 * @name : infavor.marketing.elapproval.dto.response.MKTApprovalReportOfferResponseDTO
 * @date : 2018. 2. 28.
 * @author : jh.kim
 * @description : 
 */

@CommCode
public class AprvReportOfferResDto {

    private String offerNm;             // 오퍼명
    private String offerDesc;           // 오퍼내용
    private String offerTypeCd;         // 오퍼유형코드
    
    @MarkName(groupCode = "OFFER_TYPE_CD", codeField = "offerTypeCd")
    private String offerTypeNm;         // 오퍼유형명
    
    private String offerSubTypeCd;      // 오퍼유형상세코드
    
    @MarkName(groupCode = "OFFER_SUB_TYPE_CD", codeField = "offerSubTypeCd")
    private String offerSubTypeNm;      // 오퍼유형상세명
    private String refKey;              // 참조값 rid
    private String prodNm;              // 참조값명
    private String offerUseDeskDivCd;   // 사용처 코드
    
    @MarkName(groupCode = "OFFER_USE_DESK_DIV_CD", codeField = "offerUseDeskDivCd")
    private String offerUseDeskDivNm;   // 사용처 명
    private String offerEcnrsDivCd;     // 재원
    
    @MarkName(groupCode = "OFFER_ECNRS_DIV_CD", codeField = "offerEcnrsDivCd")
    private String offerEcnrsDivNm;     // 재원 명
    private String divIdVal;			// 분담율
    
    private String vsBasCode;
    @MarkName(groupCode = "LOY_VALID_STARTDT_BAS_CD", codeField = "vsBasCode")
    private String vsBasCd;				// 포인트 기준 일자 유형
    private String startDtnum;			// 혜택 시작일
    private String vsDtnum;				// 소멸 예정월
    private String aplyStartDd;			// 유효일자 시작일
    private String aplyEndDd;			// 유효일자 종료일
    private String offerAplyDay;		// 오퍼 적용 기준일
    private String selfTotAmt;			// 지급 포인트
    private String offerNotiOne; 		// 쿠폰유의사항 1
    private String offerNotiTwo;		// 쿠폰 유의사항 2
    private String offerNotiThree;		// 쿠폰 유의사항 3
    private String dividName;			//분담처
    
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

	public String getOfferAplyDay() {
		return offerAplyDay;
	}

	public void setOfferAplyDay(String offerAplyDay) {
		this.offerAplyDay = offerAplyDay;
	}

	public String getSelfTotAmt() {
		return selfTotAmt;
	}

	public void setSelfTotAmt(String selfTotAmt) {
		this.selfTotAmt = selfTotAmt;
	}

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

	public String getVsBasCd() {
		return vsBasCd;
	}

	public void setVsBasCd(String vsBasCd) {
		this.vsBasCd = vsBasCd;
	}

	public String getStartDtnum() {
		return startDtnum;
	}

	public void setStartDtnum(String startDtnum) {
		this.startDtnum = startDtnum;
	}

	public String getVsDtnum() {
		return vsDtnum;
	}

	public void setVsDtnum(String vsDtnum) {
		this.vsDtnum = vsDtnum;
	}

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getOfferNm() {
        return offerNm;
    }

    public void setOfferNm(String offerNm) {
        this.offerNm = offerNm;
    }

    public String getOfferDesc() {
        return offerDesc;
    }

    public void setOfferDesc(String offerDesc) {
        this.offerDesc = offerDesc;
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

    public String getRefKey() {
        return refKey;
    }

    public void setRefKey(String refKey) {
        this.refKey = refKey;
    }

    public String getProdNm() {
        return prodNm;
    }

    public void setProdNm(String prodNm) {
        this.prodNm = prodNm;
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

	public String getDivIdVal() {
		return divIdVal;
	}

	public void setDivIdVal(String divIdVal) {
		this.divIdVal = divIdVal;
	}

	public String getDividName() {
		return dividName;
	}

	public void setDividName(String dividName) {
		this.dividName = dividName;
	}

	public String getVsBasCode() {
		return vsBasCode;
	}

	public void setVsBasCode(String vsBasCode) {
		this.vsBasCode = vsBasCode;
	}
    
}
