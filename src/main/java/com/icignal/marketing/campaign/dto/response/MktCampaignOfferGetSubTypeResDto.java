package com.icignal.marketing.campaign.dto.response;

import com.icignal.common.base.dto.response.StatusResDto;

public class MktCampaignOfferGetSubTypeResDto  extends StatusResDto{
	private String subType;				//오퍼서브타입
	private String pntAccntBigTypeCd;	//대분류
	private String pntAccntMidTypeCd;	//중분류
	private String pntAccntSmlTypeCd;	//소분류
	private String pntAccntDetailTypeCd;	//세분류
	private String pntAccntCustDispTxt;		//안내문구
	
	public String getPntAccntBigTypeCd() {
		return pntAccntBigTypeCd;
	}

	public void setPntAccntBigTypeCd(String pntAccntBigTypeCd) {
		this.pntAccntBigTypeCd = pntAccntBigTypeCd;
	}

	public String getPntAccntMidTypeCd() {
		return pntAccntMidTypeCd;
	}

	public void setPntAccntMidTypeCd(String pntAccntMidTypeCd) {
		this.pntAccntMidTypeCd = pntAccntMidTypeCd;
	}

	public String getPntAccntSmlTypeCd() {
		return pntAccntSmlTypeCd;
	}

	public void setPntAccntSmlTypeCd(String pntAccntSmlTypeCd) {
		this.pntAccntSmlTypeCd = pntAccntSmlTypeCd;
	}

	public String getPntAccntDetailTypeCd() {
		return pntAccntDetailTypeCd;
	}

	public void setPntAccntDetailTypeCd(String pntAccntDetailTypeCd) {
		this.pntAccntDetailTypeCd = pntAccntDetailTypeCd;
	}

	public String getPntAccntCustDispTxt() {
		return pntAccntCustDispTxt;
	}

	public void setPntAccntCustDispTxt(String pntAccntCustDispTxt) {
		this.pntAccntCustDispTxt = pntAccntCustDispTxt;
	}

	public String getSubType() {
		return subType;
	}

	public void setSubType(String subType) {
		this.subType = subType;
	}
	
}
