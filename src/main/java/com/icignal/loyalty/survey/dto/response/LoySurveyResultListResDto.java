package com.icignal.loyalty.survey.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.common.excel.annotations.ExcelField;
import com.icignal.common.excel.annotations.ExcelHeader;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
@ExcelHeader
public class LoySurveyResultListResDto extends GridPagingItemResDto {

    @ExcelField(headerName = "구간 번호")
    private Integer sectionNo;
    @ExcelField(headerName = "문항 번호")
    private Integer itemNo;
    private Integer itemAttrNo;
    @ExcelField(headerName = "문항 제목")
    private String itemTitle;
    private String fieldTypeCode;
    @ExcelField(headerName = "유형")
    @MarkName(groupCode = "LOY_SURV_FIELD_CD", codeField = "fieldTypeCode")
    private String fieldTypeCodeName;
    @ExcelField(headerName = "응답 유형")
    private String answerValue;
    @ExcelField(headerName = "응답자 수")
    private Integer answerCount;

    private String regDate;
    private String custNm;
    private String attrNo;
    private String custNo;
    private String pageNo;


    public Integer getSectionNo() {
        return sectionNo;
    }

    public void setSectionNo(Integer sectionNo) {
        this.sectionNo = sectionNo;
    }

    public Integer getItemNo() {
        return itemNo;
    }

    public void setItemNo(Integer itemNo) {
        this.itemNo = itemNo;
    }

    public Integer getItemAttrNo() {
        return itemAttrNo;
    }

    public void setItemAttrNo(Integer itemAttrNo) {
        this.itemAttrNo = itemAttrNo;
    }

    public String getItemTitle() {
        return itemTitle;
    }

    public void setItemTitle(String itemTitle) {
        this.itemTitle = itemTitle;
    }

    public String getFieldTypeCode() {
        return fieldTypeCode;
    }

    public void setFieldTypeCode(String fieldTypeCode) {
        this.fieldTypeCode = fieldTypeCode;
    }

    public String getFieldTypeCodeName() {
        return fieldTypeCodeName;
    }

    public void setFieldTypeCodeName(String fieldTypeCodeName) {
        this.fieldTypeCodeName = fieldTypeCodeName;
    }

    public String getAnswerValue() {
        return answerValue;
    }

    public void setAnswerValue(String answerValue) {
        this.answerValue = answerValue;
    }

    public Integer getAnswerCount() {
        return answerCount;
    }

    public void setAnswerCount(Integer answerCount) {
        this.answerCount = answerCount;
    }

    public String getRegDate() {return regDate;}

    public void setRegDate(String regDate) {this.regDate = regDate;}

    public String getCustNm() {return custNm;}

    public void setCustNm(String custNm) {this.custNm = custNm;}

    public String getAttrNo() {return attrNo;}

    public void setAttrNo(String attrNo) {this.attrNo = attrNo;}

    public String getCustNo() {return custNo;}

    public void setCustNo(String custNo) {this.custNo = custNo;}

    public String getPageNo() {return pageNo;}

    public void setPageNo(String pageNo) {this.pageNo = pageNo;}
}