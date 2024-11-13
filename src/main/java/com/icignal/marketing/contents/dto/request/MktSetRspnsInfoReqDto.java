package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class MktSetRspnsInfoReqDto extends CommonDataAuthReqDto{

	private String rspnsId;
	private String rspnsDate;
	private String camRspnsId;
	private String rspnsIdCnt;
	
	private String accessToken;
	private String camId;
	private String postId;
	
	private String memId;
	
	
	public String getRspnsId() {
		return rspnsId;
	}
	public void setRspnsId(String rspnsId) {
		this.rspnsId = rspnsId;
	}
	public String getRspnsDate() {
		return rspnsDate;
	}
	public void setRspnsDate(String rspnsDate) {
		this.rspnsDate = rspnsDate;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getCamRspnsId() {
		return camRspnsId;
	}
	public void setCamRspnsId(String camRspnsId) {
		this.camRspnsId = camRspnsId;
	}
	public String getPostId() {
		return postId;
	}
	public void setPostId(String postId) {
		this.postId = postId;
	}
	public String getAccessToken() {
		return accessToken;
	}
	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}
	public String getCamId() {
		return camId;
	}
	public void setCamId(String camId) {
		this.camId = camId;
	}
	public String getRspnsIdCnt() {
		return rspnsIdCnt;
	}
	public void setRspnsIdCnt(String rspnsIdCnt) {
		this.rspnsIdCnt = rspnsIdCnt;
	}
}
