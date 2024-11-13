package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 타겟그룹 DB 정보
 */
public class KprTargetGroupDBInfoReqDto extends CommonDataAuthReqDto {
	
    private String targetGroupId;   //타겟그룹 아이디
    private String lgcCompId;		//로지컬컴포넌트 아이디
    private String secretNm;		//비밀명

    
    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

	public String getLgcCompId() {
		return lgcCompId;
	}

	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

	public String getSecretNm() {
		return secretNm;
	}

	public void setSecretNm(String secretNm) {
		this.secretNm = secretNm;
	}

	
}
