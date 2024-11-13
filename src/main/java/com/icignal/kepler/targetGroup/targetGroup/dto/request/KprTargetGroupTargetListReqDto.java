package com.icignal.kepler.targetGroup.targetGroup.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.targetGroup.dto.request
 * @date : 2016. 7. 21.
 * @author : 류동균
 * @description : 타겟그룹 목록 RequestDTO
 */
public class KprTargetGroupTargetListReqDto extends CommonDataAuthReqDto {

    private String targetGroupId;   //타겟그룹 아이디
    private String type;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

}
