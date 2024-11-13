package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.targetGroup.dto.request
 * @date : 2016. 7. 21.
 * @author : 류동균
 * @description : 타겟 목록 RequestDTO
 */
public class KprTargetListReqDto extends CommonDataAuthReqDto {

    private String logicalCompId;       //로지컬 컴포넌트 아이디
    private String targetGroupId;       //타겟그룹 아이디

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }
}
