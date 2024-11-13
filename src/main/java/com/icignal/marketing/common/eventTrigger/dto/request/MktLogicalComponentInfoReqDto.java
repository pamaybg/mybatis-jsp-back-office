package com.icignal.marketing.common.eventTrigger.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : ICNLogicalComponentInfoRequestDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 로지컬 컴포넌트 정보
 */
public class MktLogicalComponentInfoReqDto extends MKTBaseReqDto {

	private String lgcCompId;   //로지컬 컴포넌트 아이디
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getLgcCompId() {
		return lgcCompId;
	}

	public void setLgcCompId(String lgcCompId) {
		this.lgcCompId = lgcCompId;
	}

}
