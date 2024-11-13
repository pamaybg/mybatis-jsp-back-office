package com.icignal.kepler.segment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 로지컬 컴포넌트 DB 정보
 */
public class KprLogicalComponentDBInfoReqDto extends CommonDataAuthReqDto {
	
    private String logicalCompId;   //로지컬 컴포넌트 아이디
    private String secretNm;		//비밀명
    
    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}
	
}
