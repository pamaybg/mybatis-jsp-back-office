package com.icignal.marketing.contents.dto.response;

public class MktConvertDateToUnixTimestampResDto {
	
	private long result;
	private String reservedDate;
	
	
	public long getResult() {
		return result;
	}
	public void setResult(long result) {
		this.result = result;
	}
	public String getReservedDate() {
		return reservedDate;
	}
	public void setReservedDate(String reservedDate) {
		this.reservedDate = reservedDate;
	}
}
