package com.icignal.loyalty.survey.dto.response;/**
 * 1. FileName	: descent-loyalty-marketing-bo
 * 2. Package	: com.icignal.loyalty.survey.dto.response
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-02-18 오후 5:35
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-02-18		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoySurvRsltExcelDnResDto
 * 2. 클래스명: LoySurvRsltExcelDnResDto
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-02-18
 */

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   설문결과 엑셀다운 ResponseDto	
 */
public class LoySurvRsltExcelDnResDto extends GridPagingItemResDto {

    private String ORDER_NO;
	private String CUST_NM;
	private String REG_DATE;
	private String SECT_NO;
	//private String SECT_CONTENTS;
	//private String ITEM_NO;
	private String ITEM_TITLE;
    private String FIELD_TYPE_CD;
    private String ATTR_NO;
	private String ANS_VALUE;
	private String MBR_NO;

    public String getORDER_NO() {
        return ORDER_NO;
    }

    public void setORDER_NO(String ORDER_NO) {
        this.ORDER_NO = ORDER_NO;
    }

    public String getCUST_NM() {
        return CUST_NM;
    }

    public void setCUST_NM(String CUST_NM) {
        this.CUST_NM = CUST_NM;
    }

    public String getREG_DATE() {
        return REG_DATE;
    }

    public void setREG_DATE(String REG_DATE) {
        this.REG_DATE = REG_DATE;
    }

    public String getSECT_NO() {
        return SECT_NO;
    }

    public void setSECT_NO(String SECT_NO) {
        this.SECT_NO = SECT_NO;
    }

    public String getITEM_TITLE() {
        return ITEM_TITLE;
    }

    public void setITEM_TITLE(String ITEM_TITLE) {
        this.ITEM_TITLE = ITEM_TITLE;
    }

    public String getANS_VALUE() {
        return ANS_VALUE;
    }

    public void setANS_VALUE(String ANS_VALUE) {
        this.ANS_VALUE = ANS_VALUE;
    }

    public String getFIELD_TYPE_CD() {
        return FIELD_TYPE_CD;
    }

    public void setFIELD_TYPE_CD(String FIELD_TYPE_CD) {
        this.FIELD_TYPE_CD = FIELD_TYPE_CD;
    }

    public String getATTR_NO() {
        return ATTR_NO;
    }

    public void setATTR_NO(String ATTR_NO) {
        this.ATTR_NO = ATTR_NO;
    }

    public String getMBR_NO() {
        return MBR_NO;
    }

    public void setMBR_NO(String MBR_NO) {
        this.MBR_NO = MBR_NO;
    }
}
