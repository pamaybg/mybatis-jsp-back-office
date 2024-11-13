package com.icignal.loyalty.promotion.offer.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.marketing.offer.dto.request.MKTOfferDeleteRequestDTO
 * @date : 2017. 11. 20.
 * @author : jh.kim
 * @description : 오퍼 삭제 Request DTO
 */
public class LoyOfferDeleteRequestDTO extends CommonDataAuthReqDto {
    
    private String id; //아이디
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
}
