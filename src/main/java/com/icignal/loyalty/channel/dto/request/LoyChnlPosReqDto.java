/**
 *
 */
package com.icignal.loyalty.channel.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyChnlPosReqDto
 * 2. 파일명	: LoyChnlPosReqDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.request
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2016. 12. 27.
 */
/**
 * <PRE>
 * 1. 설명
 *		채널 POS DTO
 * </PRE>
 */ 
public class LoyChnlPosReqDto extends CommonDataAuthReqDto {

	/** RID */
	private String rid;

	/** RID_CHNL */
	private String ridChnl;

	/** POS 번호 */
	private String posNo;

	/** 설명 */
	private String desctxt;

	/** 활성 여부 */
	private String activeYn;

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
	 * @return the posNo
	 */
	public String getPosNo() {
		return posNo;
	}

	/**
	 * @param posNo the posNo to set
	 */
	public void setPosNo(String posNo) {
		this.posNo = posNo;
	}

	/**
	 * @return the desctxt
	 */
	public String getDesctxt() {
		return desctxt;
	}

	/**
	 * @param desctxt the desctxt to set
	 */
	public void setDesctxt(String desctxt) {
		this.desctxt = desctxt;
	}

	/**
	 * @return the activeYn
	 */
	public String getActiveYn() {
		return activeYn;
	}

	/**
	 * @param activeYn the activeYn to set
	 */
	public void setActiveYn(String activeYn) {
		this.activeYn = activeYn;
	}



}
