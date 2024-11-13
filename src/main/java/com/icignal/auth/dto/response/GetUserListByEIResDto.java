package com.icignal.auth.dto.response;


import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class GetUserListByEIResDto extends GridPagingItemResDto {
	
	private String rid;
	private String userId;
	private String pwExpireDate;
	private String pgmNm;
	private String userPwCnt;
	
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPwExpireDate() {
		return pwExpireDate;
	}
	public void setPwExpireDate(String pwExpireDate) {
		this.pwExpireDate = pwExpireDate;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getUserPwCnt() {
		return userPwCnt;
	}
	public void setUserPwCnt(String userPwCnt) {
		this.userPwCnt = userPwCnt;
	}
}
