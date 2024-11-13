package com.icignal.common.base.dto.request;

/**
* @name : infavor.marketing.common.common.dto.request.MKTComCondLogInsertRequestDTO
* @date : 2019. 1. 25.
* @author : hy.jun
* @description :
*/
public class ComCondLogInsertReqDto extends CommonCondReqDto {
	private String rid;
	private String srchDt;
	private String pageRid;
	private String srchUserRid;
	private String srchCondRid;
	private String rsltCnt;
	private String itemRid;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getSrchDt() {
		return srchDt;
	}
	public void setSrchDt(String srchDt) {
		this.srchDt = srchDt;
	}
	public String getPageRid() {
		return pageRid;
	}
	public void setPageRid(String pageRid) {
		this.pageRid = pageRid;
	}
	public String getSrchUserRid() {
		return srchUserRid;
	}
	public void setSrchUserRid(String srchUserRid) {
		this.srchUserRid = srchUserRid;
	}
	public String getSrchCondRid() {
		return srchCondRid;
	}
	public void setSrchCondRid(String srchCondRid) {
		this.srchCondRid = srchCondRid;
	}
	public String getRsltCnt() {
		return rsltCnt;
	}
	public void setRsltCnt(String rsltCnt) {
		this.rsltCnt = rsltCnt;
	}
	public String getItemRid() {
		return itemRid;
	}
	public void setItemRid(String itemRid) {
		this.itemRid = itemRid;
	}


}
