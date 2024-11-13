package com.icignal.kepler.report.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;
@PersonalData
public class KprReportLnlReqDto extends CommonDataAuthReqDto {
	private String offSetFlag;
	private String yyyymm;
	private String yyyy;
	private String chnlType;    //구분
	private String custTypeI;   //개인
	private String custTypeC;   //법인
	private String custTypeE;   //임직원
	private String custTypeO; //기타
	private String custTypeD; //기타
	private String rid;
	private String camSdate;
	private String camSdate2;
	private String itemCd;
	private String prodId;
	private String mbrTypeCd;
	private String sellDate1;
	private String sellDate2;
	private String tierW;
	private String tierV;
	private String tierL;
	private String ridProm;
	private String chnlTypeRid;
	private String chnlSubTypeCd;	
	private String mbrTypeCd2;
	private String sellDate2Plus;

	private String startDt;
	private String endDt;
	private String ridOfr;
	private String chnlTypeCd;
	private String monthValue;
	private String ofrCtg; 
	@Encrypted
	private String mbrNm;
	
	private String registDate1;
	private String registDate2;
	private String depositDate1;
	private String depositDate2;
	private String step;
	private String custTypeCd;
	private String sbscTypeCd;
	private String mbrStatCd;
	private String orderSeq;
	private String chnlStat;

	public String getChnlStat() {
		return chnlStat;
	}

	public void setChnlStat(String chnlStat) {
		this.chnlStat = chnlStat;
	}

	public String getOrderSeq() {
		return orderSeq;
	}

	public void setOrderSeq(String orderSeq) {
		this.orderSeq = orderSeq;
	}

	public String getRegistDate1() {
		return registDate1;
	}

	public void setRegistDate1(String registDate1) {
		this.registDate1 = registDate1;
	}

	public String getRegistDate2() {
		return registDate2;
	}

	public void setRegistDate2(String registDate2) {
		this.registDate2 = registDate2;
	}

	public String getDepositDate1() {
		return depositDate1;
	}

	public void setDepositDate1(String depositDate1) {
		this.depositDate1 = depositDate1;
	}

	public String getDepositDate2() {
		return depositDate2;
	}

	public void setDepositDate2(String depositDate2) {
		this.depositDate2 = depositDate2;
	}

	public String getStep() {
		return step;
	}

	public void setStep(String step) {
		this.step = step;
	}

	public String getCustTypeCd() {
		return custTypeCd;
	}

	public void setCustTypeCd(String custTypeCd) {
		this.custTypeCd = custTypeCd;
	}

	public String getSbscTypeCd() {
		return sbscTypeCd;
	}

	public void setSbscTypeCd(String sbscTypeCd) {
		this.sbscTypeCd = sbscTypeCd;
	}

	public String getMbrStatCd() {
		return mbrStatCd;
	}

	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}

	public String getStartDt() {
		return startDt;
	}

	public void setStartDt(String startDt) {
		this.startDt = startDt;
	}

	public String getEndDt() {
		return endDt;
	}

	public void setEndDt(String endDt) {
		this.endDt = endDt;
	}

	public String getRidOfr() {
		return ridOfr;
	}

	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}

	public String getTierW() {
		return tierW;
	}

	public void setTierW(String tierW) {
		this.tierW = tierW;
	}

	public String getTierV() {
		return tierV;
	}

	public void setTierV(String tierV) {
		this.tierV = tierV;
	}

	public String getTierL() {
		return tierL;
	}

	public void setTierL(String tierL) {
		this.tierL = tierL;
	}

	public String getSellDate1() {
		return sellDate1;
	}

	public void setSellDate1(String sellDate1) {
		this.sellDate1 = sellDate1;
	}

	public String getSellDate2() {
		return sellDate2;
	}

	public void setSellDate2(String sellDate2) {
		this.sellDate2 = sellDate2;
	}

	public String getItemCd() {
		return itemCd;
	}

	public void setItemCd(String itemCd) {
		this.itemCd = itemCd;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getCamSdate() {
		return camSdate;
	}

	public void setCamSdate(String camSdate) {
		this.camSdate = camSdate;
	}

	public String getCamSdate2() {
		return camSdate2;
	}

	public void setCamSdate2(String camSdate2) {
		this.camSdate2 = camSdate2;
	}

	public String getCustTypeI() {
		return custTypeI;
	}

	public void setCustTypeI(String custTypeI) {
		this.custTypeI = custTypeI;
	}

	public String getCustTypeC() {
		return custTypeC;
	}

	public void setCustTypeC(String custTypeC) {
		this.custTypeC = custTypeC;
	}

	public String getCustTypeE() {
		return custTypeE;
	}

	public void setCustTypeE(String custTypeE) {
		this.custTypeE = custTypeE;
	}

	public String getYyyymm() {
		return yyyymm;
	}

	public void setYyyymm(String yyyymm) {
		this.yyyymm = yyyymm;
	}

	public String getChnlType() {
		return chnlType;
	}

	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getMbrTypeCd() {
		return mbrTypeCd;
	}

	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}

	public String getRidProm() {
		return ridProm;
	}

	public void setRidProm(String ridProm) {
		this.ridProm = ridProm;
	}

	public String getCustTypeO() {
		return custTypeO;
	}

	public void setCustTypeO(String custTypeO) {
		this.custTypeO = custTypeO;
	}

	public String getCustTypeD() {
		return custTypeD;
	}

	public void setCustTypeD(String custTypeD) {
		this.custTypeD = custTypeD;
	}

	public String getChnlTypeRid() {
		return chnlTypeRid;
	}

	public void setChnlTypeRid(String chnlTypeRid) {
		this.chnlTypeRid = chnlTypeRid;
	}

	public String getChnlSubTypeCd() {
		return chnlSubTypeCd;
	}

	public void setChnlSubTypeCd(String chnlSubTypeCd) {
		this.chnlSubTypeCd = chnlSubTypeCd;
	}

	public String getMbrTypeCd2() {
		return mbrTypeCd2;
	}

	public void setMbrTypeCd2(String mbrTypeCd2) {
		this.mbrTypeCd2 = mbrTypeCd2;
	}

	public String getSellDate2Plus() {
		return sellDate2Plus;
	}

	public void setSellDate2Plus(String sellDate2Plus) {
		this.sellDate2Plus = sellDate2Plus;
	}

	public String getChnlTypeCd() {
		return chnlTypeCd;
	}

	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}

	public String getMonthValue() {
		return monthValue;
	}

	public void setMonthValue(String monthValue) {
		this.monthValue = monthValue;
	}

	public String getYyyy() {
		return yyyy;
	}

	public void setYyyy(String yyyy) {
		this.yyyy = yyyy;
	}

	public String getMbrNm() {
		return mbrNm;
	}

	public void setMbrNm(String mbrNm) {
		this.mbrNm = mbrNm;
	}

	public String getOffSetFlag() {
		return offSetFlag;
	}

	public void setOffSetFlag(String offSetFlag) {
		this.offSetFlag = offSetFlag;
	}

	public String getOfrCtg() {
		return ofrCtg;
	}

	public void setOfrCtg(String ofrCtg) {
		this.ofrCtg = ofrCtg;
	}






}
