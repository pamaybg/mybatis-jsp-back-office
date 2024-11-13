package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * @name : MKTApproverItemInsertRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 승인자 추가
 */

@CommCode
public class ApproverItemInsertReqDto extends CommonDataAuthReqDto{
	private String id;                    //아이디
	private String memId;                 //요청 아이디
	private String aprvId;                //전자결재 ID
	private String seq;					  //순서
	private String arvrId;                //승인자ID
	private String orgId;                 //조직 ID
	private String apvDD;                 //승인 일자
	
	@MarkName(groupCode = "EL_APPROVER_TYPE_CD", codeField = "apvrTypeCd")
	private String apvrType;              //승인자 유형코드
	private String aprbStatus;            //결재 상태코드
	private String createBy;              //생성자
	private String modifyBy;              //수정자
	private String rejectDd;              //반려 일자
	private String rejectRsn;             //반려 이유
	private String apvrTypeCd;
		
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getAprvId() {
		return aprvId;
	}

	public void setAprvId(String aprvId) {
		this.aprvId = aprvId;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	public String getArvrId() {
		return arvrId;
	}

	public void setArvrId(String arvrId) {
		this.arvrId = arvrId;
	}

	public String getOrgId() {
		return orgId;
	}

	public void setOrgId(String orgId) {
		this.orgId = orgId;
	}

	public String getApvDD() {
		return apvDD;
	}

	public void setApvDD(String apvDD) {
		this.apvDD = apvDD;
	}

	public String getApvrType() {
		return apvrType;
	}

	public void setApvrType(String apvrType) {
		this.apvrType = apvrType;
	}

	public String getAprbStatus() {
		return aprbStatus;
	}

	public void setAprbStatus(String aprbStatus) {
		this.aprbStatus = aprbStatus;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getRejectDd() {
		return rejectDd;
	}

	public void setRejectDd(String rejectDd) {
		this.rejectDd = rejectDd;
	}

	public String getRejectRsn() {
		return rejectRsn;
	}

	public void setRejectRsn(String rejectRsn) {
		this.rejectRsn = rejectRsn;
	}

	public String getApvrTypeCd() {
		return apvrTypeCd;
	}

	public void setApvrTypeCd(String apvrTypeCd) {
		this.apvrTypeCd = apvrTypeCd;
	}
	
	
	
	
	
	
}
