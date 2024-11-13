package com.icignal.loyalty.promotion.ruleset.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : LOYLoyChannelListResponseDTO.java
 * @date : 2016. 12. 15.
 * @author : dg.ryu
 * @description : 채널 목록 ResponseDTO
 */
public class LoyChannelListResDto extends GridPagingItemResDto {

	private String rid;              //RID
	private String chnlNo;           //채널 번호
	private String chnlNm;           //채널 명
	private String chnlStatCd;       //채널 상태 코드
	private String chnlStatCdNm;     //채널 상태 코드명
	private String chnlTypeCd;       //채널 유형 코드
	private String chnlTypeCdNm;     //채널 유형 코드명
	private String chnlTypeSubCd;    //채널 유형 서브 코드
	private String chnlTypeSubCdNm;  //채널 유형 서브 코드명
	private String chnlLvlNo;        //채널 레벨 번호
	private String createDate;       //생성일시
	private String createByNm;       //CREATE_BY

    private String ouTypeCd;
    private String ouTypeCdNm;

    private String mbrbsStatusCd;
    private String mbrbsStatusCdNm;

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getMbrbsStatusCd() {
        return mbrbsStatusCd;
    }

    public void setMbrbsStatusCd(String mbrbsStatusCd) {
        this.mbrbsStatusCd = mbrbsStatusCd;
    }

    public String getMbrbsStatusCdNm() {
        return mbrbsStatusCdNm;
    }

    public void setMbrbsStatusCdNm(String mbrbsStatusCdNm) {
        this.mbrbsStatusCdNm = mbrbsStatusCdNm;
    }

	public String getOuTypeCd() {
        return ouTypeCd;
    }

    public void setOuTypeCd(String ouTypeCd) {
        this.ouTypeCd = ouTypeCd;
    }

    public String getOuTypeCdNm() {
        return ouTypeCdNm;
    }

    public void setOuTypeCdNm(String ouTypeCdNm) {
        this.ouTypeCdNm = ouTypeCdNm;
    }

    public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
	}

	public String getChnlNo() {
		return chnlNo;
	}

	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}

	public String getChnlNm() {
		return chnlNm;
	}

	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}

	public String getChnlStatCd() {
		return chnlStatCd;
	}

	public void setChnlStatCd(String chnlStatCd) {
		this.chnlStatCd = chnlStatCd;
	}

	public String getChnlStatCdNm() {
		return chnlStatCdNm;
	}

	public void setChnlStatCdNm(String chnlStatCdNm) {
		this.chnlStatCdNm = chnlStatCdNm;
	}

	public String getChnlTypeCd() {
		return chnlTypeCd;
	}

	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}

	public String getChnlTypeCdNm() {
		return chnlTypeCdNm;
	}

	public void setChnlTypeCdNm(String chnlTypeCdNm) {
		this.chnlTypeCdNm = chnlTypeCdNm;
	}

	public String getChnlTypeSubCd() {
		return chnlTypeSubCd;
	}

	public void setChnlTypeSubCd(String chnlTypeSubCd) {
		this.chnlTypeSubCd = chnlTypeSubCd;
	}

	public String getChnlTypeSubCdNm() {
		return chnlTypeSubCdNm;
	}

	public void setChnlTypeSubCdNm(String chnlTypeSubCdNm) {
		this.chnlTypeSubCdNm = chnlTypeSubCdNm;
	}

	public String getChnlLvlNo() {
		return chnlLvlNo;
	}

	public void setChnlLvlNo(String chnlLvlNo) {
		this.chnlLvlNo = chnlLvlNo;
	}

	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getCreateByNm() {
		return createByNm;
	}

	public void setCreateByNm(String createByNm) {
		this.createByNm = createByNm;
	}


}
