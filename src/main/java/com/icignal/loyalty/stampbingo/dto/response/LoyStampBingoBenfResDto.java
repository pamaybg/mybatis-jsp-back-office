package com.icignal.loyalty.stampbingo.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyStampBingoBenfResDto extends GridPagingItemResDto {

    // 시스템
    private String rid;
    private String createDate;
    private String createBy;

    // 릴레이션
    private String ridOfr;
    private String ofrNm;

    // 코드
    private String bnfTypeCd;
    @MarkName(groupCode = "LOY_BINGO_BNFT_TYPE", codeField = "bnfTypeCd")
    private String bnfTypeCdNm;

    // 기본필드
    private String title;
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

    public String getBnfTypeCd() {
        return bnfTypeCd;
    }

    public void setBnfTypeCd(String bnfTypeCd) {
        this.bnfTypeCd = bnfTypeCd;
    }

    public String getBnfTypeCdNm() {
        return bnfTypeCdNm;
    }

    public void setBnfTypeCdNm(String bnfTypeCdNm) {
        this.bnfTypeCdNm = bnfTypeCdNm;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
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
