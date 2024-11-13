package com.icignal.systemmanagement.outtable.dto.request;


import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemGetChannelListReqDto
 * 2. 파일명	: SystemGetChannelListReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 채널 리스트 조회
 * </PRE>
 */ 
public class SystemGetChannelListReqDto extends MKTGridPagingReqDto {
	
	private String id;		//타겟 테이블 아이디
	private String accntId; //접속 아이디
	
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
	
	

	
}
