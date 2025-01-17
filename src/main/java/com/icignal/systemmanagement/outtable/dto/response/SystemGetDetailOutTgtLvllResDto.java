package com.icignal.systemmanagement.outtable.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: SystemGetDetailOutTgtLvllResDto
 * 2. 파일명	: SystemGetDetailOutTgtLvllResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.response
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 타겟 레벨 리스트 조회
 * </PRE>
 */ 
@CommCode
public class SystemGetDetailOutTgtLvllResDto extends GridPagingItemResDto {
	
	private String id;   
	private String targetLevelNm;  //타겟레벨명
	private String dbNm;    	   //DB명
	private String conIp;    	   //접속IP
	private String conPort;  	   //접속PORT
	private String conId;   	   //접속ID
	private String conPw;    	   //접속암호
	@MarkName(codeField = "conDbTypeCdNm", groupCode = "CHNL_CON_DB_TYPE")
	private String conDbType;      //접속DB 유형
	private String conDbTypeCdNm;
	private String targetDesc;     //타겟레벨 설명
	private String secretNm;		//비밀명
	private String serviceNm;
	private String createBy;
	private String createDate;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTargetLevelNm() {
		return targetLevelNm;
	}
	public void setTargetLevelNm(String targetLevelNm) {
		this.targetLevelNm = targetLevelNm;
	}
	public String getDbNm() {
		return dbNm;
	}
	public void setDbNm(String dbNm) {
		this.dbNm = dbNm;
	}
	public String getConIp() {
		return conIp;
	}
	public void setConIp(String conIp) {
		this.conIp = conIp;
	}
	public String getConPort() {
		return conPort;
	}
	public void setConPort(String conPort) {
		this.conPort = conPort;
	}
	public String getConId() {
		return conId;
	}
	public void setConId(String conId) {
		this.conId = conId;
	}
	public String getConPw() {
		return conPw;
	}
	public void setConPw(String conPw) {
		this.conPw = conPw;
	}
	public String getConDbType() {
		return conDbType;
	}
	public void setConDbType(String conDbType) {
		this.conDbType = conDbType;
	}
	public String getTargetDesc() {
		return targetDesc;
	}
	public void setTargetDesc(String targetDesc) {
		this.targetDesc = targetDesc;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	public String getConDbTypeCdNm() {
		return conDbTypeCdNm;
	}
	public void setConDbTypeCdNm(String conDbTypeCdNm) {
		this.conDbTypeCdNm = conDbTypeCdNm;
	}
	public String getServiceNm() {
		return serviceNm;
	}
	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	
	
}
