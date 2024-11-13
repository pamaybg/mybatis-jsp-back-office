package com.icignal.loyalty.event.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyMbrMsgReqDto extends CommonDataAuthReqDto{
	private String rid;
	private String mbrRid;
	private String evtRid;
	private String type;
	private String route;
	private String msg;
	private String actionDt;
	private String actionTm;
	private String ridChnl;
	private String campNo;
	private String pnt;
	private String txnTypeDtlcd;
	private String status;
	private String flag;
	private String RST;
	private String RST_CD;
	private String RST_MSG;
	private String crudType;
	private String ridMbr;
	
	
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getMbrRid() {
		return mbrRid;
	}
	public void setMbrRid(String mbrRid) {
		this.mbrRid = mbrRid;
	}
	public String getRoute() {
		return route;
	}
	public void setRoute(String route) {
		this.route = route;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getActionDt() {
		return actionDt;
	}
	public void setActionDt(String actionDt) {
		this.actionDt = actionDt;
	}
	public String getActionTm() {
		return actionTm;
	}
	public void setActionTm(String actionTm) {
		this.actionTm = actionTm;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getCampNo() {
		return campNo;
	}
	public void setCampNo(String campNo) {
		this.campNo = campNo;
	}
	public String getPnt() {
		return pnt;
	}
	public void setPnt(String pnt) {
		this.pnt = pnt;
	}
	public String getTxnTypeDtlcd() {
		return txnTypeDtlcd;
	}
	public void setTxnTypeDtlcd(String txnTypeDtlcd) {
		this.txnTypeDtlcd = txnTypeDtlcd;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRST() {
		return RST;
	}
	public void setRST(String rST) {
		RST = rST;
	}
	public String getRST_CD() {
		return RST_CD;
	}
	public void setRST_CD(String rST_CD) {
		RST_CD = rST_CD;
	}
	public String getRST_MSG() {
		return RST_MSG;
	}
	public void setRST_MSG(String rST_MSG) {
		RST_MSG = rST_MSG;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public String getEvtRid() {
		return evtRid;
	}
	public void setEvtRid(String evtRid) {
		this.evtRid = evtRid;
	}
	public String getCrudType() {
		return crudType;
	}
	public void setCrudType(String crudType) {
		this.crudType = crudType;
	}
	
	
}
