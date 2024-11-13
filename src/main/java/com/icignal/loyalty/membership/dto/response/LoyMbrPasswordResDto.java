package com.icignal.loyalty.membership.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * @name : infavor.Loyalty.member.mbr.dto.response.LoyMbrPasswordResponseDTO
 * @date : 2017. 7. 18.
 * @author : jh.kim
 * @description : 로얄티 프로그램 회원 비밀번호 관리 Response DTO
 */
public class LoyMbrPasswordResDto extends StatusResDto {
    
    private String pntUsePw;
    private Integer isEmptyPntUsePw;
    
    public Integer getIsEmptyPntUsePw() {
        return isEmptyPntUsePw;
    }
    
    public void setIsEmptyPntUsePw(Integer isEmptyPntUsePw) {
        this.isEmptyPntUsePw = isEmptyPntUsePw;
    }
    
    public String getPntUsePw() {
        return pntUsePw;
    }
    
    public void setPntUsePw(String pntUsePw) {
        this.pntUsePw = pntUsePw;
    }
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
    
}
