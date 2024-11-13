package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : infavor.marketing.campaign.dto.request
 * @date : 2016. 11. 16.
 * @author : dg.ryu
 * @description : et 로지컬 컴포넌트 컬럼 목록 ResponseDto
 */
public class MktETLogicalComponentColumnListReqDto extends MKTBaseReqDto {
	
    private String logicalCompId;       //로지컬컴포넌트 아이디
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }


}
