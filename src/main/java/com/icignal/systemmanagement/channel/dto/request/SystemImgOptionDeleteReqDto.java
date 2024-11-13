package com.icignal.systemmanagement.channel.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.GridPagingReqDto;

/**
 * @name : MKTChannelRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 채널 정보 조회
 */
public class SystemImgOptionDeleteReqDto extends GridPagingReqDto{
	private String id;                         //아이디
	private List<String> listChannelFlowId;   //콘텐츠 삭제 ID 리스트
	private String memId;                     //삭제자
	
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
