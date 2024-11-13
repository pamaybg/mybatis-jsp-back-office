package com.icignal.systemmanagement.apispec.dto.vo;/**
 * 1. FileName	: descent-loyalty-marketing-bo
 * 2. Package	: com.icignal.systemmanagement.apispec.dto.vo
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-02-07 오전 9:40
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-02-07		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoySurveyEnterYnApiVo
 * 2. 클래스명: LoySurveyEnterYnApiVo
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-02-07
 */

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   설문 참여 여부 VO	
 */
public class LoySurveyEnterYnApiVo {
    private String apiNo;
    private String trNo;
    private String chnlNo;
    private String pgmNo;
    private String usrTypeCd;
    private String mbrNo;
    private String ridSurv;
    private String rst;
    private String rstCd;
    private String rstMsg;
    private String usrEnterYn;

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

    public String getChnlNo() {
        return chnlNo;
    }

    public void setChnlNo(String chnlNo) {
        this.chnlNo = chnlNo;
    }

    public String getPgmNo() {
        return pgmNo;
    }

    public void setPgmNo(String pgmNo) {
        this.pgmNo = pgmNo;
    }

    public String getUsrTypeCd() {
        return usrTypeCd;
    }

    public void setUsrTypeCd(String usrTypeCd) {
        this.usrTypeCd = usrTypeCd;
    }

    public String getMbrNo() {
        return mbrNo;
    }

    public void setMbrNo(String mbrNo) {
        this.mbrNo = mbrNo;
    }

    public String getRidSurv() {
        return ridSurv;
    }

    public void setRidSurv(String ridSurv) {
        this.ridSurv = ridSurv;
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

    public String getUsrEnterYn() {
        return usrEnterYn;
    }

    public void setUsrEnterYn(String usrEnterYn) {
        this.usrEnterYn = usrEnterYn;
    }
}
