package com.icignal.marketing.campaign.dto.response;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.icignal.common.base.dto.response.StatusResDto;

@JsonIgnoreProperties(ignoreUnknown = true)
public class MktCampaignTgtChnlChkResDto extends StatusResDto {
	
    private String id;    	         // 아이디
    private String exeChnlTypeCd;    // 채널구분
    private String memType;    		 // 고객구분
    
    private List<String> chnlTypeCdList;   // 채널구분목록
    
	public List<String> getChnlTypeCdList() {
        return chnlTypeCdList;
    }
    public void setChnlTypeCdList(List<String> chnlTypeCdList) {
        this.chnlTypeCdList = chnlTypeCdList;
    }
    public String getExeChnlTypeCd() {
		return exeChnlTypeCd;
	}
	public void setExeChnlTypeCd(String exeChnlTypeCd) {
		this.exeChnlTypeCd = exeChnlTypeCd;
	}
	public String getMemType() {
		return memType;
	}
	public void setMemType(String memType) {
		this.memType = memType;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

}
