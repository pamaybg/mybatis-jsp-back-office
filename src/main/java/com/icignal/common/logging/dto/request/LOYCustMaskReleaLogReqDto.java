package com.icignal.common.logging.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

public class LOYCustMaskReleaLogReqDto extends CommonDataAuthReqDto {
	/** RID */ 
	private String rid;
	/** 페이지정보 */ 
	private String pageInfo;
	/** 정보유형 */ 
	private String infoType;
	/** 사유설명 */ 
	private String reasDesctxt;
	/** 정보 RID */ 
	private String infoRid;
	
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
	 * @return the pageInfo
	 */
	public String getPageInfo() {
		return pageInfo;
	}
	/**
	 * @param pageInfo the pageInfo to set
	 */
	public void setPageInfo(String pageInfo) {
		this.pageInfo = pageInfo;
	}
	/**
	 * @return the infoType
	 */
	public String getInfoType() {
		return infoType;
	}
	/**
	 * @param infoType the infoType to set
	 */
	public void setInfoType(String infoType) {
		this.infoType = infoType;
	}
	/**
	 * @return the reasDesctxt
	 */
	public String getReasDesctxt() {
		return reasDesctxt;
	}
	/**
	 * @param reasDesctxt the reasDesctxt to set
	 */
	public void setReasDesctxt(String reasDesctxt) {
		this.reasDesctxt = reasDesctxt;
	}
	/**
	 * @return the infoRid
	 */
	public String getInfoRid() {
		return infoRid;
	}
	/**
	 * @param infoRid the infoRid to set
	 */
	public void setInfoRid(String infoRid) {
		this.infoRid = infoRid;
	}
	
	
	

	
	
}
