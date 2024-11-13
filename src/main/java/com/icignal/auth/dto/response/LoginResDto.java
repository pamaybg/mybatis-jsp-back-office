package com.icignal.auth.dto.response;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : MKTLoginResponseDTO.java
 * @date : 2015. 9. 18.
 * @author : 류동균
 * @description : 로그인
 */
public class LoginResDto extends StatusResDto implements Serializable {

	/**
     *
     */
    private static final long serialVersionUID = -8118221913175612402L;


    private String id;
	//직원 아이디
	private String empId;
	//직원 이름
	private String empName;
	//직원 이메일
	private String empEmail;

	//직원 사번
	private String empNo;

	//조직 아이디
	private String orgId;
	private String orgName;
	private String orgNumber;

	//Account
	private String accountName;
	private String accountNumber;
	private String accountType;

	//다국어 관련 파라미터 추가
	private String lang;

	//Loyalty 프로그램
	private String LoyProgramId;
	private String LoyProgramNm;
	private String LoyProgramNo;

	//부서 아이디
	private String ridDivision;
	
	//비밀번호 정책 관련 - 로그인 5회 실패 시 로그인 제한 남은 시간(분)
	private String remainingTime;

	@JsonIgnore
	private String sessionId;

	private String ip;


    //화면 정보
	private String url;
	private String urlInclude;

	//비밀번호 정책 관련
	private int userPwCnt;
	private String userPwChangeExpDt;

	private String userId;
	
	//첫 로그인 여부 (1:최초로그인)
	private String firstLoginFlag;
	
	//BI Prompt 세팅 관련
	private String branchCode;
	private String stationCode;
	
	//로그인 잠금 일시
	private String userPwLockDate;
	
	//sms인증여부
	private String smsYn;
	
	//관리자이메일
	private String adminEmail;
	private String offerBaseRid;
	
	//마지막로그인한 날자
	private String lastLoginDate;

	private String deviceInfo;
	
    public String getOfferBaseRid() {
		return offerBaseRid;
	}

	public void setOfferBaseRid(String offerBaseRid) {
		this.offerBaseRid = offerBaseRid;
	}

	public String getAdminEmail() {
		return adminEmail;
	}

	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}

	public String getSmsYn() {
		return smsYn;
	}

	public void setSmsYn(String smsYn) {
		this.smsYn = smsYn;
	}

	public String getUserPwLockDate() {
		return userPwLockDate;
	}

	public void setUserPwLockDate(String userPwLockDate) {
		this.userPwLockDate = userPwLockDate;
	}

	public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmpId() {
        return empId;
    }

    public void setEmpId(String empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getLang() {
        return lang;
    }

    public void setLang(String lang) {
        this.lang = lang;
    }

    public String getSessionId() {
        return sessionId;
    }

    public void setSessionId(String sessionId) {
        this.sessionId = sessionId;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

	public String getAccountType() {
		return accountType;
	}

	public void setAccountType(String accountType) {
		this.accountType = accountType;
	}

    public String getOrgNumber() {
        return orgNumber;
    }

    public void setOrgNumber(String orgNumber) {
        this.orgNumber = orgNumber;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

	public String getLoyProgramId() {
		return LoyProgramId;
	}

	public void setLoyProgramId(String LoyProgramId) {
		this.LoyProgramId = LoyProgramId;
	}

	public String getLoyProgramNm() {
		return LoyProgramNm;
	}

	public void setLoyProgramNm(String LoyProgramNm) {
		this.LoyProgramNm = LoyProgramNm;
	}

	public String getLoyProgramNo() {
		return LoyProgramNo;
	}

	public void setLoyProgramNo(String LoyProgramNo) {
		this.LoyProgramNo = LoyProgramNo;
	}

	public String getRidDivision() {
		return ridDivision;
	}

	public void setRidDivision(String ridDivision) {
		this.ridDivision = ridDivision;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getUrlInclude() {
		return urlInclude;
	}

	public void setUrlInclude(String urlInclude) {
		this.urlInclude = urlInclude;
	}

	public int getUserPwCnt() {
		return userPwCnt;
	}

	public void setUserPwCnt(int userPwCnt) {
		this.userPwCnt = userPwCnt;
	}



	public String getUserPwChangeExpDt() {
		return userPwChangeExpDt;
	}

	public void setUserPwChangeExpDt(String userPwChangeExpDt) {
		this.userPwChangeExpDt = userPwChangeExpDt;
	}

	/**
	* @return the userId
	*/
	public String getUserId() {
		return userId;
	}

	/**
	* @param userId the userId to set
	*/
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getFirstLoginFlag() {
		return firstLoginFlag;
	}

	public void setFirstLoginFlag(String firstLoginFlag) {
		this.firstLoginFlag = firstLoginFlag;
	}

	public String getBranchCode() {
		return branchCode;
	}

	public void setBranchCode(String branchCode) {
		this.branchCode = branchCode;
	}

	public String getStationCode() {
		return stationCode;
	}

	public void setStationCode(String stationCode) {
		this.stationCode = stationCode;
	}

	public String getRemainingTime() {
		return remainingTime;
	}

	public void setRemainingTime(String remainingTime) {
		this.remainingTime = remainingTime;
	}

	public String getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public String getDeviceInfo() {
		return deviceInfo;
	}

	public void setDeviceInfo(String deviceInfo) {
		this.deviceInfo = deviceInfo;
	}
}
