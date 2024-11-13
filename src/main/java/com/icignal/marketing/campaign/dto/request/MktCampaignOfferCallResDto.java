package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @author : 이경영
 * @name : MktCampaignOfferCallResDto.java
 * @date : 2022. 03. 10.
 * @description : 캠페인 오퍼 요청(데상트)
 */
public class MktCampaignOfferCallResDto extends CommonDataAuthReqDto {
    private String tgtGroupId;
    private String dbId;
    private String conIp;
    private String conPort;
    private String conId;
    private String conPassword;
    private String conUrl;
    private String conDbType;
    private String conDbClass;
    private String filterSql;
    private String filterSqlCount;
    private int tgtCnt;
    private String offerTableName;
    private String offerTypeCodeName;
    private String camId;
    private String camNo;


    public String getTgtGroupId() {
        return tgtGroupId;
    }

    public void setTgtGroupId(String tgtGroupId) {
        this.tgtGroupId = tgtGroupId;
    }

    public String getDbId() {
        return dbId;
    }

    public void setDbId(String dbId) {
        this.dbId = dbId;
    }

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

    public String getConDbType() {
        return conDbType;
    }

    public void setConDbType(String conDbType) {
        this.conDbType = conDbType;
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

    public String getFilterSqlCount() {
        return filterSqlCount;
    }

    public void setFilterSqlCount(String filterSqlCount) {
        this.filterSqlCount = filterSqlCount;
    }

    public int getTgtCnt() {
        return tgtCnt;
    }

    public void setTgtCnt(int tgtCnt) {
        this.tgtCnt = tgtCnt;
    }

    public String getOfferTableName() {
        return offerTableName;
    }

    public void setOfferTableName(String offerTableName) {
        this.offerTableName = offerTableName;
    }

    public String getOfferTypeCodeName() {
        return offerTypeCodeName;
    }

    public void setOfferTypeCodeName(String offerTypeCodeName) {
        this.offerTypeCodeName = offerTypeCodeName;
    }

    public String getCamId() {
        return camId;
    }

    public void setCamId(String camId) {
        this.camId = camId;
    }

    public String getCamNo() {
        return camNo;
    }

    public void setCamNo(String camNo) {
        this.camNo = camNo;
    }
}
