package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyUGCListResDto extends GridPagingItemResDto{
	private String ridMbr;
	private String rid;
	private String mbrNo;
	
	@Decrypted(masked="custNm")
	private String custNM;
	private String stamp;
	private String win;
	private String status;
	private String total;
	private String tot_stamp;
	
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNM() {
		return custNM;
	}
	public void setCustNM(String custNM) {
		this.custNM = custNM;
	}
	public String getStamp() {
		return stamp;
	}
	public void setStamp(String stamp) {
		this.stamp = stamp;
	}
	public String getWin() {
		return win;
	}
	public void setWin(String win) {
		this.win = win;
	}
	
	public String getRidMbr() {
		return ridMbr;
	}
	public void setRidMbr(String ridMbr) {
		this.ridMbr = ridMbr;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getTot_stamp() {
		return tot_stamp;
	}
	public void setTot_stamp(String tot_stamp) {
		this.tot_stamp = tot_stamp;
	}
	

}
