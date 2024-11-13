package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.loyalty.common.dto.request.LoyExcelExportReqDto;


public class LoyTransListReqDto  extends CommonDataAuthReqDto {


	private String rid;
	//private String cipherKey;
	private String defaultMbrRid;
	private String defaultChnlRid;
	private String defaultArchive ;
	private String batchCardNum;
	private String batchTransIsYn;
	private String mbrRidFlag;
	//조회조건시 회원명, 회원번호가 있는지 확인
	private String isMbrYn;
	//조회조건시 채널번호, 채널명이 있는지 확인
	private String isChnlYn;
	private String isCustYn;
	//조회조건시 상품번호, 상품이 있는지 확인
	private String isProdYn;
	private String searchCondIsYN;
	private LoyExcelExportReqDto excelObj;
	private String mbrNo;
    private String apprNo; 
    private String apprDate;
    private String txnUniqNo;
    private String pntTxnType1code;
    private String pntTxnType2code;
    private String chnlNo;
    private String chnlNameGrid;
    
	public String getChnlNameGrid() {
		return chnlNameGrid;
	}

	public void setChnlNameGrid(String chnlNameGrid) {
		this.chnlNameGrid = chnlNameGrid;
	}

	public String getIsCustYn() {
		return isCustYn;
	}

	public void setIsCustYn(String isCustYn) {
		this.isCustYn = isCustYn;
	}

	public LoyExcelExportReqDto getExcelObj() {
		return excelObj;
	}

	public void setExcelObj(LoyExcelExportReqDto excelObj) {
		this.excelObj = excelObj;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}

	public String getPntTxnType1code() {
		return pntTxnType1code;
	}

	public void setPntTxnType1code(String pntTxnType1code) {
		this.pntTxnType1code = pntTxnType1code;
	}

	public String getPntTxnType2code() {
		return pntTxnType2code;
	}

	public void setPntTxnType2code(String pntTxnType2code) {
		this.pntTxnType2code = pntTxnType2code;
	}

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getApprNo() {
		return apprNo;
	}

	public void setApprNo(String apprNo) {
		this.apprNo = apprNo;
	}

	public String getApprDate() {
		return apprDate;
	}

	public void setApprDate(String apprDate) {
		this.apprDate = apprDate;
	}

	public String getTxnUniqNo() {
		return txnUniqNo;
	}

	public void setTxnUniqNo(String txnUniqNo) {
		this.txnUniqNo = txnUniqNo;
	}


	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

//	public String getCipherKey() {
//		return cipherKey;
//	}
//
//	public void setCipherKey(String cipherKey) {
//		this.cipherKey = cipherKey;
//	}

	public String getDefaultMbrRid() {
		return defaultMbrRid;
	}

	public void setDefaultMbrRid(String defaultMbrRid) {
		this.defaultMbrRid = defaultMbrRid;
	}

	public String getDefaultChnlRid() {
		return defaultChnlRid;
	}

	public void setDefaultChnlRid(String defaultChnlRid) {
		this.defaultChnlRid = defaultChnlRid;
	}

	public String getDefaultArchive() {
		return defaultArchive;
	}

	public void setDefaultArchive(String defaultArchive) {
		this.defaultArchive = defaultArchive;
	}

	public String getBatchCardNum() {
		return batchCardNum;
	}

	public void setBatchCardNum(String batchCardNum) {
		this.batchCardNum = batchCardNum;
	}

	public String getBatchTransIsYn() {
		return batchTransIsYn;
	}

	public void setBatchTransIsYn(String batchTransIsYn) {
		this.batchTransIsYn = batchTransIsYn;
	}

	public String getIsMbrYn() {
		return isMbrYn;
	}

	public void setIsMbrYn(String isMbrYn) {
		this.isMbrYn = isMbrYn;
	}

	public String getSearchCondIsYN() {
		return searchCondIsYN;
	}

	public void setSearchCondIsYN(String searchCondIsYN) {
		this.searchCondIsYN = searchCondIsYN;
	}

	public String getMbrRidFlag() {
		return mbrRidFlag;
	}

	public void setMbrRidFlag(String mbrRidFlag) {
		this.mbrRidFlag = mbrRidFlag;
	}

	public String getIsChnlYn() {
		return isChnlYn;
	}

	public void setIsChnlYn(String isChnlYn) {
		this.isChnlYn = isChnlYn;
	}

	public String getIsProdYn() {
		return isProdYn;
	}

	public void setIsProdYn(String isProdYn) {
		this.isProdYn = isProdYn;
	}



}
