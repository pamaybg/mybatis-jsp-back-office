package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 8. 5.
 * @author : LEE
 * @description : 주제영역 순서 변경 DTO
 */
public class KprEditSubjectDbReqDto extends CommonDataAuthReqDto {
	
	private String subjectDbId;		//주제영역DB 아이디
	private String modifyBy;			//수정자
	private String subjectAreaId;			//주제영역 아이디
	private String dbInformId;			//DB정보 아이디
	private Integer seq;					//순서
	
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
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getSubjectDbId() {
		return subjectDbId;
	}
	public void setSubjectDbId(String subjectDbId) {
		this.subjectDbId = subjectDbId;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}

    
}
