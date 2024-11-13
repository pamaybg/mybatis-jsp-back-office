package com.icignal.kepler.targetGroup.targetSql.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 타겟SQL 대상자 목록 조회 Request DTO
 *
 * @name : infavor.kepler.targetGroup.dto.request.KPRTargetSqlTargetListRequestDTO
 * @date : 2018. 4. 23.
 * @author : jh.kim
 * @description :
 */
public class KprTargetSqlTargetListReqDto extends CommonDataAuthReqDto {

    private String targetGroupId;   //타겟그룹 아이디
    private String type;
    private String filterSql;
    private String dbInformId;
    private String targetSqlCount;
    private Boolean excelFlag;
    
    
    private List<String> mbrNo;

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

	public List<String> getMbrNo() {
		return mbrNo;
	}

	public void setMbrNo(List<String> mbrNo) {
		this.mbrNo = mbrNo;
	}

	public String getTargetSqlCount() {
		return targetSqlCount;
	}

	public void setTargetSqlCount(String targetSqlCount) {
		this.targetSqlCount = targetSqlCount;
	}

	public Boolean getExcelFlag() {
		return excelFlag;
	}

	public void setExcelFlag(Boolean excelFlag) {
		this.excelFlag = excelFlag;
	}


}
