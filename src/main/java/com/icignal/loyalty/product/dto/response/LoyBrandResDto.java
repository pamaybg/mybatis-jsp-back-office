package com.icignal.loyalty.product.dto.response;/**
 * 1. FileName	: iCIGNAL_LOYALTY_T10_Descente
 * 2. Package	: com.icignal.loyalty.product.dto.response
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-01-05 오후 1:36
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

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   브랜드 ResponseDto	
 */
public class LoyBrandResDto extends StatusResDto {

    private String rid;
    private String brdId;
    private String brdNm;
    private String brdDescTxt;
    private String pgmRid;
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

    public String getBrdDescTxt() {
        return brdDescTxt;
    }

    public void setBrdDescTxt(String brdDescTxt) {
        this.brdDescTxt = brdDescTxt;
    }

    public String getPgmRid() {
        return pgmRid;
    }

    public void setPgmRid(String pgmRid) {
        this.pgmRid = pgmRid;
    }

    public String getPgmNm() {
        return pgmNm;
    }

    public void setPgmNm(String pgmNm) {
        this.pgmNm = pgmNm;
    }
}
