package com.icignal.loyalty.event.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyUGCAchResDto extends StatusResDto{

	private String tot_p;		//총 완료 인원
	private String tot_cnt;		//총 완료 스탬프
	private String tot_mbr_cnt;	//참여인원
	private String tot_stmp;	//총 스탬프

	public String getTot_p() {
		return tot_p;
	}
	public void setTot_p(String tot_p) {
		this.tot_p = tot_p;
	}
	public String getTot_cnt() {
		return tot_cnt;
	}
	public void setTot_cnt(String tot_cnt) {
		this.tot_cnt = tot_cnt;
	}
	public String getTot_mbr_cnt() {
		return tot_mbr_cnt;
	}
	public void setTot_mbr_cnt(String tot_mbr_cnt) {
		this.tot_mbr_cnt = tot_mbr_cnt;
	}
	public String getTot_stmp() {
		return tot_stmp;
	}

	public void setTot_stmp(String tot_stmp) {
		this.tot_stmp = tot_stmp;
	}
	
}
