package com.icignal.loyalty.stampbingo.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyStampBingoMbrResDto extends GridPagingItemResDto {

    // 시스템
    private String rid;

    private String custNo;
    @Decrypted(masked = "custNm")
    private String custNm;
    private String currStep;
    private String currStepTitle;
    private String recentDate;
    private String joinDate;
    private String invitMrbYn;
    private String ofrNm;
    private String compDate;
    private String chnlNm;

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getCustNo() {
        return custNo;
    }

    public void setCustNo(String custNo) {
        this.custNo = custNo;
    }

    public String getCustNm() {
        return custNm;
    }

    public void setCustNm(String custNm) {
        this.custNm = custNm;
    }

    public String getCurrStep() {
        return currStep;
    }

    public void setCurrStep(String currStep) {
        this.currStep = currStep;
    }

    public String getCurrStepTitle() {
        return currStepTitle;
    }

    public void setCurrStepTitle(String currStepTitle) {
        this.currStepTitle = currStepTitle;
    }

    public String getRecentDate() {
        return recentDate;
    }

    public void setRecentDate(String recentDate) {
        this.recentDate = recentDate;
    }

    public String getJoinDate() {
        return joinDate;
    }

    public void setJoinDate(String joinDate) {
        this.joinDate = joinDate;
    }

    public String getInvitMrbYn() {
        return invitMrbYn;
    }

    public void setInvitMrbYn(String invitMrbYn) {
        this.invitMrbYn = invitMrbYn;
    }

    public String getOfrNm() {
        return ofrNm;
    }

    public void setOfrNm(String ofrNm) {
        this.ofrNm = ofrNm;
    }

    public String getCompDate() {
        return compDate;
    }

    public void setCompDate(String compDate) {
        this.compDate = compDate;
    }

    public String getChnlNm() {
        return chnlNm;
    }

    public void setChnlNm(String chnlNm) {
        this.chnlNm = chnlNm;
    }
}
