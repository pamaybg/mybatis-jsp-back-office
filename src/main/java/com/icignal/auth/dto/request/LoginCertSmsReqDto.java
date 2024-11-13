package com.icignal.auth.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

import net.sf.oval.constraint.Length;

public class LoginCertSmsReqDto extends CommonDataAuthReqDto{
	@Length(max = 50)
	private String email;
	@Length(max = 50)
	private String password;
	private String crmRid;
	private String rdmCode;
	private String cipherKey;
	private String userId;
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public LoginCertSmsReqDto() {
	/*	try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }*/
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

	public String getCrmRid() {
		return crmRid;
	}

	public void setCrmRid(String crmRid) {
		this.crmRid = crmRid;
	}

	public String getRdmCode() {
		return rdmCode;
	}

	public void setRdmCode(String rdmCode) {
		this.rdmCode = rdmCode;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}
	
}
