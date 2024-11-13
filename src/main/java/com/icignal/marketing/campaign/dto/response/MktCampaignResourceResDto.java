package com.icignal.marketing.campaign.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class MktCampaignResourceResDto extends GridPagingItemResDto {
	
	private String id;     //아이디
	private String createBy;     //생성자
	private String modifyBy;     //수정자
	private String createDate;     //생성일시
	private String modifyDate;     //수정일시
	private String accountId;     //Account ID

	private String campaignId;    //캠페인 ID
	
	private List<MktCampaignResourceListResDto> resourceList;
	
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
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

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getCampaignId() {
        return campaignId;
    }

    public void setCampaignId(String campaignId) {
        this.campaignId = campaignId;
    }

    public List<MktCampaignResourceListResDto> getResourceList() {
        return resourceList;
    }

    public void setResourceList(
            List<MktCampaignResourceListResDto> resourceList) {
        this.resourceList = resourceList;
    }

	
}
