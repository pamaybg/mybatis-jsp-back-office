package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.common.auth.dto.request.MKTAuthLogInsertRequestDTO
* @date : 2019. 1. 24.
* @author : hy.jun
* @description :
*/
public class AuthLogInsertReqDto extends MKTBaseReqDto {
	private String srchDt;
	private String authLogTypeCd;
	private String logTypeDtl;
	private String srcRid;
	private String srcNm;
	private String targetRid;
	private String targetNm;
	private String objRid;
	private String objNm;
	
	public String getSrchDt() {
		return srchDt;
	}
	public void setSrchDt(String srchDt) {
		this.srchDt = srchDt;
	}
	public String getAuthLogTypeCd() {
		return authLogTypeCd;
	}
	public void setAuthLogTypeCd(String authLogTypeCd) {
		this.authLogTypeCd = authLogTypeCd;
	}
	public String getLogTypeDtl() {
		return logTypeDtl;
	}
	public void setLogTypeDtl(String logTypeDtl) {
		this.logTypeDtl = logTypeDtl;
	}
	public String getSrcRid() {
		return srcRid;
	}
	public void setSrcRid(String srcRid) {
		this.srcRid = srcRid;
	}
	public String getSrcNm() {
		return srcNm;
	}
	public void setSrcNm(String srcNm) {
		this.srcNm = srcNm;
	}
	public String getTargetRid() {
		return targetRid;
	}
	public void setTargetRid(String targetRid) {
		this.targetRid = targetRid;
	}
	public String getTargetNm() {
		return targetNm;
	}
	public void setTargetNm(String targetNm) {
		this.targetNm = targetNm;
	}
	public String getObjRid() {
		return objRid;
	}
	public void setObjRid(String objRid) {
		this.objRid = objRid;
	}
	public String getObjNm() {
		return objNm;
	}
	public void setObjNm(String objNm) {
		this.objNm = objNm;
	}
}
