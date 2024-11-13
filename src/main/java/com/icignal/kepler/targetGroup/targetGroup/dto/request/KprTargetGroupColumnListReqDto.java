package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 타겟그룹 컬럼 목록 ResponseDTO
 */
public class KprTargetGroupColumnListReqDto extends CommonDataAuthReqDto {
	
    private String targetGroupId;       //타겟그룹 아이디
    private String serverType;
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

    public String getServerType() {
        return serverType;
    }

    public void setServerType(String serverType) {
        this.serverType = serverType;
    }
}
