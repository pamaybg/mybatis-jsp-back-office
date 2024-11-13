package com.icignal.systemmanagement.batchrgst.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
* @name : infavor.Loyalty.batchRegist.dto.request.LoyBatchRegistListRequestDTO
* @date : 2017. 11. 13.
* @author : kimjunki
* @description :
*/
public class SystemBatchRgstDetailReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String fileNm;
	private String filePath;
	private String acuRdn;
	private String pointTrtStauts;
	private String chnlNo;
	private String chnlNm;
	private String bizrNo;
	private String actcNm;
	private String actcTrtDt;
	private String apvNm;	
	private String apvTrtDt;	
	private String actcSbst;
	private String apvSbst;
	private String fileUpldDt;
	private String upldEmpNm;
	private String fileUpldSucesCnt;
	private String fileUpldFailCnt;
	private String pointTrtDt;
	private String pointEmpNm;
	private String pointSucesCnt;
	private String pointFailCnt;
	private String ridActcSbst;
	private String ridApv;
	private String ridChnl;
	private String rmark;
	private String ridUpldEmp;
	
	private String empId;
	private String vanEmpId;
	
	private String taxtnYn;
	private String taxtnOccAmt;
	private String ridTaxfr;
	private String taxfrProdCd;
	private String ridTaxtn;
	private String taxtnProdCd;
	private String taxtnRate;
	private String prodRid;

	private String webLogin;
	private String reqPoint;
	private String typeCd;
	private String mbrNo;
	private String taxPoints;
	private String ridProd;
	private String prodId;
	
	private String returnText;
	private String statusCd;
	
	private String sReason;
	
	
	
	private String ridMbr;
	private String memDiv;
	private String mbrStatCd;
	private String memDivMarkName;
	
	private String returnCd;
	private String terminalCd;
	private String txnDt;
	private String txnNum;
	private String approvalDt;
	private String approvalNum;
	private String approvalPoints;
	
	private String offerType;
	
	//밴즉시승인 여부 판단
	private String vaReApvCheck;
	
	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getAcuRdn() {
		return acuRdn;
	}

	public void setAcuRdn(String acuRdn) {
		this.acuRdn = acuRdn;
	}

	public String getPointTrtStauts() {
		return pointTrtStauts;
	}

	public void setPointTrtStauts(String pointTrtStauts) {
		this.pointTrtStauts = pointTrtStauts;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	
	public String getBizrNo() {
		return bizrNo;
	}

	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	public String getActcNm() {
		return actcNm;
	}

	public void setActcNm(String actcNm) {
		this.actcNm = actcNm;
	}

	public String getActcTrtDt() {
		return actcTrtDt;
	}

	public void setActcTrtDt(String actcTrtDt) {
		this.actcTrtDt = actcTrtDt;
	}

	public String getApvNm() {
		return apvNm;
	}

	public void setApvNm(String apvNm) {
		this.apvNm = apvNm;
	}

	public String getApvTrtDt() {
		return apvTrtDt;
	}

	public void setApvTrtDt(String apvTrtDt) {
		this.apvTrtDt = apvTrtDt;
	}

	public String getActcSbst() {
		return actcSbst;
	}

	public void setActcSbst(String actcSbst) {
		this.actcSbst = actcSbst;
	}

	public String getApvSbst() {
		return apvSbst;
	}

	public void setApvSbst(String apvSbst) {
		this.apvSbst = apvSbst;
	}

	public String getFileUpldDt() {
		return fileUpldDt;
	}

	public void setFileUpldDt(String fileUpldDt) {
		this.fileUpldDt = fileUpldDt;
	}

	public String getUpldEmpNm() {
		return upldEmpNm;
	}

	public void setUpldEmpNm(String upldEmpNm) {
		this.upldEmpNm = upldEmpNm;
	}

	public String getFileUpldSucesCnt() {
		return fileUpldSucesCnt;
	}

	public void setFileUpldSucesCnt(String fileUpldSucesCnt) {
		this.fileUpldSucesCnt = fileUpldSucesCnt;
	}

	public String getFileUpldFailCnt() {
		return fileUpldFailCnt;
	}

	public void setFileUpldFailCnt(String fileUpldFailCnt) {
		this.fileUpldFailCnt = fileUpldFailCnt;
	}

	public String getPointTrtDt() {
		return pointTrtDt;
	}

	public void setPointTrtDt(String pointTrtDt) {
		this.pointTrtDt = pointTrtDt;
	}

	public String getPointEmpNm() {
		return pointEmpNm;
	}

	public void setPointEmpNm(String pointEmpNm) {
		this.pointEmpNm = pointEmpNm;
	}

	public String getPointSucesCnt() {
		return pointSucesCnt;
	}

	public void setPointSucesCnt(String pointSucesCnt) {
		this.pointSucesCnt = pointSucesCnt;
	}

	public String getPointFailCnt() {
		return pointFailCnt;
	}

	public void setPointFailCnt(String pointFailCnt) {
		this.pointFailCnt = pointFailCnt;
	}

	public String getRidActcSbst() {
		return ridActcSbst;
	}

	public void setRidActcSbst(String ridActcSbst) {
		this.ridActcSbst = ridActcSbst;
	}

	public String getRidApv() {
		return ridApv;
	}

	public void setRidApv(String ridApv) {
		this.ridApv = ridApv;
	}

	public String getRidChnl() {
		return ridChnl;
	}

	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}

	public String getRmark() {
		return rmark;
	}

	public void setRmark(String rmark) {
		this.rmark = rmark;
	}

	public String getRidUpldEmp() {
		return ridUpldEmp;
	}

	public void setRidUpldEmp(String ridUpldEmp) {
		this.ridUpldEmp = ridUpldEmp;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getVanEmpId() {
		return vanEmpId;
	}

	public void setVanEmpId(String vanEmpId) {
		this.vanEmpId = vanEmpId;
	}

	public String getTaxtnYn() {
		return taxtnYn;
	}

	public void setTaxtnYn(String taxtnYn) {
		this.taxtnYn = taxtnYn;
	}

	public String getTaxtnOccAmt() {
		return taxtnOccAmt;
	}

	public void setTaxtnOccAmt(String taxtnOccAmt) {
		this.taxtnOccAmt = taxtnOccAmt;
	}

	public String getRidTaxfr() {
		return ridTaxfr;
	}

	public void setRidTaxfr(String ridTaxfr) {
		this.ridTaxfr = ridTaxfr;
	}

	public String getTaxfrProdCd() {
		return taxfrProdCd;
	}

	public void setTaxfrProdCd(String taxfrProdCd) {
		this.taxfrProdCd = taxfrProdCd;
	}

	public String getRidTaxtn() {
		return ridTaxtn;
	}

	public void setRidTaxtn(String ridTaxtn) {
		this.ridTaxtn = ridTaxtn;
	}

	public String getTaxtnProdCd() {
		return taxtnProdCd;
	}

	public void setTaxtnProdCd(String taxtnProdCd) {
		this.taxtnProdCd = taxtnProdCd;
	}

	public String getTaxtnRate() {
		return taxtnRate;
	}

	public void setTaxtnRate(String taxtnRate) {
		this.taxtnRate = taxtnRate;
	}

	public String getProdRid() {
		return prodRid;
	}

	public void setProdRid(String prodRid) {
		this.prodRid = prodRid;
	}

	public String getReqPoint() {
		return reqPoint;
	}

	public void setReqPoint(String reqPoint) {
		this.reqPoint = reqPoint;
	}

	public String getTypeCd() {
		return typeCd;
	}

	public void setTypeCd(String typeCd) {
		this.typeCd = typeCd;
	}

	public String getTaxPoints() {
		return taxPoints;
	}

	public void setTaxPoints(String taxPoints) {
		this.taxPoints = taxPoints;
	}

	public String getRidProd() {
		return ridProd;
	}

	public void setRidProd(String ridProd) {
		this.ridProd = ridProd;
	}

	public String getProdId() {
		return prodId;
	}

	public void setProdId(String prodId) {
		this.prodId = prodId;
	}

	public String getWebLogin() {
		return webLogin;
	}

	public void setWebLogin(String webLogin) {
		this.webLogin = webLogin;
	}

	public String getReturnText() {
		return returnText;
	}

	public void setReturnText(String returnText) {
		this.returnText = returnText;
	}

	public String getStatusCd() {
		return statusCd;
	}

	public void setStatusCd(String statusCd) {
		this.statusCd = statusCd;
	}

	public String getsReason() {
		return sReason;
	}

	public void setsReason(String sReason) {
		this.sReason = sReason;
	}

	public String getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getRidMbr() {
		return ridMbr;
	}

	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}

	public String getMemDiv() {
		return memDiv;
	}

	public void setMemDiv(String memDiv) {
		this.memDiv = memDiv;
	}

	public String getMbrStatCd() {
		return mbrStatCd;
	}

	public void setMbrStatCd(String mbrStatCd) {
		this.mbrStatCd = mbrStatCd;
	}

	public String getMemDivMarkName() {
		return memDivMarkName;
	}

	public void setMemDivMarkName(String memDivMarkName) {
		this.memDivMarkName = memDivMarkName;
	}

	public String getReturnCd() {
		return returnCd;
	}

	public void setReturnCd(String returnCd) {
		this.returnCd = returnCd;
	}

	public String getTerminalCd() {
		return terminalCd;
	}

	public void setTerminalCd(String terminalCd) {
		this.terminalCd = terminalCd;
	}

	public String getTxnDt() {
		return txnDt;
	}

	public void setTxnDt(String txnDt) {
		this.txnDt = txnDt;
	}

	public String getTxnNum() {
		return txnNum;
	}

	public void setTxnNum(String txnNum) {
		this.txnNum = txnNum;
	}

	public String getApprovalDt() {
		return approvalDt;
	}

	public void setApprovalDt(String approvalDt) {
		this.approvalDt = approvalDt;
	}

	public String getApprovalNum() {
		return approvalNum;
	}

	public void setApprovalNum(String approvalNum) {
		this.approvalNum = approvalNum;
	}

	public String getApprovalPoints() {
		return approvalPoints;
	}

	public void setApprovalPoints(String approvalPoints) {
		this.approvalPoints = approvalPoints;
	}

	public String getOfferType() {
		return offerType;
	}

	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}

	public String getVaReApvCheck() {
		return vaReApvCheck;
	}

	public void setVaReApvCheck(String vaReApvCheck) {
		this.vaReApvCheck = vaReApvCheck;
	}

	
	
}
