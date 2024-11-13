package com.icignal.systemmanagement.apispec.dto.vo;/**
 * 1. FileName	: descent-loyalty-marketing-bo
 * 2. Package	: com.icignal.systemmanagement.apispec.dto.vo
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-04-06 오전 8:27
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-04-06		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyMbrPushHistVo
 * 2. 클래스명: LoyMbrPushHistVo
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-04-06
 */

import java.util.List;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   최근 30일간의 APP 푸시 이력 조회	
 */
public class LoyMbrPushHistVo {
    private String apiNo;
    private String trNo;
    private String trDt;
    private String pgmNo;
    private String chnlNo;
    private String usrId;

    private String rst;
    private String rstCd;
    private String rstMsg;
    private List<LoyHistArrayVo> histArray;

    public String getApiNo() {
        return apiNo;
    }

    public void setApiNo(String apiNo) {
        this.apiNo = apiNo;
    }

    public String getTrNo() {
        return trNo;
    }

    public void setTrNo(String trNo) {
        this.trNo = trNo;
    }

    public String getTrDt() {
        return trDt;
    }

    public void setTrDt(String trDt) {
        this.trDt = trDt;
    }

    public String getPgmNo() {
        return pgmNo;
    }

    public void setPgmNo(String pgmNo) {
        this.pgmNo = pgmNo;
    }

    public String getChnlNo() {
        return chnlNo;
    }

    public void setChnlNo(String chnlNo) {
        this.chnlNo = chnlNo;
    }

    public String getUsrId() {
        return usrId;
    }

    public void setUsrId(String usrId) {
        this.usrId = usrId;
    }

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

    public List<LoyHistArrayVo> getHistArray() {
        return histArray;
    }

    public void setHistArray(List<LoyHistArrayVo> histArray) {
        this.histArray = histArray;
    }
}
