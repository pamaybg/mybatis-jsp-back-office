package com.icignal.onlineapproval.dto.response;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * @name : MKTApprvReqResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 승인자 정보
 */
@JsonIgnoreProperties(ignoreUnknown = true)
@CommCode
public class ApprvReqResDto extends GridPagingItemResDto{
	private String id;                  //아이디
	private String apprvId;             //전자결재승인ID
	private String seq;                 //순번
	private String apprvName;           //승인자 명
	private String apprvDept;           //승인자 부서 
	private String apprvConfirmDate;    //결재 승인일자
	@MarkName(groupCode = "EL_APPROVER_TYPE_CD", codeField = "apprvCode")
	private String apprvType;           //승인자 유형
	private String elApproveStatusCd;
	@MarkName(groupCode = "EL_APL_ITEM_STATUS_CD", codeField = "elApproveStatusCd")
	private String elApproveStatus;     //결재상태
	private String apvDd;               //승인 일자
	private String statusCode;          //상태 코드
	private String apprvCode;           //결재자 유형 코드
	private String acId;                //결재자 Account
	private String pacId;				//결재자  부모 Account
	private String apvrId;              //승인자 Id
	private String rejectRsn; 			//반려사유
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getApprvId() {
		return apprvId;
	}
	public void setApprvId(String apprvId) {
		this.apprvId = apprvId;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getApprvName() {
		return apprvName;
	}
	public void setApprvName(String apprvName) {
		this.apprvName = apprvName;
	}
	public String getApprvConfirmDate() {
		return apprvConfirmDate;
	}
	public void setApprvConfirmDate(String apprvConfirmDate) {
		this.apprvConfirmDate = apprvConfirmDate;
	}
	public String getApprvType() {
		return apprvType;
	}
	public void setApprvType(String apprvType) {
		this.apprvType = apprvType;
	}
	public String getElApproveStatus() {
		return elApproveStatus;
	}
	public void setElApproveStatus(String elApproveStatus) {
		this.elApproveStatus = elApproveStatus;
	}
	public String getApprvDept() {
		return apprvDept;
	}
	public void setApprvDept(String apprvDept) {
		this.apprvDept = apprvDept;
	}
	public String getApvDd() {
		return apvDd;
	}
	public void setApvDd(String apvDd) {
		this.apvDd = apvDd;
	}
	public String getStatusCode() {
		return statusCode;
	}
	public void setStatusCode(String statusCode) {
		this.statusCode = statusCode;
	}
	public String getApprvCode() {
		return apprvCode;
	}
	public void setApprvCode(String apprvCode) {
		this.apprvCode = apprvCode;
	}
	public String getAcId() {
		return acId;
	}
	public void setAcId(String acId) {
		this.acId = acId;
	}
	public String getPacId() {
		return pacId;
	}
	public void setPacId(String pacId) {
		this.pacId = pacId;
	}
	public String getApvrId() {
		return apvrId;
	}
	public void setApvrId(String apvrId) {
		this.apvrId = apvrId;
	}
	public String getElApproveStatusCd() {
		return elApproveStatusCd;
	}
	public void setElApproveStatusCd(String elApproveStatusCd) {
		this.elApproveStatusCd = elApproveStatusCd;
	}
	public String getRejectRsn() {return rejectRsn;}
	public void setRejectRsn(String rejectRsn) {this.rejectRsn = rejectRsn;}
}
