package com.icignal.systemmanagement.outtable.dto.request;


import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemDeleteOutTgtLvlReqDto
 * 2. 파일명	: SystemDeleteOutTgtLvlReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 타겟 레벨 삭제
 * </PRE>
 */ 
public class SystemDeleteOutTgtLvlReqDto extends MKTGridPagingReqDto {
	
	private String id;					//타겟 테이블 아이디
	private String memId; 				//접속 아이디
	private List<String> targetLevelId;
	
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

	public List<String> getTargetLevelId() {
		return targetLevelId;
	}

	public void setTargetLevelId(List<String> targetLevelId) {
		this.targetLevelId = targetLevelId;
	}
	
	
}
