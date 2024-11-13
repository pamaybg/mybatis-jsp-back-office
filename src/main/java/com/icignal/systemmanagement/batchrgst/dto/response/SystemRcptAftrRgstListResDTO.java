package com.icignal.systemmanagement.batchrgst.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
* @name : infavor.loyalty.batchRgst.dto.response.LOYRcptAftrRgstListResponseDTO
* @date : 2018. 11. 26.
* @author : hy.jun
* @description :
*/
@SuppressWarnings("serial")
public class SystemRcptAftrRgstListResDTO extends GridPagingItemResDto {
	private String rid;
	private String modifyBy;
	private String modifyByNm;
	private String reqDt;
	private String rcptReqResultCd;
	private String rcptReqResultCdNm;
	private String inputRcptNo;
	private String inputSalesDt;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyByNm() {
		return modifyByNm;
	}
	public void setModifyByNm(String modifyByNm) {
		this.modifyByNm = modifyByNm;
	}
	public String getReqDt() {
		return reqDt;
	}
	public void setReqDt(String reqDt) {
		this.reqDt = reqDt;
	}
	public String getRcptReqResultCd() {
		return rcptReqResultCd;
	}
	public void setRcptReqResultCd(String rcptReqResultCd) {
		this.rcptReqResultCd = rcptReqResultCd;
	}
	public String getInputRcptNo() {
		return inputRcptNo;
	}
	public void setInputRcptNo(String inputRcptNo) {
		this.inputRcptNo = inputRcptNo;
	}
	public String getInputSalesDt() {
		return inputSalesDt;
	}
	public void setInputSalesDt(String inputSalesDt) {
		this.inputSalesDt = inputSalesDt;
	}
	public String getRcptReqResultCdNm() {
		return rcptReqResultCdNm;
	}
	public void setRcptReqResultCdNm(String rcptReqResultCdNm) {
		this.rcptReqResultCdNm = rcptReqResultCdNm;
	}
}
