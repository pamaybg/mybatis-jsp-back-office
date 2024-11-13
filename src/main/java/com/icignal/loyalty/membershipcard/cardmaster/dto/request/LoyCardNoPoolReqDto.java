package com.icignal.loyalty.membershipcard.cardmaster.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

import java.util.List;
import java.util.Map;

/**
* @name : 
* @date : 2017. 12. 6.
* @author : 
* @description :
*/
public class LoyCardNoPoolReqDto extends CommonDataAuthReqDto {

	private String ridCardKind;
	private Integer cnt;
	
	private String ridTr;
	private String uploadValidCheck;
	private List<Map<String, String>> poolList;
	private String title;
	private String bin;

	public String getRidCardKind() {
		return ridCardKind;
	}

	public void setRidCardKind(String ridCardKind) {
		this.ridCardKind = ridCardKind;
	}

	public Integer getCnt() {
		return cnt;
	}

	public void setCnt(Integer cnt) {
		this.cnt = cnt;
	}

	public List<Map<String, String>> getPoolList() {
		return poolList;
	}

	public void setPoolList(List<Map<String, String>> poolList) {
		this.poolList = poolList;
	}

	public String getRidTr() {
		return ridTr;
	}

	public void setRidTr(String ridTr) {
		this.ridTr = ridTr;
	}

	public String getUploadValidCheck() {
		return uploadValidCheck;
	}

	public void setUploadValidCheck(String uploadValidCheck) {
		this.uploadValidCheck = uploadValidCheck;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getBin() {
		return bin;
	}

	public void setBin(String bin) {
		this.bin = bin;
	}
}
