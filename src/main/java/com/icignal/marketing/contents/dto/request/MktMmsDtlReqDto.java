package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MKTEmailDtlRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 이메일 상세 조회
 */
public class MktMmsDtlReqDto extends CommonDataAuthReqDto{
	private String id;                       //아이디
	private String chnltype;				// 채널 타입
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getChnltype() {
		return chnltype;
	}

	public void setChnltype(String chnltype) {
		this.chnltype = chnltype;
	}
	
}
