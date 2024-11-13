package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class SystemAprLogDetailResDto extends GridPagingItemResDto{
	private String trNo 		   ;
	private String logType		   ;
	private String occuPgmType	   ;
	private String reqType		   ;
	private String pgmNm		   ;
	private String errSrcNum	   ;
	private String errMsg		   ;
	private String errDesc 			;


	public String getErrDesc() {
		return errDesc;
	}
	public void setErrDesc(String errDesc) {
		this.errDesc = errDesc;
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
	public String getOccuPgmType() {
		return occuPgmType;
	}
	public void setOccuPgmType(String occuPgmType) {
		this.occuPgmType = occuPgmType;
	}
	public String getReqType() {
		return reqType;
	}
	public void setReqType(String reqType) {
		this.reqType = reqType;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getErrSrcNum() {
		return errSrcNum;
	}
	public void setErrSrcNum(String errSrcNum) {
		this.errSrcNum = errSrcNum;
	}
	public String getErrMsg() {
		return errMsg;
	}
	public void setErrMsg(String errMsg) {
		this.errMsg = errMsg;
	}

}
