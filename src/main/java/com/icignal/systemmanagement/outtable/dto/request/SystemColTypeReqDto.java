package com.icignal.systemmanagement.outtable.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemColTypeReqDto
 * 2. 파일명	: SystemColTypeReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 01. 29.
 */
/**
 * <PRE>
 * 1. 설명
 *		채널 관계 삽입
 * </PRE>
 */ 
public class SystemColTypeReqDto extends MKTGridPagingReqDto {
	
	private String id;		 //타겟 테이블 아이디
	private String accntId;  //접속 아이디
	private String type;   	//타입
	private String colTypeDefine; //컬럼타입
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getColTypeDefine() {
		return colTypeDefine;
	}
	public void setColTypeDefine(String colTypeDefine) {
		this.colTypeDefine = colTypeDefine;
	}
	
	
	
	
}
