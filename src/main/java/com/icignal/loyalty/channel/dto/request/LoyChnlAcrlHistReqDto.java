package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlAcrlHistReqDto
 * 2. 파일명	: LoyChnlAcrlHistReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.request
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 2. 20.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyChnlAcrlHistReqDto extends CommonDataAuthReqDto {
	/** RID */
	private String rid;

	/** RID_CHNL */
	private String ridChnl;

	/** 적립 가능 여부 */
	private String acrlPsblYn;

	/** 적용 일자 */
	private String applyDate;



	/**
	 * @return the rid
	 */
	public String getRid() {
		return rid;
	}
	/**
	 * @param rid the rid to set
	 */
	public void setRid(String rid) {
		this.rid = rid;
	}
	/**
	 * @return the ridChnl
	 */
	public String getRidChnl() {
		return ridChnl;
	}
	/**
	 * @param ridChnl the ridChnl to set
	 */
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	/**
	 * @return the acrlPsblYn
	 */
	public String getAcrlPsblYn() {
		return acrlPsblYn;
	}
	/**
	 * @param acrlPsblYn the acrlPsblYn to set
	 */
	public void setAcrlPsblYn(String acrlPsblYn) {
		this.acrlPsblYn = acrlPsblYn;
	}
	/**
	 * @return the applyDate
	 */
	public String getApplyDate() {
		return applyDate;
	}
	/**
	 * @param applyDate the applyDate to set
	 */
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}



}
