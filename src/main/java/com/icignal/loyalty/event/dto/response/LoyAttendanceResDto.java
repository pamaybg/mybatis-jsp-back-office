package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @fileName : LOYTicketHistListResponseDTO.java
 * @project : 
 * @date : 2019. 9. 4.
 * @author : jh.seo  
 * @descripton : 출석이벤트 이력 조회 응답 DTO
 */
public class LoyAttendanceResDto extends GridPagingItemResDto {
	
	private String pstMbrRid;			//회원번호
	private String pstDt;				//일자
	private String custNm;				//회원명
	private String mbrNo;				//회원번호
	private String modifyDate;			//이벤트 일시
	private String pntAmt;				//적립포인트
	private String txnUniqNo;			//거래번호
	private String mbrStat;				//회원상태
	private String acrlAmt;				//총 적립 포인트
	private String tot100p;				//100포인트 총합
	private String tot200p;				//200포인트 총합
	private String tot500p;				//500포인트 총합
	private String tot5000p;			//5000포인트 총합
	private String ridMbr;
	private String GenderTypeCd;
	private String lang;
	private String groupCode;
	private String codeNAme;
	
	public String getPstMbrRid() {
		return pstMbrRid;
	}
	public void setPstMbrRid(String pstMbrRid) {
		this.pstMbrRid = pstMbrRid;
	}
	public String getPstDt() {
		return pstDt;
	}
	public void setPstDt(String pstDt) {
		this.pstDt = pstDt;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getPntAmt() {
		return pntAmt;
	}
	public void setPntAmt(String pntAmt) {
		this.pntAmt = pntAmt;
	}
	public String getTxnUniqNo() {
		return txnUniqNo;
	}
	public void setTxnUniqNo(String txnUniqNo) {
		this.txnUniqNo = txnUniqNo;
	}
	public String getMbrStat() {
		return mbrStat;
	}
	public void setMbrStat(String mbrStat) {
		this.mbrStat = mbrStat;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getTot100p() {
		return tot100p;
	}
	public void setTot100p(String tot100p) {
		this.tot100p = tot100p;
	}
	public String getTot200p() {
		return tot200p;
	}
	public void setTot200p(String tot200p) {
		this.tot200p = tot200p;
	}
	public String getTot500p() {
		return tot500p;
	}
	public void setTot500p(String tot500p) {
		this.tot500p = tot500p;
	}
	public String getTot5000p() {
		return tot5000p;
	}
	public void setTot2000p(String tot5000p) {
		this.tot5000p = tot5000p;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	/**
	 * @fileName : LOYTicketHistListResponseDTO.java
	 * @project : 
	 * @date : 2019. 11. 15.
	 * @author : hr.noh  
	 * @descripton : 출석이벤트 이력 조회 응답 DTO 추가 수정
	 */
	private String acrlJoin;	//참여횟수
	private String totMbr;		//참여인원
	private String genGbnCd;	//성별
	private String smokeYn;		//흡연여부
	private String cnt100p;		//100포인트 건수
	private String cnt200p;		//200포인트 건수
	private String cnt500p;		//500포인트 건수
	private String cnt5000p;	//5000포인트 건수
	private String age;		//나이
	private String ageGroup; //연령대
	private String s10;
	private String s20;
	private String s30;
	private String s40;
	private String s50;
	private String over60s;

	
	public String getGenGbnCd() {
		return genGbnCd;
	}
	public void setGenGbnCd(String genGbnCd) {
		this.genGbnCd = genGbnCd;
	}
	public String getAcrlJoin() {
		return acrlJoin;
	}
	public void setAcrlJoin(String acrlJoin) {
		this.acrlJoin = acrlJoin;
	}
	public String getTotMbr() {
		return totMbr;
	}
	public void setTotMbr(String totMbr) {
		this.totMbr = totMbr;
	}
	public String getSmokeYn() {
		return smokeYn;
	}
	public void setSmokeYn(String smokeYn) {
		this.smokeYn = smokeYn;
	}
	public String getCnt100p() {
		return cnt100p;
	}
	public void setCnt100p(String cnt100p) {
		this.cnt100p = cnt100p;
	}
	public String getCnt200p() {
		return cnt200p;
	}
	public void setCnt200p(String cnt200p) {
		this.cnt200p = cnt200p;
	}
	public String getCnt500p() {
		return cnt500p;
	}
	public void setCnt500p(String cnt500p) {
		this.cnt500p = cnt500p;
	}
	public String getCnt5000p() {
		return cnt5000p;
	}
	public void setCnt5000p(String cnt5000p) {
		this.cnt5000p = cnt5000p;
	}
	public void setTot5000p(String tot5000p) {
		this.tot5000p = tot5000p;
	}
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getAgeGroup() {
		return ageGroup;
	}
	public void setAgeGroup(String ageGroup) {
		this.ageGroup = ageGroup;
	}
	public String getS10() {
		return s10;
	}
	public void setS10(String s10) {
		this.s10 = s10;
	}
	public String getS20() {
		return s20;
	}
	public void setS20(String s20) {
		this.s20 = s20;
	}
	public String getS30() {
		return s30;
	}
	public void setS30(String s30) {
		this.s30 = s30;
	}
	public String getS40() {
		return s40;
	}
	public void setS40(String s40) {
		this.s40 = s40;
	}
	public String getS50() {
		return s50;
	}
	public void setS50(String s50) {
		this.s50 = s50;
	}
	public String getOver60s() {
		return over60s;
	}
	public void setOver60s(String over60s) {
		this.over60s = over60s;
	}
	public String getGenderTypeCd() {
		return GenderTypeCd;
	}
	public void setGenderTypeCd(String genderTypeCd) {
		GenderTypeCd = genderTypeCd;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getGroupCode() {
		return groupCode;
	}
	public void setGroupCode(String groupCode) {
		this.groupCode = groupCode;
	}
	public String getCodeNAme() {
		return codeNAme;
	}
	public void setCodeNAme(String codeNAme) {
		this.codeNAme = codeNAme;
	}
	
	
}