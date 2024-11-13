package com.icignal.kepler.logicalComponent.dto.request;

import java.util.List;

/*
 * 1. 클래스명	: KPRLogicalComponentDeleteIdListRequestDTO
 * 2. 파일명	: KPRLogicalComponentDeleteIdListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.request
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		로지컬 컴포넌트 ID 리스트기준 삭제 요청  DTO
 * </PRE>
 */ 
public class KprLogicalComponentDeleteIdListReqDto {
	
	private String lgcCompId;
	private String modifyBy;
	private List<String> removeIdList;

	public String getLgcCompId() {
		return lgcCompId;
	}

	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public List<String> getRemoveIdList() {
		return removeIdList;
	}

	public void setRemoveIdList(List<String> removeIdList) {
		this.removeIdList = removeIdList;
	}
	
}