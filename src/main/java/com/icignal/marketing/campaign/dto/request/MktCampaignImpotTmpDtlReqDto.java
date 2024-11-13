package com.icignal.marketing.campaign.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

public class MktCampaignImpotTmpDtlReqDto extends MKTBaseReqDto {

    private String id;
    private String camId;
    private String memId;
    private String ridTgtHad;

    private String tmpFilePath;

    private List<MktCampaignImportTmpAddReqDto> memberList; // 회원 목록

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getTmpFilePath() {
        return tmpFilePath;
    }

    public void setTmpFilePath(String tmpFilePath) {
        this.tmpFilePath = tmpFilePath;
    }

    public List<MktCampaignImportTmpAddReqDto> getMemberList() {
        return memberList;
    }

    public void setMemberList(List<MktCampaignImportTmpAddReqDto> memberList) {
        this.memberList = memberList;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCamId() {
        return camId;
    }

    public void setCamId(String camId) {
        this.camId = camId;
    }

    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    public String getRidTgtHad() {
        return ridTgtHad;
    }

    public void setRidTgtHad(String ridTgtHad) {
        this.ridTgtHad = ridTgtHad;
    }

}
