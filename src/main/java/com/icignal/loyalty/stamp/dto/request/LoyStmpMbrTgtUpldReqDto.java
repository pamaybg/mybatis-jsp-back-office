package com.icignal.loyalty.stamp.dto.request;

import java.util.ArrayList;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.loyalty.stamp.dto.request.LOYStmpMbrTgtUpldRequestDTO
* @date : 2019. 4. 22.
* @author : hy.jun
* @description :
*/
public class LoyStmpMbrTgtUpldReqDto extends MKTBaseReqDto {
	private String ridStmp;
	private ArrayList<String> mbrNoList; //업로드할 회원번호 목록
	
	public String getRidStmp() {
		return ridStmp;
	}
	public void setRidStmp(String ridStmp) {
		this.ridStmp = ridStmp;
	}
	public ArrayList<String> getMbrNoList() {
		return mbrNoList;
	}
	public void setMbrNoList(ArrayList<String> mbrNoList) {
		this.mbrNoList = mbrNoList;
	}
}
