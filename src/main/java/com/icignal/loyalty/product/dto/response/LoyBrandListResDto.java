package com.icignal.loyalty.product.dto.response;/**
 * 1. FileName	: iCIGNAL_LOYALTY_T10_Descente
 * 2. Package	: com.icignal.loyalty.product.dto.response
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-01-05 오전 10:08
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-01-05		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyBrandResDto
 * 2. 클래스명: LoyBrandResDto
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-01-05
 */

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   브랜드 List ResponseDto
 */
public class LoyBrandListResDto extends GridPagingItemResDto {

    private String rid;
    private String brdId;
    private String brdNm;
    private String brdDescTxt;
    private String createDate;
    private String createBy;
    private String modifyDate;
    private String modifyBy;
    private String ridPgm;
    private String pgmNm;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getBrdId() {
        return brdId;
    }

    public void setBrdId(String brdId) {
        this.brdId = brdId;
    }

    public String getBrdNm() {
        return brdNm;
    }

    public void setBrdNm(String brdNm) {
        this.brdNm = brdNm;
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

    public String getBrdDescTxt() {
        return brdDescTxt;
    }

    public void setBrdDescTxt(String brdDescTxt) {
        this.brdDescTxt = brdDescTxt;
    }

    public String getRidPgm() {
        return ridPgm;
    }

    public void setRidPgm(String ridPgm) {
        this.ridPgm = ridPgm;
    }

    public String getPgmNm() {
        return pgmNm;
    }

    public void setPgmNm(String pgmNm) {
        this.pgmNm = pgmNm;
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
}
