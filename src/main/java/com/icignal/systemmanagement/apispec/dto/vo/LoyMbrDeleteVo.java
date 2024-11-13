package com.icignal.systemmanagement.apispec.dto.vo;/**
 * 1. FileName	: iCIGNAL_LOYALTY_T10_Descente
 * 2. Package	: com.icignal.systemmanagement.apispec.dto.vo
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-01-05 오후 4:08
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-01-05		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyMbrDeleteVo
 * 2. 클래스명: LoyMbrDeleteVo
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-01-05
 */

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   회원 탈회 API VO	
 */
public class LoyMbrDeleteVo {

    private String apiNo;
    private String trNo;
    private String trDt;
    private String pgmNo;
    private String chnlNo;
    private String usrId;
    private String reasonCd;
    private String reason;
    private String rst;
    private String rstCd;
    private String rstMsg;

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

    public String getReasonCd() {
        return reasonCd;
    }

    public void setReasonCd(String reasonCd) {
        this.reasonCd = reasonCd;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
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
}
