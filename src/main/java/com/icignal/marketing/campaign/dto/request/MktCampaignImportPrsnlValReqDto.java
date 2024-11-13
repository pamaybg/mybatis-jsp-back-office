package com.icignal.marketing.campaign.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * 타겟팅 파일 Import 개인화 필드 조회 Request DTO
 *
 * @name : infavor.marketing.targetingImport.dto.request.MKTTargetingImportPrsnlValRequestDTO
 * @date : 2018. 4. 6.
 * @author : jh.kim
 * @description :
 */
public class MktCampaignImportPrsnlValReqDto extends MKTBaseReqDto {

    private String contsId;
    private String hhpNo;
    private String emailAddr;

    public String getContsId() {
        return contsId;
    }

    public void setContsId(String contsId) {
        this.contsId = contsId;
    }

    public String getHhpNo() {
        return hhpNo;
    }

    public void setHhpNo(String hhpNo) {
        this.hhpNo = hhpNo;
    }

    public String getEmailAddr() {
        return emailAddr;
    }

    public void setEmailAddr(String emailAddr) {
        this.emailAddr = emailAddr;
    }
}
