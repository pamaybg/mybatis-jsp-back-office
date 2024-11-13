package com.icignal.loyalty.stampbingo.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyStampBingoResDto  extends GridPagingItemResDto {

    // 시스템
    private String rid;
    private String createDate;
    private String createBy;
    private String modifyDate;
    private String modifyBy;

    // 코드
    private String statCd;
    @MarkName(groupCode = "LOY_STMP_STAT_TYPE", codeField = "statCd")
    private String statCdNm;
    private String promTypeCd;
    @MarkName(groupCode = "LOY_STMP_PROM_TYPE", codeField = "promTypeCd")
    private String promTypeCdNm;
    private String joinTypeCd;
    @MarkName(groupCode = "LOY_STMP_JOIN_TYPE", codeField = "joinTypeCd")
    private String joinTypeCdNm;
    private String chnlTypeCd;
    @MarkName(groupCode = "LOY_STMP_CHNL_TYPE", codeField = "chnlTypeCd")
    private String chnlTypeCdNm;
    private String mbrType;
    @MarkName(groupCode = "LOY_STMP_MBR_TYPE", codeField = "mbrType")
    private String mbrTypeNm;

    // 기본 필드
    private String stbgNo;
    private String stbgNm;
    private String descText;
    private String validStartDate;
    private String validEndDate;
    private String rowSize;
    private String colSize;
    private String acrlDescText;
    private String bnftDescText;
    private String etcDescText;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getStatCd() {
        return statCd;
    }

    public void setStatCd(String statCd) {
        this.statCd = statCd;
    }

    public String getStatCdNm() {
        return statCdNm;
    }

    public void setStatCdNm(String statCdNm) {
        this.statCdNm = statCdNm;
    }

    public String getPromTypeCd() {
        return promTypeCd;
    }

    public void setPromTypeCd(String promTypeCd) {
        this.promTypeCd = promTypeCd;
    }

    public String getPromTypeCdNm() {
        return promTypeCdNm;
    }

    public void setPromTypeCdNm(String promTypeCdNm) {
        this.promTypeCdNm = promTypeCdNm;
    }

    public String getJoinTypeCd() {
        return joinTypeCd;
    }

    public void setJoinTypeCd(String joinTypeCd) {
        this.joinTypeCd = joinTypeCd;
    }

    public String getJoinTypeCdNm() {
        return joinTypeCdNm;
    }

    public void setJoinTypeCdNm(String joinTypeCdNm) {
        this.joinTypeCdNm = joinTypeCdNm;
    }

    public String getChnlTypeCd() {
        return chnlTypeCd;
    }

    public void setChnlTypeCd(String chnlTypeCd) {
        this.chnlTypeCd = chnlTypeCd;
    }

    public String getChnlTypeCdNm() {
        return chnlTypeCdNm;
    }

    public void setChnlTypeCdNm(String chnlTypeCdNm) {
        this.chnlTypeCdNm = chnlTypeCdNm;
    }

    public String getMbrType() {
        return mbrType;
    }

    public void setMbrType(String mbrType) {
        this.mbrType = mbrType;
    }

    public String getMbrTypeNm() {
        return mbrTypeNm;
    }

    public void setMbrTypeNm(String mbrTypeNm) {
        this.mbrTypeNm = mbrTypeNm;
    }

    public String getStbgNo() {
        return stbgNo;
    }

    public void setStbgNo(String stbgNo) {
        this.stbgNo = stbgNo;
    }

    public String getStbgNm() {
        return stbgNm;
    }

    public void setStbgNm(String stbgNm) {
        this.stbgNm = stbgNm;
    }

    public String getDescText() {
        return descText;
    }

    public void setDescText(String descText) {
        this.descText = descText;
    }

    public String getValidStartDate() {
        return validStartDate;
    }

    public void setValidStartDate(String validStartDate) {
        this.validStartDate = validStartDate;
    }

    public String getValidEndDate() {
        return validEndDate;
    }

    public void setValidEndDate(String validEndDate) {
        this.validEndDate = validEndDate;
    }

    public String getRowSize() {
        return rowSize;
    }

    public void setRowSize(String rowSize) {
        this.rowSize = rowSize;
    }

    public String getColSize() {
        return colSize;
    }

    public void setColSize(String colSize) {
        this.colSize = colSize;
    }

    public String getAcrlDescText() {
        return acrlDescText;
    }

    public void setAcrlDescText(String acrlDescText) {
        this.acrlDescText = acrlDescText;
    }

    public String getEtcDescText() {
        return etcDescText;
    }

    public void setEtcDescText(String etcDescText) {
        this.etcDescText = etcDescText;
    }

    public String getBnftDescText() {
        return bnftDescText;
    }

    public void setBnftDescText(String bnftDescText) {
        this.bnftDescText = bnftDescText;
    }
}
