package com.icignal.loyalty.promotion.ruleset.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : LOYLoyChannelListRequestDTO.java
 * @date : 2016. 12. 15.
 * @author : dg.ryu
 * @description : 채널 목록 RequestDTO
 */
public class LoyChannelListReqDto extends CommonDataAuthReqDto {
	
	private String chnlTypeCd;		//채널유형
	private String chnlTypeSubCd;	//채널하위유형

    private String ouTypeCe;        //가맹점유형
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getOuTypeCe() {
        return ouTypeCe;
    }

    public void setOuTypeCe(String ouTypeCe) {
        this.ouTypeCe = ouTypeCe;
    }

    public String getChnlTypeCd() {
		return chnlTypeCd;
	}

	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}

	public String getChnlTypeSubCd() {
		return chnlTypeSubCd;
	}

	public void setChnlTypeSubCd(String chnlTypeSubCd) {
		this.chnlTypeSubCd = chnlTypeSubCd;
	}
}
