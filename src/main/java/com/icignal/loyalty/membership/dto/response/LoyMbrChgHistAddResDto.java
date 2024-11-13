package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class LoyMbrChgHistAddResDto extends StatusResDto {

    String rsltMsg;
    String resultFlg;

    public String getRsltMsg() {
        return rsltMsg;
    }

    public void setRsltMsg(String rsltMsg) {
        this.rsltMsg = rsltMsg;
    }

    public String getResultFlg() {
        return resultFlg;
    }

    public void setResultFlg(String resultFlg) {
        this.resultFlg = resultFlg;
    }

}
