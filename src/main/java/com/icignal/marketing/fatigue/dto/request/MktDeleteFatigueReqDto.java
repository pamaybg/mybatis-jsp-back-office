package com.icignal.marketing.fatigue.dto.request;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;




/**
 * @name : infavor.marketing.fatigue.dto.request
 * @date : 2015. 11. 23.
 * @author : 안형욱
 * @description : 피로도 삭제 
 */
public class MktDeleteFatigueReqDto extends CommonDataAuthReqDto {
	
	private String id;					//아이디
	private String accountId;			//회사아이디
	private String modifyDate;			//변경일자
	

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccountId() {
		return accountId;
	}
	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	
	
}
