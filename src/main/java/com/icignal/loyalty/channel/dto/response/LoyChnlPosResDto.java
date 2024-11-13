package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

public class LoyChnlPosResDto extends GridPagingItemResDto {

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


	/** FLAG */
	private String flag;
	/** MOD_NUM */
	private String modNum;
	/** 생성일시 */
	private String createDate;
	/** CREATE_BY */
	private String createBy;
	/** 수정일시 */
	private String modifyDate;
	/** MODIFY_BY */
	private String modifyBy;




	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}

	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}

	/**
	 * @return the modNum
	 */
	public String getModNum() {
		return modNum;
	}

	/**
	 * @param modNum the modNum to set
	 */
	public void setModNum(String modNum) {
		this.modNum = modNum;
	}

	/**
	 * @return the createDate
	 */
	public String getCreateDate() {
		return createDate;
	}

	/**
	 * @param createDate the createDate to set
	 */
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	/**
	 * @return the createBy
	 */
	public String getCreateBy() {
		return createBy;
	}

	/**
	 * @param createBy the createBy to set
	 */
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	/**
	 * @return the modifyDate
	 */
	public String getModifyDate() {
		return modifyDate;
	}

	/**
	 * @param modifyDate the modifyDate to set
	 */
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}

	/**
	 * @return the modifyBy
	 */
	public String getModifyBy() {
		return modifyBy;
	}

	/**
	 * @param modifyBy the modifyBy to set
	 */
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

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
