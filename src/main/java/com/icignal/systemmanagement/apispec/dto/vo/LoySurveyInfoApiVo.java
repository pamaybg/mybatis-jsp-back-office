package com.icignal.systemmanagement.apispec.dto.vo;
/**
 * 1. FileName	: null.java
 * 2. Package	: com.icignal.systemmanagement.apispec.dto.vo.request
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2021-12-13 오후 3:52
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2021-12-13		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명:
 * 2. 클래스명:
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2021-12-13
 */

import java.util.List;

import com.icignal.loyalty.survey.dto.response.LoySurveyItemAttrListResDto;
import com.icignal.loyalty.survey.dto.response.LoySurveyItemListResDto;
import com.icignal.loyalty.survey.dto.response.LoySurveySectionListResDto;

/**
 * PRE
 * 1. 설명
 *      설문 API - SURV_1001, SURV_1002 공용 Dto
 * PRE
 *  SURV_1001 - 설문 조회 및 참여 여부 확인
 * @P_API_NO VARCHAR(100) OUTPUT,
 * @P_TR_NO VARCHAR(100) OUTPUT,
 * @P_CHNL_NO VARCHAR(20) OUTPUT,
 * @P_PGM_NO VARCHAR(10) OUTPUT,
 * @P_MBR_NO VARCHAR(20),
 * @P_RID_SURV VARCHAR(32),
 * @P_RST VARCHAR(1)    OUTPUT,
 * @P_RST_CD VARCHAR(5)    OUTPUT,
 * @P_RST_MSG VARCHAR(1000) OUTPUT,
 * @P_SURV_NM VARCHAR(MAX) OUTPUT,
 * @P_START_MSG VARCHAR(MAX) OUTPUT,
 * @P_END_MSG VARCHAR(MAX) OUTPUT,
 * @P_START_DT VARCHAR(MAX) OUTPUT,
 * @P_END_DT VARCHAR(MAX) OUTPUT
 *
 */
public class LoySurveyInfoApiVo {
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
    private String survNm;
    private String startMsg;
    private String endMsg;
    private String startDt;
    private String endDt;
    private String startImg;
    private String endImg;
    private List<LoySurveySectionListResDto> survSectList;
    private List<LoySurveyItemListResDto> survItemList;
    private List<LoySurveyItemAttrListResDto> survItemAttrList;


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

    public void setRidSurv(String ridSurv) { this.ridSurv = ridSurv; }

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

    public String getSurvNm() {
        return survNm;
    }

    public void setSurvNm(String survNm) {
        this.survNm = survNm;
    }

    public String getStartMsg() {
        return startMsg;
    }

    public void setStartMsg(String startMsg) {
        this.startMsg = startMsg;
    }

    public String getEndMsg() {
        return endMsg;
    }

    public void setEndMsg(String endMsg) { this.endMsg = endMsg; }

    public String getStartDt() {
        return startDt;
    }

    public void setStartDt(String startDt) {
        this.startDt = startDt;
    }

    public String getEndDt() {
        return endDt;
    }

    public void setEndDt(String endDt) {
        this.endDt = endDt;
    }

    public List<LoySurveySectionListResDto> getSurvSectList() {
        return survSectList;
    }

    public void setSurvSectList(List<LoySurveySectionListResDto> survSectList) {
        this.survSectList = survSectList;
    }

    public List<LoySurveyItemListResDto> getSurvItemList() {
        return survItemList;
    }

    public void setSurvItemList(List<LoySurveyItemListResDto> survItemList) {
        this.survItemList = survItemList;
    }

    public List<LoySurveyItemAttrListResDto> getSurvItemAttrList() {
        return survItemAttrList;
    }

    public void setSurvItemAttrList(List<LoySurveyItemAttrListResDto> survItemAttrList) { this.survItemAttrList = survItemAttrList; }

    public String getStartImg() {
        return startImg;
    }

    public void setStartImg(String startImg) {
        this.startImg = startImg;
    }

	public String getEndImg() {
		return endImg;
	}

	public void setEndImg(String endImg) {
		this.endImg = endImg;
	}

}
