package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 18.
 * @author : 이원준
 * @description : 주제영역 목록 RequestDTO
 */
public class KprSubjectAreaListReqDto extends CommonDataAuthReqDto {
	
    private String accountId;   //어카운트 아이디
    private String subjectAreaId;   //주제영역 아이디
    private  List<String> subjectAreaId1;   //주제영역 아이디
    private String dbInformId;   //db정보 아이디
    private String subjectAreaNm;   //주제영역명
    private String subjectDbId;   //주제영역명
    private String subjectDbRelId;   //주제영역DB 아이디

    public String getSubjectDbRelId() {
		return subjectDbRelId;
	}

	public void setSubjectDbRelId(String subjectDbRelId) {
		this.subjectDbRelId = subjectDbRelId;
	}

	public String getSubjectDbId() {
		return subjectDbId;
	}

	public void setSubjectDbId(String subjectDbId) {
		this.subjectDbId = subjectDbId;
	}

	public List<String> getSubjectAreaId1() {
		return subjectAreaId1;
	}

	public void setSubjectAreaId1(List<String> subjectAreaId1) {
		this.subjectAreaId1 = subjectAreaId1;
	}

	public String getSubjectAreaNm() {
		return subjectAreaNm;
	}

	public void setSubjectAreaNm(String subjectAreaNm) {
		this.subjectAreaNm = subjectAreaNm;
	}

	public String getDbInformId() {
		return dbInformId;
	}

	public void setDbInformId(String dbInformId) {
		this.dbInformId = dbInformId;
	}

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
    
}
