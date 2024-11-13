package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 18.
 * @author : 이원준
 * @description : 주제영역 목록 RequestDTO
 */
public class KprSetSubjectAreaMappingReqDto extends CommonDataAuthReqDto {
	
    private String subjectDbId;    //주제영역DB 아이디
    private String accountId;   //어카운트 아이디
    private String createBy;     //생성자
    private String modifyBy;     //수정자
    
    private String subjectAreaId;    //주제영역ID
    private String dbInformId;    //DB정보 ID
    private int seq;    //순서
    
	public String getSubjectDbId() {
		return subjectDbId;
	}
	public void setSubjectDbId(String subjectDbId) {
		this.subjectDbId = subjectDbId;
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
	public String getSubjectAreaId() {
		return subjectAreaId;
	}
	public void setSubjectAreaId(String subjectAreaId) {
		this.subjectAreaId = subjectAreaId;
	}
	public String getDbInformId() {
		return dbInformId;
	}
	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}

}
