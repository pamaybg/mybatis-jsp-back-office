package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRReportActiveMemberResponseDTO
 * 2. 파일명	: KPRReportActiveMemberResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.report.dto.response
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class KprReportActiveMemberResDto extends GridPagingItemResDto {
	private String loginCnt; /* 총 로그인 수 */
	private String loginUserCnt; /* 총 로그인한 인원수 */
	private String gloLoginCnt; /* 글로라이브 로그인 수 */
	private String gloLoginUserCnt; /* 글로라이브 로그인한 인원수 */
	private String monthlyCnt; /* MONTHLY REWARD 총 응모횟수 */
	private String monthlyUserCnt; /* MONTHLY REWARD 응모자 */
	private String evtSnsCnt; /* SNS 총 응모횟수 */
	private String evtSnsUserCnt; /* SNS 응모자수 */
	private String ecomCpnCnt; /* ECOM 쿠폰 발행 수 */
	private String rcmmdJoinCnt; /* 추천가입수 */
	private String joinRcmmdCnt; /* 가입 추천자 수 */
	private String rcmmdPurCnt; /* 추천 구매수 */
	private String rcmmdPurReg; /* 추천 구매 등록자 수 */
	private String rcmmdMbr; /* 추천 구매자 수 */
	private String regDeviceCnt; /* 등록된 기기수 */
	private String regDeviceMbrCnt; /* 기기등록한 회원수 */
	
	public String getLoginCnt() {
		return loginCnt;
	}
	public void setLoginCnt(String loginCnt) {
		this.loginCnt = loginCnt;
	}
	public String getLoginUserCnt() {
		return loginUserCnt;
	}
	public void setLoginUserCnt(String loginUserCnt) {
		this.loginUserCnt = loginUserCnt;
	}
	public String getGloLoginCnt() {
		return gloLoginCnt;
	}
	public void setGloLoginCnt(String gloLoginCnt) {
		this.gloLoginCnt = gloLoginCnt;
	}
	public String getGloLoginUserCnt() {
		return gloLoginUserCnt;
	}
	public void setGloLoginUserCnt(String gloLoginUserCnt) {
		this.gloLoginUserCnt = gloLoginUserCnt;
	}
	public String getMonthlyCnt() {
		return monthlyCnt;
	}
	public void setMonthlyCnt(String monthlyCnt) {
		this.monthlyCnt = monthlyCnt;
	}
	public String getMonthlyUserCnt() {
		return monthlyUserCnt;
	}
	public void setMonthlyUserCnt(String monthlyUserCnt) {
		this.monthlyUserCnt = monthlyUserCnt;
	}
	public String getEvtSnsCnt() {
		return evtSnsCnt;
	}
	public void setEvtSnsCnt(String evtSnsCnt) {
		this.evtSnsCnt = evtSnsCnt;
	}
	public String getEvtSnsUserCnt() {
		return evtSnsUserCnt;
	}
	public void setEvtSnsUserCnt(String evtSnsUserCnt) {
		this.evtSnsUserCnt = evtSnsUserCnt;
	}
	public String getEcomCpnCnt() {
		return ecomCpnCnt;
	}
	public void setEcomCpnCnt(String ecomCpnCnt) {
		this.ecomCpnCnt = ecomCpnCnt;
	}
	public String getJoinRcmmdCnt() {
		return joinRcmmdCnt;
	}
	public void setJoinRcmmdCnt(String joinRcmmdCnt) {
		this.joinRcmmdCnt = joinRcmmdCnt;
	}
	public String getRegDeviceCnt() {
		return regDeviceCnt;
	}
	public void setRegDeviceCnt(String regDeviceCnt) {
		this.regDeviceCnt = regDeviceCnt;
	}
	public String getRegDeviceMbrCnt() {
		return regDeviceMbrCnt;
	}
	public void setRegDeviceMbrCnt(String regDeviceMbrCnt) {
		this.regDeviceMbrCnt = regDeviceMbrCnt;
	}
	public String getRcmmdJoinCnt() {
		return rcmmdJoinCnt;
	}
	public void setRcmmdJoinCnt(String rcmmdJoinCnt) {
		this.rcmmdJoinCnt = rcmmdJoinCnt;
	}
	public String getRcmmdPurCnt() {
		return rcmmdPurCnt;
	}
	public void setRcmmdPurCnt(String rcmmdPurCnt) {
		this.rcmmdPurCnt = rcmmdPurCnt;
	}
	public String getRcmmdPurReg() {
		return rcmmdPurReg;
	}
	public void setRcmmdPurReg(String rcmmdPurReg) {
		this.rcmmdPurReg = rcmmdPurReg;
	}
	public String getRcmmdMbr() {
		return rcmmdMbr;
	}
	public void setRcmmdMbr(String rcmmdMbr) {
		this.rcmmdMbr = rcmmdMbr;
	}
	
}
