package com.icignal.marketing.common.eventTrigger.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : ICNCampaignTargetingResponseDTO.java
 * @date : 2016. 11. 24.
 * @author : dg.ryu
 * @description : 캠페인 타겟팅
 */
public class MktCampaignTargetingResDto extends StatusResDto {

	private String id;     //아이디
    private String camTgtTypeCd;	//캠페인 타겟팅 유형코드
    private String tgtGroupId;		//타겟그룹 아이디
   
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

	public String getCamTgtTypeCd() {
		return camTgtTypeCd;
	}

	public void setCamTgtTypeCd(String camTgtTypeCd) {
		this.camTgtTypeCd = camTgtTypeCd;
	}

	public String getTgtGroupId() {
		return tgtGroupId;
	}

	public void setTgtGroupId(String tgtGroupId) {
		this.tgtGroupId = tgtGroupId;
	}
}
