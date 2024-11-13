package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.BaseReqDto;

import net.sf.oval.constraint.Email;
import net.sf.oval.constraint.Length;
import net.sf.oval.constraint.NotNull;

public class LoginReqDto  extends BaseReqDto {
	
	
	@NotNull
	@Email
	@Length(max = 50)
	private String email;
	@Length(max = 50)
	private String password;
	@Length(max = 50)
    private String empId;
	
	private String memId;
	private String server;
	private String id;
	
	private String historyId;
	
	private String ip;
	private String sessnId;
	
	//비밀번호 정책 관련 - 로그인 실패 여부
	private String loginSuccessYn;
	
	//중복로그인 시 기존 세션 종료 여부 (1:기존세션종료)
	boolean preSessionAbortYn;
	
	private String operBaseRid;
	
	//이중권한체크 skip 사용자 여부   2020.03.11 추가 knlee
	boolean isDoubleAuthCheckPassUser; 
	
	private String snsId;
	
	private String lastLoginDate;

	private boolean policyInfo;
	
	
	public String getSnsId() {
		return snsId;
	}
	public void setSnsId(String snsId) {
		this.snsId = snsId;
	}
	public String getOperBaseRid() {
		return operBaseRid;
	}
	public void setOperBaseRid(String operBaseRid) {
		this.operBaseRid = operBaseRid;
	}
	public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmpId() {
        return empId;
    }
    public void setEmpId(String empId) {
        this.empId = empId;
    }
    public String getMemId() {
        return memId;
    }
    public void setMemId(String memId) {
        this.memId = memId;
    }
    public String getServer() {
        return server;
    }
    public void setServer(String server) {
        this.server = server;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getHistoryId() {
        return historyId;
    }
    public void setHistoryId(String historyId) {
        this.historyId = historyId;
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
	public String getLoginSuccessYn() {
		return loginSuccessYn;
	}
	public void setLoginSuccessYn(String loginSuccessYn) {
		this.loginSuccessYn = loginSuccessYn;
	}
	public boolean isPreSessionAbortYn() {
		return preSessionAbortYn;
	}
	public void setPreSessionAbortYn(boolean preSessionAbortYn) {
		this.preSessionAbortYn = preSessionAbortYn;
	}
	public boolean isPolicyInfo() { return policyInfo; }
	public void setPolicyInfo(boolean policyInfo) { this.policyInfo = policyInfo; }
	/**
	 * @return the isDoubleAuthCheckPassUser
	 */
	public boolean isDoubleAuthCheckPassUser() {
		return isDoubleAuthCheckPassUser;
	}
	/**
	 * @param isDoubleAuthCheckPassUser the isDoubleAuthCheckPassUser to set
	 */
	public void setDoubleAuthCheckPassUser(boolean isDoubleAuthCheckPassUser) {
		this.isDoubleAuthCheckPassUser = isDoubleAuthCheckPassUser;
	}
	public String getLastLoginDate() {
		return lastLoginDate;
	}
	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}
	
}
