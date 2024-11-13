package com.icignal.loyalty.stampbingo.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;

@CommCode
public class LoyStampBingoStepResDto extends GridPagingItemResDto {

    // 시스템
    private String rid;
    private String createDate;
    private String createBy;
    private String modifyDate;
    private String modifyBy;

    // 릴레이션
    private String ridOfr;
    private String ofrNm;
    private String ridCompOfr;
    private String compOfrNm;

    // 기본필드
    private String rowNo;
    private String colNo;
    private String title;
    private String titleDesc;
    private String stepJumpYn;
    private String imgCompUrl;
    private String imgWaitUrl;
    private String ofrCnt;
    private String validStDd;

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

    public String getRidOfr() {
        return ridOfr;
    }

    public void setRidOfr(String ridOfr) {
        this.ridOfr = ridOfr;
    }

    public String getOfrNm() {
        return ofrNm;
    }

    public void setOfrNm(String ofrNm) {
        this.ofrNm = ofrNm;
    }

    public String getRidCompOfr() {
        return ridCompOfr;
    }

    public void setRidCompOfr(String ridCompOfr) {
        this.ridCompOfr = ridCompOfr;
    }

    public String getCompOfrNm() {
        return compOfrNm;
    }

    public void setCompOfrNm(String compOfrNm) {
        this.compOfrNm = compOfrNm;
    }

    public String getRowNo() {
        return rowNo;
    }

    public void setRowNo(String rowNo) {
        this.rowNo = rowNo;
    }

    public String getColNo() {
        return colNo;
    }

    public void setColNo(String colNo) {
        this.colNo = colNo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitleDesc() {
        return titleDesc;
    }

    public void setTitleDesc(String titleDesc) {
        this.titleDesc = titleDesc;
    }

    public String getStepJumpYn() {
        return stepJumpYn;
    }

    public void setStepJumpYn(String stepJumpYn) {
        this.stepJumpYn = stepJumpYn;
    }

    public String getImgCompUrl() {
        return imgCompUrl;
    }

    public void setImgCompUrl(String imgCompUrl) {
        this.imgCompUrl = imgCompUrl;
    }

    public String getImgWaitUrl() {
        return imgWaitUrl;
    }

    public void setImgWaitUrl(String imgWaitUrl) {
        this.imgWaitUrl = imgWaitUrl;
    }

    public String getOfrCnt() {
        return ofrCnt;
    }

    public void setOfrCnt(String ofrCnt) {
        this.ofrCnt = ofrCnt;
    }

    public String getValidStDd() {
        return validStDd;
    }

    public void setValidStDd(String validStDd) {
        this.validStDd = validStDd;
    }
}
