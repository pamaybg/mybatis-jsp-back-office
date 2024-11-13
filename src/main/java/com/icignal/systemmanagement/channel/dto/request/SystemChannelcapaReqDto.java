package com.icignal.systemmanagement.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;


public class SystemChannelcapaReqDto extends CommonDataAuthReqDto {
	
	private String id;           //아이디
	private String type;         //유형
	private String mktChlId;     //마케팅 채널 ID
	private String seq;          //순번
	private String periodType;   //기간구분코드
	private int maxVol;          //최대용량
	private int reserveVol;      //예약용량
	private String description;  //설명
	private String memId;        //회원 아이디
	private boolean changeChk;   //타입 변화 체크
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getMktChlId() {
		return mktChlId;
	}
	public void setMktChlId(String mktChlId) {
		this.mktChlId = mktChlId;
	}
	public String getPeriodType() {
		return periodType;
	}
	public void setPeriodType(String periodType) {
		this.periodType = periodType;
	}
	public int getMaxVol() {
		return maxVol;
	}
	public void setMaxVol(int maxVol) {
		this.maxVol = maxVol;
	}
	public int getReserveVol() {
		return reserveVol;
	}
	public void setReserveVol(int reserveVol) {
		this.reserveVol = reserveVol;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public boolean isChangeChk() {
		return changeChk;
	}
	public void setChangeChk(boolean changeChk) {
		this.changeChk = changeChk;
	}
	
	
	
	
}
