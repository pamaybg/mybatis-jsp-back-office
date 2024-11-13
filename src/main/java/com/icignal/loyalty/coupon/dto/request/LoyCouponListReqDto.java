package com.icignal.loyalty.coupon.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyCouponListReqDto extends CommonDataAuthReqDto {
	
	private String rid;
	private String searchCondIsYN;
	

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getSearchCondIsYN() {
		return searchCondIsYN;
	}

	public void setSearchCondIsYN(String searchCondIsYN) {
		this.searchCondIsYN = searchCondIsYN;
	}
	
	
	
}
