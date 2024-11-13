package com.icignal.systemmanagement.outtable.dto.request;


import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemEditOutTableReqDto
 * 2. 파일명	: SystemEditOutTableReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 테이블 수정
 * </PRE>
 */ 
public class SystemEditOutTableReqDto extends MKTGridPagingReqDto {
	
	private String id;				//타겟 테이블 아이디
	private String accntId; 		//접속 아이디
	private String targetLevelId;   //타겟 레벨 ID
	private String tblSchemaNm;     //테이블 스미카 명
	private String tblEngNm;    	//테이블영문명
	private String tblKorNm;    	//테이블한글명
	private String tblDesc;     	//테이블설명
	private String memId;			//생성,수정자 ID
	private String type; 			//타입
	private String secretNm;		//비밀명
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTargetLevelId() {
		return targetLevelId;
	}
	public void setTargetLevelId(String targetLevelId) {
		this.targetLevelId = targetLevelId;
	}
	public String getTblSchemaNm() {
		return tblSchemaNm;
	}
	public void setTblSchemaNm(String tblSchemaNm) {
		this.tblSchemaNm = tblSchemaNm;
	}
	public String getTblEngNm() {
		return tblEngNm;
	}
	public void setTblEngNm(String tblEngNm) {
		this.tblEngNm = tblEngNm;
	}
	public String getTblKorNm() {
		return tblKorNm;
	}
	public void setTblKorNm(String tblKorNm) {
		this.tblKorNm = tblKorNm;
	}
	public String getTblDesc() {
		return tblDesc;
	}
	public void setTblDesc(String tblDesc) {
		this.tblDesc = tblDesc;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	
	

	
}
