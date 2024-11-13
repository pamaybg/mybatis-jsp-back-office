package com.icignal.loyalty.membership.dto.response;/**
 * 1. FileName	: iCIGNAL_LOYALTY_T10_Descente
 * 2. Package	: com.icignal.loyalty.membership.dto.response
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-01-10 오후 5:01
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-01-10		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyMbrSurveyListResDto
 * 2. 클래스명: LoyMbrSurveyListResDto
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-01-10
 */

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   회원 설문 결과 Response Dto
 */
public class LoyMbrSurveyListResDto extends GridPagingItemResDto {
    //회원 설문 탭
    private String rid;
    private String ridMbr;
    private String survNo;
    private String survNm;
    private String validDate;
    private String createDate;
    private String validStartDate;
    private String validEndDate;

    //회원 설문 결과 팝업
    private String sectNo;
    private String itemTItle;
    private String fieldTypeCd;
    private String ansValue;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getRidMbr() {
        return ridMbr;
    }

    public void setRidMbr(String ridMbr) {
        this.ridMbr = ridMbr;
    }

    public String getSurvNo() {
        return survNo;
    }

    public void setSurvNo(String survNo) {
        this.survNo = survNo;
    }

    public String getSurvNm() {
        return survNm;
    }

    public void setSurvNm(String survNm) {
        this.survNm = survNm;
    }

    public String getValidDate() {
        return validDate;
    }

    public void setValidDate(String validDate) {
        this.validDate = validDate;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
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

    public String getSectNo() {
        return sectNo;
    }

    public void setSectNo(String sectNo) {
        this.sectNo = sectNo;
    }

    public String getItemTItle() {
        return itemTItle;
    }

    public void setItemTItle(String itemTItle) {
        this.itemTItle = itemTItle;
    }

    public String getFieldTypeCd() {
        return fieldTypeCd;
    }

    public void setFieldTypeCd(String fieldTypeCd) {
        this.fieldTypeCd = fieldTypeCd;
    }

    public String getAnsValue() {
        return ansValue;
    }

    public void setAnsValue(String ansValue) {
        this.ansValue = ansValue;
    }
}
