package com.icignal.kepler.report.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class KprReportLnlCampaignResDto extends GridPagingItemResDto {
	private String yyyy						;
	private String ridCam                    ;
	private String camExeSeq                 ;
	private String week                      ;
	private String camOrgCd                  ;
	private String camChnlCd                 ;
	private String camNo                     ;
	private String camNm                       ;
	private String camSdate                    ;
	private String camEdate                    ;
	private String camOrgNm                    ;
	private String rid                    ;
	
	private String trgtCnt                     ;
	private String ctrlCnt                     ;
	private String sendCnt                     ;
	private String sendScssCnt                 ;
	private String tsalMbrCnt                  ;
	private String tsalVisitRate               ;
	private String tsalMbrAmt                  ;
	private String tsalOrdCnt                  ;
	private String tsalPerAmt                  ;
	private String csalMbrCnt                  ;
	private String csalVisitRate               ;
	private String csalMbrAmt                  ;
	private String csalOrdCnt                  ;
	private String csalPerAmt                  ;
	private String cpnMbrCnt                   ;
	private String cpnUseRate                  ;
	private String cpnMbrAmt                   ;
	private String cpnOrdCnt                   ;
	private String cpnPerAmt                   ;
	private String trgtCntSum;
	private String ctrlCntSum;
	private String sendCntSum;
	private String sendScssCntSum;
	private String tsalMbrCntSum;
	private String tsalOrdCntSum;
	private String csalOrdCntSum;
	private String cpnOrdCntSum;
	
	private String tsalMbrAmtSum;
	private String csalMbrAmtSum;
	public String getTsalMbrAmtSum() {
		return tsalMbrAmtSum;
	}
	public void setTsalMbrAmtSum(String tsalMbrAmtSum) {
		this.tsalMbrAmtSum = tsalMbrAmtSum;
	}
	public String getCsalMbrAmtSum() {
		return csalMbrAmtSum;
	}
	public void setCsalMbrAmtSum(String csalMbrAmtSum) {
		this.csalMbrAmtSum = csalMbrAmtSum;
	}
	public String getCpnMbrAmtSum() {
		return cpnMbrAmtSum;
	}
	public void setCpnMbrAmtSum(String cpnMbrAmtSum) {
		this.cpnMbrAmtSum = cpnMbrAmtSum;
	}
	private String cpnMbrAmtSum;

	public String getTrgtCntSum() {
		return trgtCntSum;
	}
	public void setTrgtCntSum(String trgtCntSum) {
		this.trgtCntSum = trgtCntSum;
	}
	public String getCtrlCntSum() {
		return ctrlCntSum;
	}
	public void setCtrlCntSum(String ctrlCntSum) {
		this.ctrlCntSum = ctrlCntSum;
	}
	public String getSendCntSum() {
		return sendCntSum;
	}
	public void setSendCntSum(String sendCntSum) {
		this.sendCntSum = sendCntSum;
	}
	public String getSendScssCntSum() {
		return sendScssCntSum;
	}
	public void setSendScssCntSum(String sendScssCntSum) {
		this.sendScssCntSum = sendScssCntSum;
	}
	public String getTsalMbrCntSum() {
		return tsalMbrCntSum;
	}
	public void setTsalMbrCntSum(String tsalMbrCntSum) {
		this.tsalMbrCntSum = tsalMbrCntSum;
	}
	public String getRidCam() {
		return ridCam;
	}
	public void setRidCam(String ridCam) {
		this.ridCam = ridCam;
	}
	public String getCamExeSeq() {
		return camExeSeq;
	}
	public void setCamExeSeq(String camExeSeq) {
		this.camExeSeq = camExeSeq;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String getCamOrgCd() {
		return camOrgCd;
	}
	public void setCamOrgCd(String camOrgCd) {
		this.camOrgCd = camOrgCd;
	}
	public String getCamChnlCd() {
		return camChnlCd;
	}
	public void setCamChnlCd(String camChnlCd) {
		this.camChnlCd = camChnlCd;
	}
	public String getCamNo() {
		return camNo;
	}
	public void setCamNo(String camNo) {
		this.camNo = camNo;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamSdate() {
		return camSdate;
	}
	public void setCamSdate(String camSdate) {
		this.camSdate = camSdate;
	}
	public String getCamEdate() {
		return camEdate;
	}
	public void setCamEdate(String camEdate) {
		this.camEdate = camEdate;
	}

	public String getTrgtCnt() {
		return trgtCnt;
	}
	public void setTrgtCnt(String trgtCnt) {
		this.trgtCnt = trgtCnt;
	}
	public String getCtrlCnt() {
		return ctrlCnt;
	}
	public void setCtrlCnt(String ctrlCnt) {
		this.ctrlCnt = ctrlCnt;
	}
	public String getSendCnt() {
		return sendCnt;
	}
	public void setSendCnt(String sendCnt) {
		this.sendCnt = sendCnt;
	}
	public String getSendScssCnt() {
		return sendScssCnt;
	}
	public void setSendScssCnt(String sendScssCnt) {
		this.sendScssCnt = sendScssCnt;
	}
	public String getTsalMbrCnt() {
		return tsalMbrCnt;
	}
	public void setTsalMbrCnt(String tsalMbrCnt) {
		this.tsalMbrCnt = tsalMbrCnt;
	}
	public String getTsalVisitRate() {
		return tsalVisitRate;
	}
	public void setTsalVisitRate(String tsalVisitRate) {
		this.tsalVisitRate = tsalVisitRate;
	}
	public String getTsalMbrAmt() {
		return tsalMbrAmt;
	}
	public void setTsalMbrAmt(String tsalMbrAmt) {
		this.tsalMbrAmt = tsalMbrAmt;
	}
	public String getTsalOrdCnt() {
		return tsalOrdCnt;
	}
	public void setTsalOrdCnt(String tsalOrdCnt) {
		this.tsalOrdCnt = tsalOrdCnt;
	}
	public String getTsalPerAmt() {
		return tsalPerAmt;
	}
	public void setTsalPerAmt(String tsalPerAmt) {
		this.tsalPerAmt = tsalPerAmt;
	}
	public String getCsalMbrCnt() {
		return csalMbrCnt;
	}
	public void setCsalMbrCnt(String csalMbrCnt) {
		this.csalMbrCnt = csalMbrCnt;
	}
	public String getCsalVisitRate() {
		return csalVisitRate;
	}
	public void setCsalVisitRate(String csalVisitRate) {
		this.csalVisitRate = csalVisitRate;
	}
	public String getCsalMbrAmt() {
		return csalMbrAmt;
	}
	public void setCsalMbrAmt(String csalMbrAmt) {
		this.csalMbrAmt = csalMbrAmt;
	}
	public String getCsalOrdCnt() {
		return csalOrdCnt;
	}
	public void setCsalOrdCnt(String csalOrdCnt) {
		this.csalOrdCnt = csalOrdCnt;
	}
	public String getCsalPerAmt() {
		return csalPerAmt;
	}
	public void setCsalPerAmt(String csalPerAmt) {
		this.csalPerAmt = csalPerAmt;
	}
	public String getCpnMbrCnt() {
		return cpnMbrCnt;
	}
	public void setCpnMbrCnt(String cpnMbrCnt) {
		this.cpnMbrCnt = cpnMbrCnt;
	}
	public String getCpnUseRate() {
		return cpnUseRate;
	}
	public void setCpnUseRate(String cpnUseRate) {
		this.cpnUseRate = cpnUseRate;
	}
	public String getCpnMbrAmt() {
		return cpnMbrAmt;
	}
	public void setCpnMbrAmt(String cpnMbrAmt) {
		this.cpnMbrAmt = cpnMbrAmt;
	}
	public String getCpnOrdCnt() {
		return cpnOrdCnt;
	}
	public void setCpnOrdCnt(String cpnOrdCnt) {
		this.cpnOrdCnt = cpnOrdCnt;
	}
	public String getCpnPerAmt() {
		return cpnPerAmt;
	}
	public void setCpnPerAmt(String cpnPerAmt) {
		this.cpnPerAmt = cpnPerAmt;
	}
	public String getYyyy() {
		return yyyy;
	}
	public void setYyyy(String yyyy) {
		this.yyyy = yyyy;
	}
	public String getCamOrgNm() {
		return camOrgNm;
	}
	public void setCamOrgNm(String camOrgNm) {
		this.camOrgNm = camOrgNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTsalOrdCntSum() {
		return tsalOrdCntSum;
	}
	public void setTsalOrdCntSum(String tsalOrdCntSum) {
		this.tsalOrdCntSum = tsalOrdCntSum;
	}
	public String getCsalOrdCntSum() {
		return csalOrdCntSum;
	}
	public void setCsalOrdCntSum(String csalOrdCntSum) {
		this.csalOrdCntSum = csalOrdCntSum;
	}
	public String getCpnOrdCntSum() {
		return cpnOrdCntSum;
	}
	public void setCpnOrdCntSum(String cpnOrdCntSum) {
		this.cpnOrdCntSum = cpnOrdCntSum;
	}
	              
	

}
