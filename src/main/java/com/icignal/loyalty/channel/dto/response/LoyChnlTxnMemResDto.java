package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyChnlTxnMemResDto
 * 2. 파일명	: LoyChnlTxnMemResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 10. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@PersonalData
@CommCode
public class LoyChnlTxnMemResDto extends GridPagingItemResDto {
	
    private String mbrNo;
    
	@Decrypted(masked = "custNm")
    private String custNm;
	
	@Decrypted(masked = "webId")
    private String webId;
	
	@Decrypted(masked = "tel")
    private String hhpNo;
	
    private String memDiv;
    private String tierNm;
    private String chnlNm;
    private String ridMbr;
    private String ridChnlMbr;
    
    private String mbrTypeCd;

    @MarkName(groupCode="LOY_MEM_TYPE_CD" , codeField="mbr_TYPE_CD")
    private String mbrTypeCdNm;
    private String mbrStatCd;

    @MarkName(groupCode="LOY_MBR_STAT_CD" , codeField="mbr_STAT_CD")
    private String mbrStatCdNm;
    private String chnlRelTypeCd;
    
    @MarkName(groupCode="LOY_CHNL_REL_TYPE_CD" , codeField="CHNL_rel_TYPE_CD")
    private String chnlRelTypeCdNm;
    private String regDt;
    private String delDt;
    private String latitude;
    private String longitude;
    
    public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getMbrTypeCd() {
        return mbrTypeCd;
    }

    public void setMbrTypeCd(String mbrTypeCd) {
        this.mbrTypeCd = mbrTypeCd;
    }

	public String getWebId() {
		return webId;
	}

	public void setWebId(String webId) {
		this.webId = webId;
	}

	public String getRidChnlMbr() {
		return ridChnlMbr;
	}

	public void setRidChnlMbr(String ridChnlMbr) {
		this.ridChnlMbr = ridChnlMbr;
	}

	public String getMbrTypeCdNm() {
        return mbrTypeCdNm;
    }

    public void setMbrTypeCdNm(String mbrTypeCdNm) {
        this.mbrTypeCdNm = mbrTypeCdNm;
    }

    public String getMbrStatCd() {
        return mbrStatCd;
    }

    public void setMbrStatCd(String mbrStatCd) {
        this.mbrStatCd = mbrStatCd;
    }

    public String getMbrStatCdNm() {
        return mbrStatCdNm;
    }

    public void setMbrStatCdNm(String mbrStatCdNm) {
        this.mbrStatCdNm = mbrStatCdNm;
    }

    public String getChnlRelTypeCd() {
        return chnlRelTypeCd;
    }

    public void setChnlRelTypeCd(String chnlRelTypeCd) {
        this.chnlRelTypeCd = chnlRelTypeCd;
    }

    public String getChnlRelTypeCdNm() {
        return chnlRelTypeCdNm;
    }

    public void setChnlRelTypeCdNm(String chnlRelTypeCdNm) {
        this.chnlRelTypeCdNm = chnlRelTypeCdNm;
    }

    public String getRegDt() {
        return regDt;
    }

    public void setRegDt(String regDt) {
        this.regDt = regDt;
    }

    public String getDelDt() {
        return delDt;
    }

    public void setDelDt(String delDt) {
        this.delDt = delDt;
    }

    public String getMbrNo() {
        return mbrNo;
    }

    public void setMbrNo(String mbrNo) {
        this.mbrNo = mbrNo;
    }

    public String getCustNm() {
        return custNm;
    }

    public void setCustNm(String custNm) {
        this.custNm = custNm;
    }

    public String getHhpNo() {
        return hhpNo;
    }

    public void setHhpNo(String hhpNo) {
        this.hhpNo = hhpNo;
    }

    public String getMemDiv() {
        return memDiv;
    }

    public void setMemDiv(String memDiv) {
        this.memDiv = memDiv;
    }

    public String getTierNm() {
        return tierNm;
    }

    public void setTierNm(String tierNm) {
        this.tierNm = tierNm;
    }

    public String getChnlNm() {
        return chnlNm;
    }

    public void setChnlNm(String chnlNm) {
        this.chnlNm = chnlNm;
    }

    public String getRidMbr() {
        return ridMbr;
    }

    public void setRidMbr(String ridMbr) {
        this.ridMbr = ridMbr;
    }

}
