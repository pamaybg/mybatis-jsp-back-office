package com.icignal.systemmanagement.batchrgst.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
* @name : infavor.Loyalty.batchRegist.dto.request.LoyBatchRegistListRequestDTO
* @date : 2017. 11. 13.
* @author : kimjunki
* @description :
*/
public class SystemBatchRgstDetailInsertReqDto extends CommonDataAuthReqDto {

	private String fileNm;
	private String filePath;
	private String acuRdn;
	private String pointTrtStauts;
	private String chnlNo;
	private String chnlNm;
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
	private String empId;
	private String rmark;
	private String rid;
	private String offerType;
	private String typeCd;



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
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getRmark() {
		return rmark;
	}
	public void setRmark(String rmark) {
		this.rmark = rmark;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getOfferType() {
		return offerType;
	}
	public void setOfferType(String offerType) {
		this.offerType = offerType;
	}
	/**
	* @return the typeCd
	*/
	public String getTypeCd() {
		return typeCd;
	}
	/**
	* @param typeCd the typeCd to set
	*/
	public void setTypeCd(String typeCd) {
		this.typeCd = typeCd;
	}



}