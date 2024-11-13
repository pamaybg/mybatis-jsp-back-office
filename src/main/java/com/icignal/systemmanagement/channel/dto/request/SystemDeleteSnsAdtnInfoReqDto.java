package com.icignal.systemmanagement.channel.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.GridPagingReqDto;

public class SystemDeleteSnsAdtnInfoReqDto extends GridPagingReqDto {
	
	private String id;                         
	private List<String> listChannelFlowId;   
	private String memId;                     
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public List<String> getListChannelFlowId() {
		return listChannelFlowId;
	}
	public void setListChannelFlowId(List<String> listChannelFlowId) {
		this.listChannelFlowId = listChannelFlowId;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}

	
}
