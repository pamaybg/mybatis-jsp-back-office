package com.icignal.marketing.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : MktCampaignListResponseDto.java
 * @date : 2015. 9. 23.
 * @author : 류동균
 * @description : 캠페인 반응정보
 */
public class MktCampaignResponseInfoReqDto extends MKTBaseReqDto {
	
    private String id;
    private String campaignId;    //캠페인 ID
    private String exeInfoItemId;    //실행정보 아이템 ID
    private String responseCode;    //반응코드
    private String responseName;    //반응명
    private String responseCount;   //반응수
    private  String spcfChnlRspnsCd;	//채널코드
	
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

    public String getExeInfoItemId() {
        return exeInfoItemId;
    }

    public void setExeInfoItemId(String exeInfoItemId) {
        this.exeInfoItemId = exeInfoItemId;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

	public String getSpcfChnlRspnsCd() {
		return spcfChnlRspnsCd;
	}

	public void setSpcfChnlRspnsCd(String spcfChnlRspnsCd) {
		this.spcfChnlRspnsCd = spcfChnlRspnsCd;
	}
}
