package com.icignal.systemmanagement.outtable.dto.request;


import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemGetOutTableListReqDto
 * 2. 파일명	: SystemGetOutTableListReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 테이블 리스트 조회
 * </PRE>
 */ 
public class SystemGetOutTableListReqDto extends MKTGridPagingReqDto {
	
	private String id;		//타겟 테이블 아이디
	private String accntId; //접속 아이디
	private String targetLevelId;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}

	public String getTargetLevelId() {
		return targetLevelId;
	}

	public void setTargetLevelId(String targetLevelId) {
		this.targetLevelId = targetLevelId;
	}
	
	

	
}
