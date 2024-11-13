package com.icignal.common.base.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyCampaignExecListResDto extends GridPagingItemResDto {
	private String  rid;
	private String  dispNo;
	private String  camNm;
	private String  camTypeCd;
	//@MarkName(groupCode = "MKT_CAM_TYPE_CD", codeField = "camTypeCd")
	private String  camTypeCdNm;
	
	private String  camStatusCd;
	//@MarkName(groupCode = "MKT_CAM_STAT", codeField = "camStatusCd")
	private String  camStatusCdNm;
	
	private String  camStartDD;
	private String  camEndDD;
	private String  sendSucesYn;
	
	private String  revSucesYn;

	private String  openSucesYn;

	private String  chnlTypeCd;
	@MarkName(groupCode = "MKT_CAM_CHNL_TYPE_CD", codeField = "chnlTypeCd")
	private String  chnlTypeCdNm;

	@MarkName(groupCode = "RSLT_CD", codeField = "batSendStatus")
	private String  batSendStatusNm;
	private String  batSendStatus;

	private String  actAmt;

	
	
	
	public String getRevSucesYn() {
		return revSucesYn;
	}
	public void setRevSucesYn(String revSucesYn) {
		this.revSucesYn = revSucesYn;
	}
	public String getOpenSucesYn() {
		return openSucesYn;
	}
	public void setOpenSucesYn(String openSucesYn) {
		this.openSucesYn = openSucesYn;
	}
	public String getChnlTypeCdNm() {
		return chnlTypeCdNm;
	}
	public void setChnlTypeCdNm(String chnlTypeCdNm) {
		this.chnlTypeCdNm = chnlTypeCdNm;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSendSucesYn() {
		return sendSucesYn;
	}
	public void setSendSucesYn(String sendSucesYn) {
		this.sendSucesYn = sendSucesYn;
	}
	public String getCamStatusCdNm() {
		return camStatusCdNm;
	}
	public void setCamStatusCdNm(String camStatusCdNm) {
		this.camStatusCdNm = camStatusCdNm;
	}
	public String getCamTypeCdNm() {
		return camTypeCdNm;
	}
	public void setCamTypeCdNm(String camTypeCdNm) {
		this.camTypeCdNm = camTypeCdNm;
	}
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
	public String getCamStatusCd() {
		return camStatusCd;
	}
	public void setCamStatusCd(String camStatusCd) {
		this.camStatusCd = camStatusCd;
	}
	public String getCamStartDD() {
		return camStartDD;
	}
	public void setCamStartDD(String camStartDD) {
		this.camStartDD = camStartDD;
	}
	public String getCamEndDD() {
		return camEndDD;
	}
	public void setCamEndDD(String camEndDD) {
		this.camEndDD = camEndDD;
	}
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}

	public String getBatSendStatusNm() {
		return batSendStatusNm;
	}

	public void setBatSendStatusNm(String batSendStatusNm) {
		this.batSendStatusNm = batSendStatusNm;
	}

	public String getBatSendStatus() {
		return batSendStatus;
	}

	public void setBatSendStatus(String batSendStatus) {
		this.batSendStatus = batSendStatus;
	}

	public String getActAmt() {
		return actAmt;
	}

	public void setActAmt(String actAmt) {
		this.actAmt = actAmt;
	}
}
