package com.icignal.loyalty.benefit.point.dto.response;


/**
 * @name : infavor.loyalty.common.dto.response.LOYPurItemListResponseDTO
 * @date : 2017. 6. 29.
 * @author : "jh.kim"
 * @description : 구매이력의 항목 상세 목록 Responser DTO 
 */
public class LoyTransactionNoResDto {
	private String tranNo;
	private String tranDate;
	private String tranTime;
	public String getTranNo() {
		return tranNo;
	}
	public void setTranNo(String tranNo) {
		this.tranNo = tranNo;
	}
	public String getTranDate() {
		return tranDate;
	}
	public void setTranDate(String tranDate) {
		this.tranDate = tranDate;
	}
	public String getTranTime() {
		return tranTime;
	}
	public void setTranTime(String tranTime) {
		this.tranTime = tranTime;
	}
	
	
	
}
