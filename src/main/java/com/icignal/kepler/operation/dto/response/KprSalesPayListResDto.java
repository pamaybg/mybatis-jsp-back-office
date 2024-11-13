package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprSalesPayListResDto extends StatusResDto {

	
	private String accntId;
	private String id;
	private String salesId;
	private String payType;
	private Integer payAmt;
	private Integer dcAmt;
	
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSalesId() {
		return salesId;
	}
	public void setSalesId(String salesId) {
		this.salesId = salesId;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public Integer getPayAmt() {
		return payAmt;
	}
	public void setPayAmt(Integer payAmt) {
		this.payAmt = payAmt;
	}
	public Integer getDcAmt() {
		return dcAmt;
	}
	public void setDcAmt(Integer dcAmt) {
		this.dcAmt = dcAmt;
	}
	
}
