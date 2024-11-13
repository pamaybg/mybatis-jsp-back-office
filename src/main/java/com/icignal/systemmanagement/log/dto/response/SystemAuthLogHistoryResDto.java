package com.icignal.systemmanagement.log.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * @name : infavor.common.log.dto.response.ICNLoginHistoryResponseDTO
 * @date : 2019. 01. 28.
 * @author : "dw.keum"
 * @description : 공통 조회 조건 이력 Response
 */
@CommCode
public class SystemAuthLogHistoryResDto  extends GridPagingItemResDto{
	
	private String rid;				//로그인 RID
	@MarkName(groupCode = "COM_AUTH_LOG_TYPE_CD", codeField = "authLogTypeCdNm")
	private String authLogTypeNm;	//직업유형
	private String authLogTypeCdNm; 
	
	@MarkName(groupCode = "LOG_TYPE_DTL", codeField = "logTypeDtlCdNm")
	private String logTypeDtlNm;	//직업유형 상세
	private String logTypeDtlCdNm;	
	private String targetRid;		//타겟RID
	private String targetNm;		//타겟명
	private String objRid;			//오브젝트RID
	private String objNm;			//오브젝트 명
	private String name;			//작업자명
	private String userId;			//작업자ID
	private String srchDt;			//작업일시
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getAuthLogTypeCdNm() {
		return authLogTypeCdNm;
	}
	public void setAuthLogTypeCdNm(String authLogTypeCdNm) {
		this.authLogTypeCdNm = authLogTypeCdNm;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSrchDt() {
		return srchDt;
	}
	public void setSrchDt(String srchDt) {
		this.srchDt = srchDt;
	}
	public String getLogTypeDtlNm() {
		return logTypeDtlNm;
	}
	public void setLogTypeDtlNm(String logTypeDtlNm) {
		this.logTypeDtlNm = logTypeDtlNm;
	}
	public String getAuthLogTypeNm() {
		return authLogTypeNm;
	}
	public void setAuthLogTypeNm(String authLogTypeNm) {
		this.authLogTypeNm = authLogTypeNm;
	}
	public String getLogTypeDtlCdNm() {
		return logTypeDtlCdNm;
	}
	public void setLogTypeDtlCdNm(String logTypeDtlCdNm) {
		this.logTypeDtlCdNm = logTypeDtlCdNm;
	}
	
	
}
