package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class SystemBatchLogListResDto extends GridPagingItemResDto{
	private String createDt		;
	private String trNo			;
	private String logType 		;
	private String typeNo		;
	private String reqTrDt 		;
	private String reqTrTime 	;
	private String storeCd 		;
	private String storeNm		;
	private String posCd        ;
	private String reqMsg       ;
	private String blogType     ;
	private String btypeNo      ;
	private String resSendDt    ;
	private String resSendTime  ;
	private String resMsg       ;
	private String rst          ;
	@MarkName(groupCode = "APPR_SERVER_RPLY_CD",codeField = "rstCdNm")
	private String rstCd        ;
	private String rstCdNm;
	private String rstMsg       ;
	@MarkName(groupCode = "APPR_SERVER_TR_TYPE", codeField = "telNmCdNm")
	private String telNm 		;
	private String telNmCdNm;
	private double actTime		;
	private String resNm;
	private String apiNm;
	private int seqNo;



	public String getResNm() {
		return resNm;
	}
	public void setResNm(String resNm) {
		this.resNm = resNm;
	}
	public double getActTime() {
		return actTime;
	}
	public void setActTime(double actTime) {
		this.actTime = actTime;
	}
	public String getTelNm() {
		return telNm;
	}
	public void setTelNm(String telNm) {
		this.telNm = telNm;
	}
	public String getCreateDt() {
		return createDt;
	}
	public void setCreateDt(String createDt) {
		this.createDt = createDt;
	}
	public String getTrNo() {
		return trNo;
	}
	public void setTrNo(String trNo) {
		this.trNo = trNo;
	}
	public String getLogType() {
		return logType;
	}
	public void setLogType(String logType) {
		this.logType = logType;
	}
	public String getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(String typeNo) {
		this.typeNo = typeNo;
	}
	public String getReqTrDt() {
		return reqTrDt;
	}
	public void setReqTrDt(String reqTrDt) {
		this.reqTrDt = reqTrDt;
	}
	public String getReqTrTime() {
		return reqTrTime;
	}
	public void setReqTrTime(String reqTrTime) {
		this.reqTrTime = reqTrTime;
	}
	public String getStoreCd() {
		return storeCd;
	}
	public void setStoreCd(String storeCd) {
		this.storeCd = storeCd;
	}
	public String getStoreNm() {
		return storeNm;
	}
	public void setStoreNm(String storeNm) {
		this.storeNm = storeNm;
	}
	public String getPosCd() {
		return posCd;
	}
	public void setPosCd(String posCd) {
		this.posCd = posCd;
	}
	public String getReqMsg() {
		return reqMsg;
	}
	public void setReqMsg(String reqMsg) {
		this.reqMsg = reqMsg;
	}
	public String getBlogType() {
		return blogType;
	}
	public void setBlogType(String blogType) {
		this.blogType = blogType;
	}
	public String getBtypeNo() {
		return btypeNo;
	}
	public void setBtypeNo(String btypeNo) {
		this.btypeNo = btypeNo;
	}
	public String getResSendDt() {
		return resSendDt;
	}
	public void setResSendDt(String resSendDt) {
		this.resSendDt = resSendDt;
	}
	public String getResSendTime() {
		return resSendTime;
	}
	public void setResSendTime(String resSendTime) {
		this.resSendTime = resSendTime;
	}
	public String getResMsg() {
		return resMsg;
	}
	public void setResMsg(String resMsg) {
		this.resMsg = resMsg;
	}
	public String getRst() {
		return rst;
	}
	public void setRst(String rst) {
		this.rst = rst;
	}
	public String getRstCd() {
		return rstCd;
	}
	public void setRstCd(String rstCd) {
		this.rstCd = rstCd;
	}
	public String getRstMsg() {
		return rstMsg;
	}
	public void setRstMsg(String rstMsg) {
		this.rstMsg = rstMsg;
	}
	public String getRstCdNm() {
		return rstCdNm;
	}
	public void setRstCdNm(String rstCdNm) {
		this.rstCdNm = rstCdNm;
	}
	public String getTelNmCdNm() {
		return telNmCdNm;
	}
	public void setTelNmCdNm(String telNmCdNm) {
		this.telNmCdNm = telNmCdNm;
	}
	public String getApiNm() {
		return apiNm;
	}
	public void setApiNm(String apiNm) {
		this.apiNm = apiNm;
	}
	public int getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(int seqNo) {
		this.seqNo = seqNo;
	}
	
}
