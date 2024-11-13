package com.icignal.kepler.targetGroup.targetSql.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * 타겟SQL 대상자 목록 조회 Response DTO
 *
 * @name : infavor.kepler.targetGroup.dto.response.KPRTargetSqlListResponseDTO
 * @date : 2018. 4. 25.
 * @author : jh.kim
 * @description :
 */
public class KprTargetSqlListResDto extends GridPagingItemResDto {

    private String targetGroupId;
    private String createByName;
    private String createDate;
    private String targetGroupName;
    private String dbInformId;
    private String extrYn;

    public String getTargetGroupId() {
        return targetGroupId;
    }
    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }
    public String getCreateByName() {
        return createByName;
    }
    public void setCreateByName(String createByName) {
        this.createByName = createByName;
    }
    public String getCreateDate() {
        return createDate;
    }
    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }
    public String getTargetGroupName() {
        return targetGroupName;
    }
    public void setTargetGroupName(String targetGroupName) {
        this.targetGroupName = targetGroupName;
    }
    public String getDbInformId() {
        return dbInformId;
    }
    public void setDbInformId(String dbInformId) {
        this.dbInformId = dbInformId;
    }
	public String getExtrYn() {
		return extrYn;
	}
	public void setExtrYn(String extrYn) {
		this.extrYn = extrYn;
	}

}
