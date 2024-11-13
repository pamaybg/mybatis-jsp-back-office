package com.icignal.kepler.targetGroup.targetSql.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : infavor.kepler.targetGroup.dto.response.KPRTargetSqlDetailResponseDTO
 * @date : 2018. 4. 23.
 * @author : jh.kim
 * @description :
 */
public class KprTargetSqlDetailResDto extends StatusResDto{

    private String targetGroupId;
    private String createByName;
    private String createDate;
    private String segFilterId;
    private String filterSqlCount;
    private String targetGroupName;
    private String targetGroupDesc;
    private String comprGroupTypeCode;
    private String comprGroupTypeName;
    private String comprGroupDtl;
    private String dpCond;
    private String dbInformId;
    private String conDbType;
    private String targetCount;

    private String conIp;
    private String conPort;
    private String conId;
    private String conPassword;
    private String conUrl;
    private String conDbClass;
    private String filterSql;
    private String serviceNm;
    private String extrYn;

    public String getConIp() {
        return conIp;
    }

    public void setConIp(String conIp) {
        this.conIp = conIp;
    }

    public String getConPort() {
        return conPort;
    }

    public void setConPort(String conPort) {
        this.conPort = conPort;
    }

    public String getConId() {
        return conId;
    }

    public void setConId(String conId) {
        this.conId = conId;
    }

    public String getConPassword() {
        return conPassword;
    }

    public void setConPassword(String conPassword) {
        this.conPassword = conPassword;
    }

    public String getConUrl() {
        return conUrl;
    }

    public void setConUrl(String conUrl) {
        this.conUrl = conUrl;
    }

    public String getConDbClass() {
        return conDbClass;
    }

    public void setConDbClass(String conDbClass) {
        this.conDbClass = conDbClass;
    }

    public String getFilterSql() {
        return filterSql;
    }

    public void setFilterSql(String filterSql) {
        this.filterSql = filterSql;
    }

    public String getServiceNm() {
        return serviceNm;
    }

    public void setServiceNm(String serviceNm) {
        this.serviceNm = serviceNm;
    }

    public String getTargetCount() {
        return targetCount;
    }

    public void setTargetCount(String targetCount) {
        this.targetCount = targetCount;
    }

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

    public String getSegFilterId() {
        return segFilterId;
    }

    public void setSegFilterId(String segFilterId) {
        this.segFilterId = segFilterId;
    }

    public String getFilterSqlCount() {
        return filterSqlCount;
    }

    public void setFilterSqlCount(String filterSqlCount) {
        this.filterSqlCount = filterSqlCount;
    }

    public String getTargetGroupName() {
        return targetGroupName;
    }

    public void setTargetGroupName(String targetGroupName) {
        this.targetGroupName = targetGroupName;
    }

    public String getTargetGroupDesc() {
        return targetGroupDesc;
    }

    public void setTargetGroupDesc(String targetGroupDesc) {
        this.targetGroupDesc = targetGroupDesc;
    }

    public String getComprGroupTypeCode() {
        return comprGroupTypeCode;
    }

    public void setComprGroupTypeCode(String comprGroupTypeCode) {
        this.comprGroupTypeCode = comprGroupTypeCode;
    }

    public String getComprGroupTypeName() {
        return comprGroupTypeName;
    }

    public void setComprGroupTypeName(String comprGroupTypeName) {
        this.comprGroupTypeName = comprGroupTypeName;
    }

    public String getComprGroupDtl() {
        return comprGroupDtl;
    }

    public void setComprGroupDtl(String comprGroupDtl) {
        this.comprGroupDtl = comprGroupDtl;
    }

    public String getDpCond() {
        return dpCond;
    }

    public void setDpCond(String dpCond) {
        this.dpCond = dpCond;
    }

    public String getDbInformId() {
        return dbInformId;
    }

    public void setDbInformId(String dbInformId) {
        this.dbInformId = dbInformId;
    }

    public String getConDbType() {
        return conDbType;
    }

    public void setConDbType(String conDbType) {
        this.conDbType = conDbType;
    }

	public String getExtrYn() {
		return extrYn;
	}

	public void setExtrYn(String extrYn) {
		this.extrYn = extrYn;
	}

}
