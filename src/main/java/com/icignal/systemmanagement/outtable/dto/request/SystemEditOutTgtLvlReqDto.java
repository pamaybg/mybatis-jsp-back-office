package com.icignal.systemmanagement.outtable.dto.request;


import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemEditOutTgtLvlReqDto
 * 2. 파일명	: SystemEditOutTgtLvlReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 2015. 12. 07.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 타겟 레벨 수정
 * </PRE>
 */ 
public class SystemEditOutTgtLvlReqDto extends MKTGridPagingReqDto {
	
	private String id;			   //타겟 테이블 아이디
	private String accntId; 	   //접속 아이디
	private String targetLevelNm;  //타겟레벨명
	private String dbNm;    	   //DB명
	private String conIp;    	   //접속IP
	private String conPort;  	   //접속PORT
	private String conId;   	   //접속ID
	private String conPw;    	   //접속암호
	private String conDbType;      //접속DB 유형
	private String targetDesc;     //타겟레벨 설명
	private String memId;
	private boolean PwChk;
	private String secretNm;		//비밀명
	private String serviceNm;		//서비스명
	
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

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public boolean isPwChk() {
		return PwChk;
	}

	public void setPwChk(boolean pwChk) {
		PwChk = pwChk;
	}

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}

	public String getServiceNm() {
		return serviceNm;
	}

	public void setServiceNm(String serviceNm) {
		this.serviceNm = serviceNm;
	}
	
	
	

	
}
