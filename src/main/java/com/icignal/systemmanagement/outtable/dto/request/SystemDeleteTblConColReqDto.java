package com.icignal.systemmanagement.outtable.dto.request;


import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemDeleteTblConColReqDto
 * 2. 파일명	: SystemDeleteTblConColReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		컬럼에 관꼐된 채널 관꼐 컬럼들 삭제
 * </PRE>
 */ 
public class SystemDeleteTblConColReqDto extends MKTGridPagingReqDto {
	
	private String id;					//타겟 테이블 아이디
	private List<String> tblid;    			//테이블 아이디
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<String> getTblid() {
		return tblid;
	}
	public void setTblid(List<String> tblid) {
		this.tblid = tblid;
	}
	


	
}
