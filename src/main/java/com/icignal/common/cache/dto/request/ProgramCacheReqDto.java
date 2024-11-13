/**
 * 
 */
package com.icignal.common.cache.dto.request;

/**
 * @name : com.icignal.common.cache.dto.request.ProgramCacheRequestDTO
 * @date : 2020. 1. 30.
 * @author : jh.seo
 * @history : 2018.11.13
 * @since : JDK1.8
 * @see : 
 * @description : 
*/
public class ProgramCacheReqDto {
	private String loginId;
	private String url;
	private String programId;
	private String menuID;
	private String authId;
	private String auth;
	
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getProgramId() {
		return programId;
	}
	public void setProgramId(String programId) {
		this.programId = programId;
	}
	public String getMenuID() {
		return menuID;
	}
	public void setMenuID(String menuID) {
		this.menuID = menuID;
	}
	public String getAuthId() {
		return authId;
	}
	public void setAuthId(String authId) {
		this.authId = authId;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	
	
}
