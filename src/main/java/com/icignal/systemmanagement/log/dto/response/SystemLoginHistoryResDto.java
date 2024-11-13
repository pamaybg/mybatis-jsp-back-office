package com.icignal.systemmanagement.log.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: SystemLoginHistoryResDto
 * 2. 파일명	: SystemLoginHistoryResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.log.dto.response
 * 4. 작성자명	: dg.ryu
 * 5. 작성일자	: 2017. 6. 7.
 */
/**
 * <PRE>
 * 1. 설명
 *		로그인 이력 Response
 * </PRE>
 */ 
@PersonalData
@CommCode
public class SystemLoginHistoryResDto extends GridPagingItemResDto{
	private String id;               //아이디
	private String loginDt;       	  //로그인일시
	private String type;             //유형
	private String channel;          //채널
	private String device;           //디바이스
	private String area;             //지역
	private String server;           //서버
	private String targetId;         //대상자아이디
	private String ip;               //IP
	private String sessnId;          //세션아이디
	private String userRid;			  //사용자RID
	private String userId;			  //사용자아이디
	private String userStatCd;		  //사용자상태코드
	
	@MarkName(groupCode = "CRM_USER_STATUS", codeField = "userStatCd")
	private String userStatNm;		  //사용자상태명
	private String empNm;			  //직원명
	
	@Decrypted(masked = "email")
	private String email;			  //이메일
	
	private String divNo;			  //부서코드
	private String divNm;			  //부서명
	private String workStatusCd;	  //근무상태코드
	
	@MarkName(groupCode = "WORK_STATUS", codeField = "workStatusCd")
	private String workStatusNm;	  //근무상태명
	private String loginSuccessYn;	  //로그인 성공여부(y,n)
	
	@MarkName(groupCode = "LOGIN_SUCCESS_YN", codeField = "markNameCd")
	private String markName; 		  //로그인 성공여부 공통코드(성공 실패)
	private String markNameCd;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getLoginDt() {
		return loginDt;
	}

	public void setLoginDt(String loginDt) {
		this.loginDt = loginDt;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getChannel() {
		return channel;
	}

	public void setChannel(String channel) {
		this.channel = channel;
	}

	public String getDevice() {
		return device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getServer() {
		return server;
	}

	public void setServer(String server) {
		this.server = server;
	}

	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getSessnId() {
		return sessnId;
	}

	public void setSessnId(String sessnId) {
		this.sessnId = sessnId;
	}

	public String getUserRid() {
		return userRid;
	}

	public void setUserRid(String userRid) {
		this.userRid = userRid;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserStatCd() {
		return userStatCd;
	}

	public void setUserStatCd(String userStatCd) {
		this.userStatCd = userStatCd;
	}

	public String getUserStatNm() {
		return userStatNm;
	}

	public void setUserStatNm(String userStatNm) {
		this.userStatNm = userStatNm;
	}

	public String getEmpNm() {
		return empNm;
	}

	public void setEmpNm(String empNm) {
		this.empNm = empNm;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDivNo() {
		return divNo;
	}

	public void setDivNo(String divNo) {
		this.divNo = divNo;
	}

	public String getDivNm() {
		return divNm;
	}

	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}

	public String getWorkStatusCd() {
		return workStatusCd;
	}

	public void setWorkStatusCd(String workStatusCd) {
		this.workStatusCd = workStatusCd;
	}

	public String getWorkStatusNm() {
		return workStatusNm;
	}

	public void setWorkStatusNm(String workStatusNm) {
		this.workStatusNm = workStatusNm;
	}

	public String getLoginSuccessYn() {
		return loginSuccessYn;
	}

	public void setLoginSuccessYn(String loginSuccessYn) {
		this.loginSuccessYn = loginSuccessYn;
	}

	public String getMarkName() {
		return markName;
	}

	public void setMarkName(String markName) {
		this.markName = markName;
	}

	public String getMarkNameCd() {
		return markNameCd;
	}

	public void setMarkNameCd(String markNameCd) {
		this.markNameCd = markNameCd;
	}
	
}
