package com.icignal.systemmanagement.channel.dto.request;

import com.icignal.common.base.dto.request.CommonCondReqDto;

/**
 * @name : MKTChannelListRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 채널 정보 조회
 */
public class SystemChannelDetailReqDto extends CommonCondReqDto{
	private String id;             //아이디
	private String secretNm;	   //서비스명
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSecretNm() {
		return secretNm;
	}
	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	
}
