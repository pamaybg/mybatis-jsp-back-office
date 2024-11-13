package com.icignal.kepler.targetGroup.targetSql.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.targetGroup.dto.request.KPRTargetSqlRequestDTO
 * @date : 2018. 4. 25.
 * @author : jh.kim
 * @description :
 */
public class KprTargetSqlReqDto extends CommonDataAuthReqDto {

    private String targetGroupId;
    private String type;
    private String filterSql;
    private String dbInformId;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getFilterSql() {
        return filterSql;
    }

    public void setFilterSql(String filterSql) {
        this.filterSql = filterSql;
    }

    public String getDbInformId() {
        return dbInformId;
    }

    public void setDbInformId(String dbInformId) {
        this.dbInformId = dbInformId;
    }

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

}
