package com.icignal.systemmanagement.log.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/**
 * @name : infavor.common.log.dto.response.ICNExcelDownloadLogResponseDTO
 * @date : 2017. 6. 7.
 * @author : "dg.ryu"
 * @description : 엑셀 다운로드 로그 Response
 */
@PersonalData
public class SystemExcelDownloadLogResDto extends GridPagingItemResDto{
	private String id;               //아이디
	private String reqDt;            //요청일시
	private String reqTypeCd;        //요청유형코드
	private String reqTypeNm;        //요청유형명
	private String reqUrl;           //요청URL
	private String reqIp;            //요청IP
	private String reqSessnId;       //요청세션아이디
	private String reqLoginId;       //요청로그인아이디
	private String targetId;         //대상아이디    
	private String userRid;			  //사용자RID
	private String userId;			  //사용자아이디
	private String userStatCd;		  //사용자상태코드
	private String userStatNm;		  //사용자상태명
	private String empNm;			  //직원명
	@Decrypted(masked = "email")
	private String email;			  //이메일
	private String divNo;			  //부서코드
	private String divNm;			  //부서명
	private String reqDtlLink;		  //요청 상새 링크
	private String workStatusCd;	  //근무상태코드
	private String workStatusNm;	  //근무상태명
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getReqDt() {
		return reqDt;
	}

	public void setReqDt(String reqDt) {
		this.reqDt = reqDt;
	}

	public String getReqTypeCd() {
		return reqTypeCd;
	}

	public void setReqTypeCd(String reqTypeCd) {
		this.reqTypeCd = reqTypeCd;
	}

	public String getReqTypeNm() {
		return reqTypeNm;
	}

	public void setReqTypeNm(String reqTypeNm) {
		this.reqTypeNm = reqTypeNm;
	}

	public String getReqUrl() {
		return reqUrl;
	}

	public void setReqUrl(String reqUrl) {
		this.reqUrl = reqUrl;
	}

	public String getReqIp() {
		return reqIp;
	}

	public void setReqIp(String reqIp) {
		this.reqIp = reqIp;
	}

	public String getReqSessnId() {
		return reqSessnId;
	}

	public void setReqSessnId(String reqSessnId) {
		this.reqSessnId = reqSessnId;
	}

	public String getReqLoginId() {
		return reqLoginId;
	}

	public void setReqLoginId(String reqLoginId) {
		this.reqLoginId = reqLoginId;
	}

	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
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

	public String getReqDtlLink() {
		return reqDtlLink;
	}

	public void setReqDtlLink(String reqDtlLink) {
		this.reqDtlLink = reqDtlLink;
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
}
