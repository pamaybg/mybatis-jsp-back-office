package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.request
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹 목록저장DTO
 */
public class LoyEditTierupMatrixDtlReqDto extends MKTBaseReqDto {
	
	private String rid;     			//RID
	private String ridTierupMatrix;
	private String rsltBasTypeCd;
	private String sectStartVal;
	private String sectEndVal;
	private String logicOper;
	private Integer seq;
	private String type;
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getRidTierupMatrix() {
		return ridTierupMatrix;
	}
	public void setRidTierupMatrix(String ridTierupMatrix) {
		this.ridTierupMatrix = ridTierupMatrix;
	}
	public String getRsltBasTypeCd() {
		return rsltBasTypeCd;
	}
	public void setRsltBasTypeCd(String rsltBasTypeCd) {
		this.rsltBasTypeCd = rsltBasTypeCd;
	}
	public String getSectStartVal() {
		return sectStartVal;
	}
	public void setSectStartVal(String sectStartVal) {
		this.sectStartVal = sectStartVal;
	}
	public String getSectEndVal() {
		return sectEndVal;
	}
	public void setSectEndVal(String sectEndVal) {
		this.sectEndVal = sectEndVal;
	}
	public String getLogicOper() {
		return logicOper;
	}
	public void setLogicOper(String logicOper) {
		this.logicOper = logicOper;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}