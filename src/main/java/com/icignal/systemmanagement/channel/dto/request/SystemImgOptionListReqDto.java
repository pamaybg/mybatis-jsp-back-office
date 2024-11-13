package com.icignal.systemmanagement.channel.dto.request;

import com.icignal.common.base.dto.request.GridPagingReqDto;

/**
 * @name : MKTChannelRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 채널 정보 조회
 */
public class SystemImgOptionListReqDto extends GridPagingReqDto{
	
	private String mktChlId;     		  //마케팅 채널 아이디

	
	public String getMktChlId() {
		return mktChlId;
	}

	public void setMktChlId(String mktChlId) {
		this.mktChlId = mktChlId;
	}


}
