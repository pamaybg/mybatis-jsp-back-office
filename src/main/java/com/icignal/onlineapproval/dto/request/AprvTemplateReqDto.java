package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
* @name : infavor.marketing.elapproval.dto.request.MKTAprvTemplateRequestDTO
* @date : 2018. 1. 16.
* @author : 이성원
* @description :
*/
public class AprvTemplateReqDto extends CommonDataAuthReqDto{
	private String apvType;
	private String apvStatus;
	private String biz_type;	 
	private String req_user;
	private String adj_mm;
	private String req_date;
	private String req_status;
	private String mbr_no;
	private String mbr_nm;
	private String aprv_status ;
	
	
	
	
	
	
	public String getApvType() {
		return apvType;
	}
	public void setApvType(String apvType) {
		this.apvType = apvType;
	}
	public String getBiz_type() {
		return biz_type;
	}
	public void setBiz_type(String biz_type) {
		this.biz_type = biz_type;
	}
	public String getReq_user() {
		return req_user;
	}
	public void setReq_user(String req_user) {
		this.req_user = req_user;
	}
	public String getAdj_mm() {
		return adj_mm;
	}
	public void setAdj_mm(String adj_mm) {
		this.adj_mm = adj_mm;
	}
	public String getReq_date() {
		return req_date;
	}
	public void setReq_date(String req_date) {
		this.req_date = req_date;
	}
	public String getReq_status() {
		return req_status;
	}
	public void setReq_status(String req_status) {
		this.req_status = req_status;
	}
	public String getMbr_no() {
		return mbr_no;
	}
	public void setMbr_no(String mbr_no) {
		this.mbr_no = mbr_no;
	}
	public String getMbr_nm() {
		return mbr_nm;
	}
	public void setMbr_nm(String mbr_nm) {
		this.mbr_nm = mbr_nm;
	}
	public String getAprv_status() {
		return aprv_status;
	}
	public void setAprv_status(String aprv_status) {
		this.aprv_status = aprv_status;
	}
	public String getApvStatus() {
		return apvStatus;
	}
	public void setApvStatus(String apvStatus) {
		this.apvStatus = apvStatus;
	}
	
	
	
}
