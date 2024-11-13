package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * 실행 가능 사용자인지 확인 Req Dto
 * 
 * @name : infavor.marketing.campaign.dto.request.MktCampaignExecutableUserReqDto
 * @date : 2018. 1. 22.
 * @author : jh.kim
 * @description :
 */
public class MktCampaignExecutableUserReqDto extends MKTBaseReqDto {
    
    private String camId;       //캠페인 ID
    
    public String getCamId() {
        return camId;
    }
    
    public void setCamId(String camId) {
        this.camId = camId;
    }
    
}
