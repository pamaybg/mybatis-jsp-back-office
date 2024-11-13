package com.icignal.auth.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/**
 * @name : MKTGetUserIpInfoListResponseDTO.java
 * @date : 2017. 11. 21.
 * @author : jun.lee
 * @description : 로그인 시, 유저 ip 정보 체크
 */
public class UserIpInfoListResDto extends GridPagingItemResDto {

	private String aclType;				/* ip유형 */
	private String accessIpAddr;		/* ip주소 */
	
	
	public String getAclType() {
		return aclType;
	}
	public void setAclType(String aclType) {
		this.aclType = aclType;
	}
	public String getAccessIpAddr() {
		return accessIpAddr;
	}
	public void setAccessIpAddr(String accessIpAddr) {
		this.accessIpAddr = accessIpAddr;
	}
	
}
