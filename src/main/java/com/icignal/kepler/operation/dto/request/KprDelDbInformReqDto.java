package com.icignal.kepler.operation.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


/**
 * @name : infavor.kepler.operation.dto.request
 * @date : 2016. 7. 5.
 * @author : 이원준
 * @description : DB정보 삭제 RequestDTO
 */
public class KprDelDbInformReqDto extends CommonDataAuthReqDto {
	
	private List<String> dbInformId;		//DB정보 아이디
	private String modifyBy;					//수정자 
	private String accountId;   				//어카운트 아이디
	private String secretNm;
	
	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public List<String> getDbInformId() {
		return dbInformId;
	}

	public void setDbInformId(List<String> dbInformId) {
		this.dbInformId = dbInformId;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	

}
