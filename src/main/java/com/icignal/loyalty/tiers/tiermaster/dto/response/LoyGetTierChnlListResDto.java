package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.response
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급채널상세 목록조회DTO
 */
@CommCode
public class LoyGetTierChnlListResDto extends GridPagingItemResDto {
	
	private String rid;     			//RID
	private String ridChnl;      
	private String ridTierGroup; 
	private String chnlNo;		
	private String chnlNm;		
	private String chnlTypeCd;	
	
	@MarkName(groupCode="LOY_CHNL_TYPE_CD" , codeField="chnlTypeCdNm")
	private String chnlTypeNm;	
	private String chnlTypeCdNm;
	
	private String parRid;		
	private String parChnlNm;	
	private String parRidTop;	
	private String parTopChnlNm;	
	private String parTopYn;
	private String subInclYn;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidChnl() {
		return ridChnl;
	}
	public void setRidChnl(String ridChnl) {
		this.ridChnl = ridChnl;
	}
	public String getRidTierGroup() {
		return ridTierGroup;
	}
	public void setRidTierGroup(String ridTierGroup) {
		this.ridTierGroup = ridTierGroup;
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
	public String getChnlTypeCd() {
		return chnlTypeCd;
	}
	public void setChnlTypeCd(String chnlTypeCd) {
		this.chnlTypeCd = chnlTypeCd;
	}
	public String getChnlTypeNm() {
		return chnlTypeNm;
	}
	public void setChnlTypeNm(String chnlTypeNm) {
		this.chnlTypeNm = chnlTypeNm;
	}
	public String getParRid() {
		return parRid;
	}
	public void setParRid(String parRid) {
		this.parRid = parRid;
	}
	public String getParChnlNm() {
		return parChnlNm;
	}
	public void setParChnlNm(String parChnlNm) {
		this.parChnlNm = parChnlNm;
	}
	public String getParRidTop() {
		return parRidTop;
	}
	public void setParRidTop(String parRidTop) {
		this.parRidTop = parRidTop;
	}
	public String getParTopChnlNm() {
		return parTopChnlNm;
	}
	public void setParTopChnlNm(String parTopChnlNm) {
		this.parTopChnlNm = parTopChnlNm;
	}
	public String getParTopYn() {
		return parTopYn;
	}
	public void setParTopYn(String parTopYn) {
		this.parTopYn = parTopYn;
	}
	public String getSubInclYn() {
		return subInclYn;
	}
	public void setSubInclYn(String subInclYn) {
		this.subInclYn = subInclYn;
	}
	public String getChnlTypeCdNm() {
		return chnlTypeCdNm;
	}
	public void setChnlTypeCdNm(String chnlTypeCdNm) {
		this.chnlTypeCdNm = chnlTypeCdNm;
	}
	
}