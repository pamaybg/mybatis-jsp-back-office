package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * @name : MKTCampaignStatusCheckRequestDTO.java
 * @date : 2016. 03. 28.
 * @author : 장용
 * @description : 캠페인 상태 조회
 */
public class MktCampaignStatusCheckReqDto extends MKTBaseReqDto {

    private String camId;
    private boolean useApproval;
    private String type; //MKT/LOY 마케팅과 로얄티 구분

    public String getCamId() {
        return camId;
    }

    public void setCamId(String camId) {
        this.camId = camId;
    }

    public boolean isUseApproval() {
        return useApproval;
    }

    public void setUseApproval(boolean useApproval) {
        this.useApproval = useApproval;
    }

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

}