package com.icignal.loyalty.customer.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


@CommCode
public class LoyCafe24CamHistResDto extends GridPagingItemResDto{
	
	private String dispNo;
	private String camNm;
	private String camTypeCd;
	@MarkName(groupCode = "MKT_CAM_TYPE_CD", codeField = "camTypeCd")
	private String camTypeNm;
	
	private String camStatusCd;
	@MarkName(groupCode = "MKT_CAM_STAT", codeField = "camStatusCd")
	private String camStatusNm;
	
	private String camStartDt;
	private String camEndDt;
	private String chnlNm;
	private String sendStatus;
	public String getDispNo() {
		return dispNo;
	}
	public void setDispNo(String dispNo) {
		this.dispNo = dispNo;
	}
	public String getCamNm() {
		return camNm;
	}
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}
	public String getCamTypeCd() {
		return camTypeCd;
	}
	public void setCamTypeCd(String camTypeCd) {
		this.camTypeCd = camTypeCd;
	}
	public String getCamTypeNm() {
		return camTypeNm;
	}
	public void setCamTypeNm(String camTypeNm) {
		this.camTypeNm = camTypeNm;
	}
	public String getCamStatusCd() {
		return camStatusCd;
	}
	public void setCamStatusCd(String camStatusCd) {
		this.camStatusCd = camStatusCd;
	}
	public String getCamStatusNm() {
		return camStatusNm;
	}
	public void setCamStatusNm(String camStatusNm) {
		this.camStatusNm = camStatusNm;
	}
	public String getCamStartDt() {
		return camStartDt;
	}
	public void setCamStartDt(String camStartDt) {
		this.camStartDt = camStartDt;
	}
	public String getCamEndDt() {
		return camEndDt;
	}
	public void setCamEndDt(String camEndDt) {
		this.camEndDt = camEndDt;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getSendStatus() {
		return sendStatus;
	}
	public void setSendStatus(String sendStatus) {
		this.sendStatus = sendStatus;
	}
	
	

}
