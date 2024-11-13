package com.icignal.loyalty.channel.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

@CommCode
public class LoyChnlAcrlHistResDto extends GridPagingItemResDto {
	/** RID */
	private String rid;
	/** RID_CHNL */
	private String ridChnl;
	/** 적립 가능 여부 */
	private String acrlPsblYn;
	/** 적용 일자 */
	private String applyDate;
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

	/** 적립가능여부명 */
	@MarkName(groupCode="LOY_ACRL_PSBL_YN_CD" , codeField="acrl_psbl_yn")
	private String acrlPsblYnNm;


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
	 * @return the acrlPsblYnNm
	 */
	public String getAcrlPsblYnNm() {
		return acrlPsblYnNm;
	}
	/**
	 * @param acrlPsblYnNm the acrlPsblYnNm to set
	 */
	public void setAcrlPsblYnNm(String acrlPsblYnNm) {
		this.acrlPsblYnNm = acrlPsblYnNm;
	}



}
