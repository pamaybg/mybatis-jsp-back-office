package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 18.
 * @author : 이원준
 * @description : 주제영역 삭제 RequestDTO
 */
public class KprDelSubjectAreaReqDto extends CommonDataAuthReqDto {
	
	private List<String> subjectAreaId;		//주제영역 아이디
	private String modifyBy;						//수정자 
	private String accountId;   					//어카운트 아이디
	private String subjectDbId;   					//주제영역DB 아이디

	public String getAccountId() {
		return accountId;
	}

	public String getSubjectDbId() {
		return subjectDbId;
	}

	public void setSubjectDbId(String subjectDbId) {
		this.subjectDbId = subjectDbId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public List<String> getSubjectAreaId() {
		return subjectAreaId;
	}

	public void setSubjectAreaId(List<String> subjectAreaId) {
		this.subjectAreaId = subjectAreaId;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	

}
