package com.icignal.loyalty.stamp.dto.request;

import java.util.ArrayList;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpStoreUpldRequestDTO
* @date : 2019. 3. 14.
* @author : hy.jun
* @description : 스탬프 적용채널 업로드
*/
public class LoyStmpStoreUpldReqDto extends MKTBaseReqDto {
	private String ridStmp;
	private ArrayList<String> chnlNoList; //업로드할 적용채널코드 목록
	
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public ArrayList<String> getChnlNoList() {
		return chnlNoList;
	}
	public void setChnlNoList(ArrayList<String> chnlNoList) {
		this.chnlNoList = chnlNoList;
	}
}
