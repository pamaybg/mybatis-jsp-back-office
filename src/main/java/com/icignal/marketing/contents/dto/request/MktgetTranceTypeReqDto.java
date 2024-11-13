package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;



/**
 * @name : MKTgetTranceTypeRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전송 정보 조회
 */
public class MktgetTranceTypeReqDto extends MKTBaseReqDto{
	
	private String id; 		//id
	private String accntId; //어카운트 Id
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	
	
	
	
	
	
}
