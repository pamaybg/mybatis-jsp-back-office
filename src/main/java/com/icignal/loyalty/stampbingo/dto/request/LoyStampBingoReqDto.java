package com.icignal.loyalty.stampbingo.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LoyStampBingoReqDto extends CommonDataAuthReqDto {
    // 시스템
    private String rid;

    // 코드
    private String StatCd;
    private String PromTypeCd;
    private String JoinTypeCd;
    private String ChnlTypeCd;

    // 기본 필드
    private String stbgNo;
    private String stbgNm;
    private String descText;
    private String validStartDate;
    private String validEndDate;
    private String rowSize;
    private String colSize;
    private String mbrType;
    private String acrlDescText;
    private String bnftDescText;
    private String etcDescText;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getStatCd() {
        return StatCd;
    }

    public void setStatCd(String statCd) {
        StatCd = statCd;
    }

    public String getPromTypeCd() {
        return PromTypeCd;
    }

    public void setPromTypeCd(String promTypeCd) {
        PromTypeCd = promTypeCd;
    }

    public String getJoinTypeCd() {
        return JoinTypeCd;
    }

    public void setJoinTypeCd(String joinTypeCd) {
        JoinTypeCd = joinTypeCd;
    }

    public String getChnlTypeCd() {
        return ChnlTypeCd;
    }

    public void setChnlTypeCd(String chnlTypeCd) {
        ChnlTypeCd = chnlTypeCd;
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

    public String getMbrType() {
        return mbrType;
    }

    public void setMbrType(String mbrType) {
        this.mbrType = mbrType;
    }

    public String getAcrlDescText() {
        return acrlDescText;
    }

    public void setAcrlDescText(String acrlDescText) {
        this.acrlDescText = acrlDescText;
    }

    public String getBnftDescText() {
        return bnftDescText;
    }

    public void setBnftDescText(String bnftDescText) {
        this.bnftDescText = bnftDescText;
    }

    public String getEtcDescText() {
        return etcDescText;
    }

    public void setEtcDescText(String etcDescText) {
        this.etcDescText = etcDescText;
    }
}
