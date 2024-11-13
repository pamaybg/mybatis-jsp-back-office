package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

/*
 * 1. 클래스명	: LoyChnlSearchHelpListResDto
 * 2. 파일명	: LoyChnlSearchHelpListResDto.java
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
public class LoyChnlSearchHelpListResDto extends GridPagingItemResDto{

	private String rid;
	private String chnlNo;
	private String chnlNm;
	private String zipCd;
	private String adrDtl;
	
	@Decrypted(masked = "tel")
	private String hpNo;
	private String reprNm;
	private String bizrNo;
	private String apvRqtInstn;
	private String divNm;
	private String receiptPrintYn;
	private String acrlPsblYn;
	private String usePsblYn;

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

	public String getBizrNo() {
		return bizrNo;
	}

	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}

	public String getApvRqtInstn() {
		return apvRqtInstn;
	}

	public void setApvRqtInstn(String apvRqtInstn) {
		this.apvRqtInstn = apvRqtInstn;
	}

	public String getDivNm() {
		return divNm;
	}

	public void setDivNm(String divNm) {
		this.divNm = divNm;
	}

	public String getReceiptPrintYn() {
		return receiptPrintYn;
	}

	public void setReceiptPrintYn(String receiptPrintYn) {
		this.receiptPrintYn = receiptPrintYn;
	}

	public String getAcrlPsblYn() {
		return acrlPsblYn;
	}

	public void setAcrlPsblYn(String acrlPsblYn) {
		this.acrlPsblYn = acrlPsblYn;
	}

	public String getUsePsblYn() {
		return usePsblYn;
	}

	public void setUsePsblYn(String usePsblYn) {
		this.usePsblYn = usePsblYn;
	}

}
