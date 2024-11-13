package com.icignal.systemmanagement.apispec.dto.vo;/**
 * 1. FileName	: iCIGNAL_LOYALTY_T10_Descente
 * 2. Package	: com.icignal.systemmanagement.apispec.dto.vo
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-01-04 오후 2:54
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-01-04		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyApiHeaderVo
 * 2. 클래스명: LoyApiHeaderVo
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-01-04
 */

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   API Header VO	
 */
public class LoyApiResultVo {

    private String rst;
    private String rstCd;
    private String rstMsg;

    public String getRst() {
        return rst;
    }

    public void setRst(String rst) {
        this.rst = rst;
    }

    public String getRstCd() {
        return rstCd;
    }

    public void setRstCd(String rstCd) {
        this.rstCd = rstCd;
    }

    public String getRstMsg() {
        return rstMsg;
    }

    public void setRstMsg(String rstMsg) {
        this.rstMsg = rstMsg;
    }
}
