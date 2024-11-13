/*
 * Copyright 2016-2020 by Quintet Systems Corp.,
 * All rights reserved.
 *
 * This software is the confidential and proprietary information
 * of Quintet Systems Corp.
 */
/**

 * 1. FileName	: SystemGetEmailHostListReqDto.java
 * 2. Package	: com.icignal.systemmanagement.outtable.dto.request
 * 3. Comments	:	
 * 4. Author	: iticd
 * 5. DateTime	: 2020. 8. 31. 오전 11:19:40
 * 6. History	:
 * -----------------------------------------------------------------
 *	Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2020. 8. 31.		 | iticd			|	최초작성
 * -----------------------------------------------------------------

 */
package com.icignal.systemmanagement.outtable.dto.request;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;

/*
 * 1. 클래스명	: SystemGetEmailHostListReqDto
 * 2. 파일명	: SystemGetEmailHostListReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.dto.request
 * 4. 작성자명	: iticd
 * 5. 작성일자	: 2020. 8. 31.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class SystemGetEmailHostListReqDto extends MKTGridPagingReqDto{
	private String id;
	private String host;
	private String port;
	private String email;
	private String pwd;
	private boolean pwChk;
	private String awsUseYn;
	private String awsName;
	
	
	public String getAwsName() {
		return awsName;
	}
	public void setAwsName(String awsName) {
		this.awsName = awsName;
	}
	public String getAwsUseYn() {
		return awsUseYn;
	}
	public void setAwsUseYn(String awsUseYn) {
		this.awsUseYn = awsUseYn;
	}
	public boolean isPwChk() {
		return pwChk;
	}
	public void setPwChk(boolean pwChk) {
		this.pwChk = pwChk;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	
	
}
