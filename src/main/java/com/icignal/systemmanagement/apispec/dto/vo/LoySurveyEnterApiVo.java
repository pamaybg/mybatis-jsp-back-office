package com.icignal.systemmanagement.apispec.dto.vo;/**
 * 1. FileName	: null.java
 * 2. Package	: iCIGNAL_LOYALTY_T10_Descente
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2021-12-15 오전 9:22
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021-12-15		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoySurveyEnterVo
 * 2. 클래스명: LoySurveyEnterVo
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2021-12-15
 */

import java.util.List;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   SURV_1002 - 설문 응답 정보 저장 VO
 * @P_API_NO VARCHAR(100)  OUTPUT,
 * @P_TR_NO VARCHAR(100)  OUTPUT,
 * @P_CHNL_NO VARCHAR(20)   OUTPUT,
 * @P_PGM_NO VARCHAR(10)   OUTPUT,
 * @P_MBR_NO VARCHAR(20),
 * @P_RID_SURV VARCHAR(32),
 * @P_SURV_RST_LIST AS T_SURV_RST READONLY ,
 * @P_RST VARCHAR(1)    OUTPUT,
 * @P_RST_CD VARCHAR(5)    OUTPUT,
 * @P_RST_MSG VARCHAR(1000) OUTPUT,
 * @P_OFR_FLAG VARCHAR(1)    OUTPUT,
 * @P_SURV_NO VARCHAR(10)   OUTPUT
 */
public class LoySurveyEnterApiVo {
    private String apiNo;
    private String trNo;
    private String chnlNo;
    private String pgmNo;
    private String usrTypeCd;
    private String mbrNo;
    private String ridSurv;
    private List<SurvRstListDto> survRstList;
    private String rst;
    private String rstCd;
    private String rstMsg;
    private String ofrFlag;
    private String survNo;

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

    public List<SurvRstListDto> getSurvRstList() {
        return survRstList;
    }

    public void setSurvRstList(List<SurvRstListDto> survRstList) {
        this.survRstList = survRstList;
    }

    public String getOfrFlag() {
        return ofrFlag;
    }

    public void setOfrFlag(String ofrFlag) {
        this.ofrFlag = ofrFlag;
    }

    public String getSurvNo() {
        return survNo;
    }

    public void setSurvNo(String survNo) {
        this.survNo = survNo;
    }
}
