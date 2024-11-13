package com.icignal.kepler.targetGroup.targetSql.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 대상자 쿼리 DB 정보 조회 Request DTO
 *
 * @name : infavor.kepler.targetGroup.dto.request.KPRTargetSqlDBInfoRequestDTO
 * @date : 2018. 4. 11.
 * @author : jh.kim
 * @description :
 */
public class KprTargetSqlDBInfoReqDto extends CommonDataAuthReqDto {

    String targetGroupId;

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

}
