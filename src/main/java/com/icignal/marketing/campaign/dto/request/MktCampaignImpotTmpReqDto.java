package com.icignal.marketing.campaign.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.marketing.common.checker.dto.response.MktCheckerListResDto;

public class MktCampaignImpotTmpReqDto extends CommonDataAuthReqDto {

    private String camId;           // 캠페인ID
    private String addData = "0";   // 추가데이터
    private String copyRidTgtHad;
    private String ridTgtHad;
    private String lgcCompId;

    private String tmpFilePath;

    private List<MktCheckerListResDto> memberList; // 회원 목록

    private List<MktCampaignImportTmpAddReqDto> addMemberList; // 회원 목록

    public String getTmpFilePath() {
        return tmpFilePath;
    }

    public void setTmpFilePath(String tmpFilePath) {
        this.tmpFilePath = tmpFilePath;
    }

    public String getCopyRidTgtHad() {
        return copyRidTgtHad;
    }

    public void setCopyRidTgtHad(String copyRidTgtHad) {
        this.copyRidTgtHad = copyRidTgtHad;
    }

    public String getLgcCompId() {
        return lgcCompId;
    }

    public void setLgcCompId(String lgcCompId) {
        this.lgcCompId = lgcCompId;
    }

    public String getRidTgtHad() {
        return ridTgtHad;
    }

    public void setRidTgtHad(String ridTgtHad) {
        this.ridTgtHad = ridTgtHad;
    }

    public String getAddData() {
        return addData;
    }

    public void setAddData(String addData) {
        this.addData = addData;
    }

    public List<MktCheckerListResDto> getMemberList() {
        return memberList;
    }

    public void setMemberList(List<MktCheckerListResDto> memberList) {
        this.memberList = memberList;
    }

    public String getCamId() {
        return camId;
    }

    public void setCamId(String camId) {
        this.camId = camId;
    }

    public List<MktCampaignImportTmpAddReqDto> getAddMemberList() {
        return addMemberList;
    }

    public void setAddMemberList(List<MktCampaignImportTmpAddReqDto> addMemberList) {
        this.addMemberList = addMemberList;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}
