package com.icignal.systemmanagement.employee.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;
/**
 * @name : selectEmployeeDetail
 * @date : 2014. 12. 05.
 * @author : 장  용
 * @description : 직원 상세 정보 조회
 */

public class SystemEmployeeDetailReqDto extends MKTBaseReqDto {

	private String id;		//직원 아이디
	private String cipherKey;


	/*
	 * public MKTEmployeeDetailRequestDTO(){ try {
	 * this.setCipherKey(CryptoManager.getCipherKey()); } catch (Exception e) {
	 * LogUtil.error(e); } }
	 */


	public String getCipherKey() {
		return cipherKey;
	}


	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}




	public void setId(String id) {
		this.id = id;
	}




	public String getId() {
		return id;
	}
}
