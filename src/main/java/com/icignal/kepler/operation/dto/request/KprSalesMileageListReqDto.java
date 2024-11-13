package com.icignal.kepler.operation.dto.request;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprSalesMileageListReqDto extends StatusResDto {

	private String accntId;
	private String id;
	private String salesId;
	private String mileType;
	private Integer mileAmt;
	private String cardId;
	
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
	public String getMileType() {
		return mileType;
	}
	public void setMileType(String mileType) {
		this.mileType = mileType;
	}
	public Integer getMileAmt() {
		return mileAmt;
	}
	public void setMileAmt(Integer mileAmt) {
		this.mileAmt = mileAmt;
	}
	public String getCardId() {
		return cardId;
	}
	public void setCardId(String cardId) {
		this.cardId = cardId;
	}

}
