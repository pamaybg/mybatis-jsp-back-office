package com.icignal.systemmanagement.apispec.dto.vo;/**
 * 1. FileName	: null.java
 * 2. Package	: iCIGNAL_LOYALTY_T10_Descente
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2021-12-15 오전 10:02
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021-12-15		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: SurvRstListDto
 * 2. 클래스명: SurvRstListDto
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2021-12-15
 */

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   설문 응답정보 데이터 VO
 *
 * RID_SURV_SECT	    설문 영역 RID
 * RID_SURV_ITEM	    설문 아이템 RID
 * RID_SURV_ITEM_ATTR	설문 아이템 속성 RID
 * ANS_VALUE	        아이템 속성값
 */
public class SurvRstListDto {
    private String ridSurvSect;
    private String ridSurvItem;
    private String ridSurvItemAttr;
    private String ansValue;

    public String getRidSurvSect() {
        return ridSurvSect;
    }

    public void setRidSurvSect(String ridSurvSect) {
        this.ridSurvSect = ridSurvSect;
    }

    public String getRidSurvItem() {
        return ridSurvItem;
    }

    public void setRidSurvItem(String ridSurvItem) {
        this.ridSurvItem = ridSurvItem;
    }

    public String getRidSurvItemAttr() {
        return ridSurvItemAttr;
    }

    public void setRidSurvItemAttr(String ridSurvItemAttr) {
        this.ridSurvItemAttr = ridSurvItemAttr;
    }

    public String getAnsValue() {
        return ansValue;
    }

    public void setAnsValue(String ansValue) {
        this.ansValue = ansValue;
    }
}
