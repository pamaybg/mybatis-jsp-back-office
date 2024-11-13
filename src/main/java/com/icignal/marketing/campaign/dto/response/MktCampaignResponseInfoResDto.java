package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @name : MktCampaignListResDto.java
 * @date : 2015. 9. 23.
 * @author : 류동균
 * @description : 캠페인 반응정보
 */
public class MktCampaignResponseInfoResDto {
	
    private String id;
    private String responseCode;    //반응코드
    private String responseName;    //반응명
    private String responseCount;   //반응수
	
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(String responseCode) {
        this.responseCode = responseCode;
    }

    public String getResponseName() {
        return responseName;
    }

    public void setResponseName(String responseName) {
        this.responseName = responseName;
    }

    public String getResponseCount() {
        return responseCount;
    }

    public void setResponseCount(String responseCount) {
        this.responseCount = responseCount;
    }
}
