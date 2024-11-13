package com.icignal.loyalty.benefit.point.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.Loyalty.common.dto.request.LoyPointBnftCalcRequestDTO
* @date : 2018. 11. 28.
* @author : hy.jun
* @description : 포인트 산출
*/
public class LoyPointBnftCalcRequestDTO extends MKTBaseReqDto {
	private int isConTran;
	private String outResult;
	private int procSeq;
	private String lang;
	private String rid;
	private String ridIntactType;
	private String execType;
	private String parPgmNo;
	private String parCalcFlag;
	private String parLang;
	private String parRefNo;
	private String parCamNo;
	private String parOfferNo;
	
	private String intactType1Cd;
	private String intactType2Cd;
	
	public int getIsConTran() {
		return isConTran;
	}
	public void setIsConTran(int isConTran) {
		this.isConTran = isConTran;
	}
	public String getOutResult() {
		return outResult;
	}
	public void setOutResult(String outResult) {
		this.outResult = outResult;
	}
	public int getProcSeq() {
		return procSeq;
	}
	public void setProcSeq(int procSeq) {
		this.procSeq = procSeq;
	}
	public String getLang() {
		return lang;
	}
	public void setLang(String lang) {
		this.lang = lang;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidIntactType() {
		return ridIntactType;
	}
	public void setRidIntactType(String ridIntactType) {
		this.ridIntactType = ridIntactType;
	}
	public String getExecType() {
		return execType;
	}
	public void setExecType(String execType) {
		this.execType = execType;
	}
	public String getParPgmNo() {
		return parPgmNo;
	}
	public void setParPgmNo(String parPgmNo) {
		this.parPgmNo = parPgmNo;
	}
	public String getParCalcFlag() {
		return parCalcFlag;
	}
	public void setParCalcFlag(String parCalcFlag) {
		this.parCalcFlag = parCalcFlag;
	}
	public String getParLang() {
		return parLang;
	}
	public void setParLang(String parLang) {
		this.parLang = parLang;
	}
	public String getParRefNo() {
		return parRefNo;
	}
	public void setParRefNo(String parRefNo) {
		this.parRefNo = parRefNo;
	}
	public String getParCamNo() {
		return parCamNo;
	}
	public void setParCamNo(String parCamNo) {
		this.parCamNo = parCamNo;
	}
	public String getParOfferNo() {
		return parOfferNo;
	}
	public void setParOfferNo(String parOfferNo) {
		this.parOfferNo = parOfferNo;
	}
	public String getIntactType1Cd() {
		return intactType1Cd;
	}
	public void setIntactType1Cd(String intactType1Cd) {
		this.intactType1Cd = intactType1Cd;
	}
	public String getIntactType2Cd() {
		return intactType2Cd;
	}
	public void setIntactType2Cd(String intactType2Cd) {
		this.intactType2Cd = intactType2Cd;
	}
}
