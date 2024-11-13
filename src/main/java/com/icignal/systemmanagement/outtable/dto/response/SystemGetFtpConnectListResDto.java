package com.icignal.systemmanagement.outtable.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: SystemGetFtpConnectListResDto
 * 2. 파일명	: SystemGetFtpConnectListResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.response
 * 4. 작성자명	: 송원희
 * 5. 작성일자	: 2016. 4. 04.
 */
/**
 * <PRE>
 * 1. 설명
 *		외부 테이블 FTP 리스트 조회
 * </PRE>
 */ 
public class SystemGetFtpConnectListResDto extends GridPagingItemResDto {
	
	private String id;		//타겟 테이블 아이디
	private String accntId; //접속 아이디
	private String memId;	
	private String ftp_prps_cd_nm;
	private String ftp_prot_cd_nm;
	private String ftp_prps_cd_id;
	private String ftp_prot_cd_id;
	private String con_id;
	private String con_pw;
	private String con_ip;
	private String con_port;
	private String con_foldr_path;
	private String ftp_desc;
	private String pwChk;
	private String secretNm;
	
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

	public String getFtp_prps_cd_nm() {
		return ftp_prps_cd_nm;
	}

	public void setFtp_prps_cd_nm(String ftp_prps_cd_nm) {
		this.ftp_prps_cd_nm = ftp_prps_cd_nm;
	}

	public String getFtp_prot_cd_nm() {
		return ftp_prot_cd_nm;
	}

	public void setFtp_prot_cd_nm(String ftp_prot_cd_nm) {
		this.ftp_prot_cd_nm = ftp_prot_cd_nm;
	}

	public String getFtp_prps_cd_id() {
		return ftp_prps_cd_id;
	}

	public void setFtp_prps_cd_id(String ftp_prps_cd_id) {
		this.ftp_prps_cd_id = ftp_prps_cd_id;
	}

	public String getFtp_prot_cd_id() {
		return ftp_prot_cd_id;
	}

	public void setFtp_prot_cd_id(String ftp_prot_cd_id) {
		this.ftp_prot_cd_id = ftp_prot_cd_id;
	}

	public String getCon_id() {
		return con_id;
	}

	public void setCon_id(String con_id) {
		this.con_id = con_id;
	}

	public String getCon_pw() {
		return con_pw;
	}

	public void setCon_pw(String con_pw) {
		this.con_pw = con_pw;
	}

	public String getCon_ip() {
		return con_ip;
	}

	public void setCon_ip(String con_ip) {
		this.con_ip = con_ip;
	}

	public String getCon_port() {
		return con_port;
	}

	public void setCon_port(String con_port) {
		this.con_port = con_port;
	}

	public String getCon_foldr_path() {
		return con_foldr_path;
	}

	public void setCon_foldr_path(String con_foldr_path) {
		this.con_foldr_path = con_foldr_path;
	}

	public String getFtp_desc() {
		return ftp_desc;
	}

	public void setFtp_desc(String ftp_desc) {
		this.ftp_desc = ftp_desc;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}

	public String getPwChk() {
		return pwChk;
	}

	public void setPwChk(String pwChk) {
		this.pwChk = pwChk;
	}

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}

}
