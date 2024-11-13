package com.icignal.systemmanagement.outtable.dto.request;


import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemDeleteOutColumnReqDto
 * 2. 파일명	: SystemDeleteOutColumnReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 컬럼 삭제
 * </PRE>
 */ 
public class SystemDeleteOutColumnReqDto extends MKTGridPagingReqDto {
	
	private String id;			//타겟 테이블 아이디
	private String memId; 		//접속 아이디
	private List<String> outColumnId; //컬럼 아이디
	
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

	public List<String> getOutColumnId() {
		return outColumnId;
	}

	public void setOutColumnId(List<String> outColumnId) {
		this.outColumnId = outColumnId;
	}

	
	

	
}
