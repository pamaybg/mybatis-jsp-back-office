package com.icignal.marketing.common.checker.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.marketing.common.checker.dto.request
 * @date : 2015. 11. 10.
 * @author : 류동균
 * @description : 
 */
public class MktCheckerReqDto extends CommonDataAuthReqDto {
    
    private String id;
    
    private String channelCode;    //채널코드
    
    private String campaignId;    //캠페인 ID
    
    private String maxRstrtnTmscnt = "0";    //최대 제한 횟수
	
    private List<String> memberList;    //회원 목록
    
    private String fatiExceptYn;	//피로도 제외 여부
    
    private boolean fileUploadFlag;
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public List<String> getMemberList() {
        return memberList;
    }

    public void setMemberList(List<String> memberList) {
        this.memberList = memberList;
    }

    public String getChannelCode() {
        return channelCode;
    }

    public void setChannelCode(String channelCode) {
        this.channelCode = channelCode;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getMaxRstrtnTmscnt() {
        return maxRstrtnTmscnt;
    }

    public void setMaxRstrtnTmscnt(String maxRstrtnTmscnt) {
        this.maxRstrtnTmscnt = maxRstrtnTmscnt;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

	public String getFatiExceptYn() {
		return fatiExceptYn;
	}

	public void setFatiExceptYn(String fatiExceptYn) {
		this.fatiExceptYn = fatiExceptYn;
	}

	public boolean getFileUploadFlag() {
		return fileUploadFlag;
	}

	public void setFileUploadFlag(boolean fileUploadFlag) {
		this.fileUploadFlag = fileUploadFlag;
	}


}
