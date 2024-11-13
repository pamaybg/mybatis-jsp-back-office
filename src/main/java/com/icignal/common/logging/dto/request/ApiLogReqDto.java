package com.icignal.common.logging.dto.request;/**
 * 1. FileName	: descent-loyalty-marketing-bo
 * 2. Package	: com.icignal.common.logging.dto.request
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-02-10 오후 1:56
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-02-10		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: ApiLogReqDto
 * 2. 클래스명: ApiLogReqDto
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-02-10
 */

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   API 로그 이력	
 */
public class ApiLogReqDto extends CommonDataAuthReqDto {

    private String apiNo;
    private String msgType;
    private String trNo;
    private String trDt;
    private String chnlNo;
    private String dvcNo;
    private String rst;
    private String rstCd;
    private String rstMsg;
 	private String msg;

    public String getApiNo() {
        return apiNo;
    }

    public void setApiNo(String apiNo) {
        this.apiNo = apiNo;
    }

    public String getMsgType() {
        return msgType;
    }

    public void setMsgType(String msgType) {
        this.msgType = msgType;
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

    public String getChnlNo() {
        return chnlNo;
    }

    public void setChnlNo(String chnlNo) {
        this.chnlNo = chnlNo;
    }

    public String getDvcNo() {
        return dvcNo;
    }

    public void setDvcNo(String dvcNo) {
        this.dvcNo = dvcNo;
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

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
