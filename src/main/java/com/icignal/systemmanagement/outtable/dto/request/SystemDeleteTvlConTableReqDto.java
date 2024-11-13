package com.icignal.systemmanagement.outtable.dto.request;


import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemDeleteTvlConTableReqDto
 * 2. 파일명	: SystemDeleteTvlConTableReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		타겟 레벨에 관련된 테이블 삭제
 * </PRE>
 */ 
public class SystemDeleteTvlConTableReqDto extends MKTGridPagingReqDto {
	
	private String id;					//타겟 테이블 아이디
	private List<String> tgtLvlId;    		//타겟 레벨 아이디
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<String> getTgtLvlId() {
		return tgtLvlId;
	}
	public void setTgtLvlId(List<String> tgtLvlId) {
		this.tgtLvlId = tgtLvlId;
	}
	

	


	
}
