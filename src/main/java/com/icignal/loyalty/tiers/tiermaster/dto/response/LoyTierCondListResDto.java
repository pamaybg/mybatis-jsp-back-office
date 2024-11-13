package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
* @name : infavor.loyalty.membership.tiers.dto.response.LOYTierCondListResponseDTO
* @date : 2019. 4. 2.
* @author : hy.jun
* @description :
*/

@CommCode
public class LoyTierCondListResDto extends GridPagingItemResDto {
	
	private static final long serialVersionUID = -8544500451904157166L;
	
	private String rid;
	private String tierCd;
	private String tierNm;
	
	@MarkName(groupCode="LOY_TIERUP_STAT_CD" , codeField="tierCdStatCd")
	private String tierCdStatCdNm;
	private String tierCdStatCd;
	private String seqNo;
	private String modifyBy;
	private String modifyDate;
	private String sectStartValStr;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getTierCd() {
		return tierCd;
	}
	public void setTierCd(String tierCd) {
		this.tierCd = tierCd;
	}
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getTierCdStatCdNm() {
		return tierCdStatCdNm;
	}
	public void setTierCdStatCdNm(String tierCdStatCdNm) {
		this.tierCdStatCdNm = tierCdStatCdNm;
	}
	public String getSeqNo() {
		return seqNo;
	}
	public void setSeqNo(String seqNo) {
		this.seqNo = seqNo;
	}
	public String getSectStartValStr() {
		return sectStartValStr;
	}
	public void setSectStartValStr(String sectStartValStr) {
		this.sectStartValStr = sectStartValStr;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getTierCdStatCd() {
		return tierCdStatCd;
	}
	public void setTierCdStatCd(String tierCdStatCd) {
		this.tierCdStatCd = tierCdStatCd;
	}
}
