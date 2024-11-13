package com.icignal.loyalty.promotion.campaign.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyCampaignGetConidByCamidResDto extends GridPagingItemResDto{
	
	private String conid;
	private String chnlTypeCd;
	
	public String getConid() {
		return conid;
	}
	public void setConid(String conid) {
		this.conid = conid;
	}
    public String getChnlTypeCd() {
        return chnlTypeCd;
    }
    public void setChnlTypeCd(String chnlTypeCd) {
        this.chnlTypeCd = chnlTypeCd;
    }
}
