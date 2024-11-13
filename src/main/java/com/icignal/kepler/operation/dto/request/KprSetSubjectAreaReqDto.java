package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 18.
 * @author : 이원준
 * @description : 주제영역 목록 RequestDTO
 */
public class KprSetSubjectAreaReqDto extends CommonDataAuthReqDto {
	
	private String subjectAreaId;    //주제영역 아이디
    private String accountId;   //어카운트 아이디
    private String createBy;     //생성자
    private String modifyBy;     //수정자

    private String subjectAreaNm;     	//주제영역명
    private String subjectDesc;    //주제영역설명
	private boolean pwChk;
	public String getSubjectAreaId() {
		return subjectAreaId;
	}
	public void setSubjectAreaId(String subjectAreaId) {
		this.subjectAreaId = subjectAreaId;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
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
	public String getSubjectAreaNm() {
		return subjectAreaNm;
	}
	public void setSubjectAreaNm(String subjectAreaNm) {
		this.subjectAreaNm = subjectAreaNm;
	}
	public String getSubjectDesc() {
		return subjectDesc;
	}
	public void setSubjectDesc(String subjectDesc) {
		this.subjectDesc = subjectDesc;
	}
	public boolean isPwChk() {
		return pwChk;
	}
	public void setPwChk(boolean pwChk) {
		this.pwChk = pwChk;
	}
    
    
}
