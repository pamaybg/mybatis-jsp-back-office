package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
* @name : infavor.loyalty.batchRegist.dto.response.LOYBatchRegistListResponseDTO
* @date : 2017. 11. 13.
* @author : kimjunki
* @description :
*/
@CommCode
public class SystemBatchRgstListResDto {

	private String fileUpldDt;
	private String offerType;
	private String fileNm;
	private String fileUpldSucesCnt;
	private String fileUpldFailCnt;
	private String custNm;
	@MarkName(groupCode = "TXN_STATUS_UPLOAD", codeField = "pointTrtStautsCd")
	private String pointTrtStauts;
	private String pointTrtStautsCd;
	private String chnlNo;
	private String chnlNm;	
	@MarkName(groupCode = "TXN_REASON_ALL_TYPE", codeField = "acuRdnCd")
	private String acuRdn;	
	private String acuRdnCd;
	private String ridActcSbst;
	private String actcTrtDt;
	private String ridApv;
	private String apvTrtDt;
	private String pointSucesCnt;
	private String pointFailCnt;
	private String ridPointEmp;
	private String rid;
	private String filePath;
	private String ridMbr;
	private String acrlAmt;
	private String camNo;
	private String itemRid;
	private String bigTypeCd;
	private String midtypeCd;
	private String offerNo;
	private String offerTypecd;
	private String camMstRid;
	private String promRid;
	private String promNo;
	private String ofrNm;
	private String ofrRid;
	private String ofrNo;
	private String pgmRid;
	private String pgmNo;
	private String procTypeCd;
	private String procDtlTypeCd;
	private int txnAmt;
	
	
	public String getProcTypeCd() {
		return procTypeCd;
	}
	public void setProcTypeCd(String procTypeCd) {
		this.procTypeCd = procTypeCd;
	}
	public String getProcDtlTypeCd() {
		return procDtlTypeCd;
	}
	public void setProcDtlTypeCd(String procDtlTypeCd) {
		this.procDtlTypeCd = procDtlTypeCd;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getPgmRid() {
		return pgmRid;
	}
	public void setPgmRid(String pgmRid) {
		this.pgmRid = pgmRid;
	}
	public String getOfrNo() {
		return ofrNo;
	}
	public void setOfrNo(String ofrNo) {
		this.ofrNo = ofrNo;
	}
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
	public String getPromNo() {
		return promNo;
	}
	public void setPromNo(String promNo) {
		this.promNo = promNo;
	}
	public String getPromRid() {
		return promRid;
	}
	public void setPromRid(String promRid) {
		this.promRid = promRid;
	}
	public String getPointTrtStautsCd() {
		return pointTrtStautsCd;
	}
	public void setPointTrtStautsCd(String pointTrtStautsCd) {
		this.pointTrtStautsCd = pointTrtStautsCd;
	}
	public String getAcuRdnCd() {
		return acuRdnCd;
	}
	public void setAcuRdnCd(String acuRdnCd) {
		this.acuRdnCd = acuRdnCd;
	}
	public String getBigTypeCd() {
		return bigTypeCd;
	}
	public void setBigTypeCd(String bigTypeCd) {
		this.bigTypeCd = bigTypeCd;
	}
	public String getMidtypeCd() {
		return midtypeCd;
	}
	public void setMidtypeCd(String midtypeCd) {
		this.midtypeCd = midtypeCd;
	}
	public String getOfferNo() {
		return offerNo;
	}
	public void setOfferNo(String offerNo) {
		this.offerNo = offerNo;
	}
	public String getOfferTypecd() {
		return offerTypecd;
	}
	public void setOfferTypecd(String offerTypecd) {
		this.offerTypecd = offerTypecd;
	}
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getCamNo() {
		return camNo;
	}
	public void setCamNo(String camNo) {
		this.camNo = camNo;
	}
	public String getFileUpldDt() {
		return fileUpldDt;
	}
	public void setFileUpldDt(String fileUpldDt) {
		this.fileUpldDt = fileUpldDt;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	public String getFileNm() {
		return fileNm;
	}
	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
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
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
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
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getAcuRdn() {
		return acuRdn;
	}
	public void setAcuRdn(String acuRdn) {
		this.acuRdn = acuRdn;
	}
	public String getRidActcSbst() {
		return ridActcSbst;
	}
	public void setRidActcSbst(String ridActcSbst) {
		this.ridActcSbst = ridActcSbst;
	}
	public String getActcTrtDt() {
		return actcTrtDt;
	}
	public void setActcTrtDt(String actcTrtDt) {
		this.actcTrtDt = actcTrtDt;
	}
	public String getRidApv() {
		return ridApv;
	}
	public void setRidApv(String ridApv) {
		this.ridApv = ridApv;
	}
	public String getApvTrtDt() {
		return apvTrtDt;
	}
	public void setApvTrtDt(String apvTrtDt) {
		this.apvTrtDt = apvTrtDt;
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
	public String getRidPointEmp() {
		return ridPointEmp;
	}
	public void setRidPointEmp(String ridPointEmp) {
		this.ridPointEmp = ridPointEmp;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getItemRid() {
		return itemRid;
	}
	public void setItemRid(String itemRid) {
		this.itemRid = itemRid;
	}
	public String getCamMstRid() {
		return camMstRid;
	}
	public void setCamMstRid(String camMstRid) {
		this.camMstRid = camMstRid;
	}
	public int getTxnAmt() {
		return txnAmt;
	}
	public void setTxnAmt(int txnAmt) {
		this.txnAmt = txnAmt;
	}
}
