package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrPasswordResponseDTO
 * @date : 2017. 7. 18.
 * @author : jh.kim
 * @description : 로얄티 프로그램 회원 비밀번호 관리 Response DTO
 */
public class LoyEmpSearchHelpResDto extends GridPagingItemResDto {
    
	   private String rid;
	   private String name;
	   private String userId;
	   private String divNm;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getDivNm() {
		return divNm;
	}
	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
	   
}
