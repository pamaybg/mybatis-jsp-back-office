package com.icignal.loyalty.tiers.tiermaster.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
* @name : infavor.loyalty.membership.tiers.dto.request.LOYTierCondDetailRequestDTO
* @date : 2019. 4. 8.
* @author : hy.jun
* @description :
*/
public class LoyTierCondDetailReqDto extends MKTBaseReqDto {
	private String rid;
	private int seq;
	private String logicOper;
	private int frntBrktYn; 
	private String rsltBasTypeCd;
	private String sectStartVal;
	private int backBrktYn;
	private String ridTier;
	private String type;
	private String saveRid;
	
	
	
	public String getSaveRid() {
		return saveRid;
	}
	public void setSaveRid(String saveRid) {
		this.saveRid = saveRid;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getLogicOper() {
		return logicOper;
	}
	public void setLogicOper(String logicOper) {
		this.logicOper = logicOper;
	}
	public int getFrntBrktYn() {
		return frntBrktYn;
	}
	public void setFrntBrktYn(int frntBrktYn) {
		this.frntBrktYn = frntBrktYn;
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
	public int getBackBrktYn() {
		return backBrktYn;
	}
	public void setBackBrktYn(int backBrktYn) {
		this.backBrktYn = backBrktYn;
	}
	public String getRidTier() {
		return ridTier;
	}
	public void setRidTier(String ridTier) {
		this.ridTier = ridTier;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
