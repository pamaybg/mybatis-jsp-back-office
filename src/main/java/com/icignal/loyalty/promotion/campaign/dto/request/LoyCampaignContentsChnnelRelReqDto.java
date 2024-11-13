package com.icignal.loyalty.promotion.campaign.dto.request;


import org.apache.commons.lang.builder.ToStringBuilder;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class LoyCampaignContentsChnnelRelReqDto extends CommonDataAuthReqDto {
	
    private String dataStatus;
    
    private String id;    //아이디
    private String createDate;    //생성일시
    private String modifyDate;    //수정일시
    
    private String campaignId;    //캠페인 ID
    
    private String contentsId;    //콘텐츠ID
    private String chnnelId;    //채널ID
    private String chnnelTypeCode;    //채널유형코드
    private String urlInfo;    //url정보
    private String attachmentDesc;    //첨부파일설명
    private String treatmentDesc;    //처리설명
    
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public String getContentsId() {
        return contentsId;
    }

    public void setContentsId(String contentsId) {
        this.contentsId = contentsId;
    }

    public String getChnnelId() {
        return chnnelId;
    }

    public void setChnnelId(String chnnelId) {
        this.chnnelId = chnnelId;
    }

    public String getUrlInfo() {
        return urlInfo;
    }

    public void setUrlInfo(String urlInfo) {
        this.urlInfo = urlInfo;
    }

    public String getAttachmentDesc() {
        return attachmentDesc;
    }

    public void setAttachmentDesc(String attachmentDesc) {
        this.attachmentDesc = attachmentDesc;
    }

    public String getTreatmentDesc() {
        return treatmentDesc;
    }

    public void setTreatmentDesc(String treatmentDesc) {
        this.treatmentDesc = treatmentDesc;
    }

    public String getChnnelTypeCode() {
        return chnnelTypeCode;
    }

    public void setChnnelTypeCode(String chnnelTypeCode) {
        this.chnnelTypeCode = chnnelTypeCode;
    }

    public String getDataStatus() {
        return dataStatus;
    }

    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }


}
