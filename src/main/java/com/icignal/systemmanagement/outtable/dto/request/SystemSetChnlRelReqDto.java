package com.icignal.systemmanagement.outtable.dto.request;


import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemSetChnlRelReqDto
 * 2. 파일명	: MKTsetChnlRelRequestDTO.java
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
public class SystemSetChnlRelReqDto extends MKTGridPagingReqDto {
	
	private String id;		 //타겟 테이블 아이디
	private String memId;	 //생성, 수정자
	private String accntId;  //접속 아이디
	private String chnlId; 	 //채널 아이디
	private String columnId; //컬럼 아이디
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
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getChnlId() {
		return chnlId;
	}
	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
	public String getColumnId() {
		return columnId;
	}
	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}
	
	
	
}
