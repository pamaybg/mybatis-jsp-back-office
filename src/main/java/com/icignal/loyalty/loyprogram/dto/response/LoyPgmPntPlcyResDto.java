package com.icignal.loyalty.loyprogram.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

@CommCode
public class LoyPgmPntPlcyResDto extends GridPagingItemResDto {

	// 기본 필드
	private String useUnit;           /* 사용단위 */
	private String useHudl;			  /* 사용허들 */
	private String usePerMax;		  /* 1회 최대 사용 금액 */
	private String use1DayMax;		  /* 1일 최대 사용 금액 */
	private String usePwYn;		      /* 비밀번호 사용 여부 */
	private String useMinusYn;		  /* 마이너스 포인트 여부 */
	private String useGiftCancYn;	  /* 선물 취소 여부 */
	private String roundNum;          /* 적립절삭자리수 */
	private String useGiftMaxAmt; 	/* 선물최대금액 */
	
	// 코드
	private String pntUseGiftRange;    /* 선물 가능 범위 */
	private String pntUseRdmSeq;       /* 차감 순서 */
	private String pntCalcType;        /* 계산 방식 */
	private String pntRoundType;       /* 절삭 방식 */

	// 시스템
	private String rid;            		/* RID */
	private String modifyDate;          /* 수정일시 */
	private String modifyBy;            /* 수정자 */
	private String ofrRid;
	private String ofrNm;
	
	private String giftEndTypeCd;
	private int rdmCnclEtDay;
	
	private float giftFeeCntAmt;
	private float giftFeeMileageAmt;
	
	public String getOfrNm() {
		return ofrNm;
	}
	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}
	public String getOfrRid() {
		return ofrRid;
	}
	public void setOfrRid(String ofrRid) {
		this.ofrRid = ofrRid;
	}
	public String getUseUnit() {
		return useUnit;
	}
	public void setUseUnit(String useUnit) {
		this.useUnit = useUnit;
	}
	public String getUseHudl() {
		return useHudl;
	}
	public void setUseHudl(String useHudl) {
		this.useHudl = useHudl;
	}
	public String getUsePerMax() {
		return usePerMax;
	}
	public void setUsePerMax(String usePerMax) {
		this.usePerMax = usePerMax;
	}
	public String getUse1DayMax() {
		return use1DayMax;
	}
	public void setUse1DayMax(String use1DayMax) {
		this.use1DayMax = use1DayMax;
	}
	public String getUsePwYn() {
		return usePwYn;
	}
	public void setUsePwYn(String usePwYn) {
		this.usePwYn = usePwYn;
	}
	public String getUseMinusYn() {
		return useMinusYn;
	}
	public void setUseMinusYn(String useMinusYn) {
		this.useMinusYn = useMinusYn;
	}
	public String getUseGiftCancYn() {
		return useGiftCancYn;
	}
	public void setUseGiftCancYn(String useGiftCancYn) {
		this.useGiftCancYn = useGiftCancYn;
	}
	public String getRoundNum() {
		return roundNum;
	}
	public void setRoundNum(String roundNum) {
		this.roundNum = roundNum;
	}
	public String getPntUseGiftRange() {
		return pntUseGiftRange;
	}
	public void setPntUseGiftRange(String pntUseGiftRange) {
		this.pntUseGiftRange = pntUseGiftRange;
	}
	public String getPntUseRdmSeq() {
		return pntUseRdmSeq;
	}
	public void setPntUseRdmSeq(String pntUseRdmSeq) {
		this.pntUseRdmSeq = pntUseRdmSeq;
	}
	public String getPntCalcType() {
		return pntCalcType;
	}
	public void setPntCalcType(String pntCalcType) {
		this.pntCalcType = pntCalcType;
	}
	public String getPntRoundType() {
		return pntRoundType;
	}
	public void setPntRoundType(String pntRoundType) {
		this.pntRoundType = pntRoundType;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getUseGiftMaxAmt() {
		return useGiftMaxAmt;
	}
	public void setUseGiftMaxAmt(String useGiftMaxAmt) {
		this.useGiftMaxAmt = useGiftMaxAmt;
	}
	public String getGiftEndTypeCd() {
		return giftEndTypeCd;
	}
	public void setGiftEndTypeCd(String giftEndTypeCd) {
		this.giftEndTypeCd = giftEndTypeCd;
	}
	public int getRdmCnclEtDay() {
		return rdmCnclEtDay;
	}
	public void setRdmCnclEtDay(int rdmCnclEtDay) {
		this.rdmCnclEtDay = rdmCnclEtDay;
	}
	public float getGiftFeeCntAmt() {
		return giftFeeCntAmt;
	}
	public void setGiftFeeCntAmt(float giftFeeCntAmt) {
		this.giftFeeCntAmt = giftFeeCntAmt;
	}
	public float getGiftFeeMileageAmt() {
		return giftFeeMileageAmt;
	}
	public void setGiftFeeMileageAmt(float giftFeeMileageAmt) {
		this.giftFeeMileageAmt = giftFeeMileageAmt;
	}

	
}
