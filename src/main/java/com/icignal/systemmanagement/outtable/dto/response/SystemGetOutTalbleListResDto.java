package com.icignal.systemmanagement.outtable.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: SystemGetOutTalbleListResDto
 * 2. 파일명	: SystemGetOutTalbleListResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.response
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 컬럼 테이블 조회
 * </PRE>
 */ 
@CommCode
public class SystemGetOutTalbleListResDto extends GridPagingItemResDto {
	
	private String id;   
	private String targetLevelId;     //타겟 레벨 ID
	private String tblSchemaNm;     //테이블 스미카 명
	private String tblEngNm;     	//테이블영문명
	private String tblKorNm;     	//테이블한글명
	private String tblDesc;     	//테이블설명
	private String targetLevelNm;   //레벨 명
	@MarkName(codeField = "typeCode", groupCode = "EXTERNAL_TABLE_TYPE")
	private String type; 			//타입
	private String typeCode;        //타입 코드
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
	public String getTargetLevelNm() {
		return targetLevelNm;
	}
	public void setTargetLevelNm(String targetLevelNm) {
		this.targetLevelNm = targetLevelNm;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	
	
	
}
