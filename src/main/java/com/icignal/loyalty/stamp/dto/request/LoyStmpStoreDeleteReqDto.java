package com.icignal.loyalty.stamp.dto.request;

import java.util.ArrayList;
import java.util.HashMap;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpStoreDeleteRequestDTO
* @date : 2019. 3. 14.
* @author : hy.jun
* @description : 스탬프 적용채널 삭제
*/
public class LoyStmpStoreDeleteReqDto extends MKTBaseReqDto {
	private String ridStmp;
	private ArrayList<HashMap<String,Object>> selRows;
	
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public ArrayList<HashMap<String, Object>> getSelRows() {
		return selRows;
	}
	public void setSelRows(ArrayList<HashMap<String, Object>> selRows) {
		this.selRows = selRows;
	}
}
