package com.icignal.common.base.dto.request;

import java.io.Serializable;


/**
 * @name : menuFrontRequestDTO 
 * @date : 2015. 10. 07.
 * @author : 안형욱
 */ 

public class MenuFrontReqDto extends BaseReqDto implements Serializable{

    
    /**
     * 
     */
    private static final long serialVersionUID = -2806547177217970109L;
    
    
    private String memId;
	public String appServiceType;
	private boolean loginPage;
	private String applyType;
		
	
	public String getApplyType() {
		return applyType;
	}

	public void setApplyType(String applyType) {
		this.applyType = applyType;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public boolean isLoginPage() {
		return loginPage;
	}

	public void setLoginPage(boolean loginPage) {
		this.loginPage = loginPage;
	}

	public String getAppServiceType() {
		return appServiceType;
	}

	public void setAppServiceType(String appServiceType) {
		this.appServiceType = appServiceType;
	}

	public String getMemId() {
		return memId;
	}

	public void setMemId(String memId) {
		this.memId = memId;
	}
	
	
	
}
