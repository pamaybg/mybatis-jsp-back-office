package com.icignal.systemmanagement.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : MKTChannelcapaResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 채널 용량 정보 조회
 */
public class SystemAccountResDto extends GridPagingItemResDto{
	private String id;           //아이디
	private String accName;         //유형
	private String accNumber;    //업체 코드
	private String accStatus;    //상태
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccNumber() {
		return accNumber;
	}
	public void setAccNumber(String accNumber) {
		this.accNumber = accNumber;
	}
	public String getAccStatus() {
		return accStatus;
	}
	public void setAccStatus(String accStatus) {
		this.accStatus = accStatus;
	}
	public String getAccName() {
		return accName;
	}
	public void setAccName(String accName) {
		this.accName = accName;
	}
	
	
}
