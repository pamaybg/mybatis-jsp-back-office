package com.icignal.onlineapproval.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;



/**
* @name : infavor.marketing.elapproval.dto.response.MKTAprvTemplateResponseDTO
* @date : 2018. 1. 16.
* @author : 이성원
* @description :
*/
public class AprvTemplateResDto extends GridPagingItemResDto{

	private String title;
	private String content;
	private String automailID; //썬더메일 암호화된 자동메일id
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getAutomailID() {
		return automailID;
	}
	public void setAutomailID(String automailID) {
		this.automailID = automailID;
	}
	
	
	
}
