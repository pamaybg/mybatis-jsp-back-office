package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlSearchHelpListReqDto
 * 2. 파일명	: LoyChnlSearchHelpListReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.request
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyChnlSearchHelpListReqDto extends CommonDataAuthReqDto {

	private String rid;
	private String chnlNo;
	private String chnlNm;
	private String zipCd;
	private String adrDtl;
	private String hpNo;
	private String reprNm;
	//private String cipherKey;
	private String divNm;
	private String chnlTypeCd;


//    public LoyChannelSearchHelpListReqDto() {
//        try {
//            this.setCipherKey(CryptoManager.getCipherKey());
//        }
//        catch ( Exception e ) {
//            LogUtil.error(e);
//        }
//    }


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

	public String getZipCd() {
		return zipCd;
	}

	public void setZipCd(String zipCd) {
		this.zipCd = zipCd;
	}

	public String getAdrDtl() {
		return adrDtl;
	}

	public void setAdrDtl(String adrDtl) {
		this.adrDtl = adrDtl;
	}

	public String getHpNo() {
		return hpNo;
	}

	public void setHpNo(String hpNo) {
		this.hpNo = hpNo;
	}

	public String getReprNm() {
		return reprNm;
	}

	public void setReprNm(String reprNm) {
		this.reprNm = reprNm;
	}

//	public String getCipherKey() {
//		return cipherKey;
//	}
//
//	public void setCipherKey(String cipherKey) {
//		this.cipherKey = cipherKey;
//	}

	public String getDivNm() {
		return divNm;
	}

	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}

	public String getChnlTypeCd() {
		return chnlTypeCd;
	}

	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}


}
