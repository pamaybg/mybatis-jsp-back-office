package com.icignal.loyalty.tiers.tiermaster.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;


/**
 * 
 * @name : infavor.loyalty.membership.tiers.dto.response
 * @date : 2016. 11. 9.
 * @author : 이원준
 * @description : 등급그룹상세 목록조회DTO
 */
@CommCode
public class LoyGetTierupMatrixDtlResDto {
	
	private String rid;     			//RID
	private String ridTierupMatrix;
	
	@MarkName(groupCode="LOY_TIERUP_BASE_CD" , codeField="rsltBasTypeCd")
	private String rsltBasTypeNm;  
	private String rsltBasTypeCd;
	private String sectStartVal;   
	private String sectEndVal;     
	
	
	@MarkName(groupCode="LGC_OPRT_TYPE_CD" , codeField="logicOper")
	private String logicOperNm;    
	private String logicOper; 
	private String frntBrktYn;     
	private String backBrktYn;
	private Integer seq;
	
	@Override
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
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
	public String getRsltBasTypeNm() {
		return rsltBasTypeNm;
	}
	public void setRsltBasTypeNm(String rsltBasTypeNm) {
		this.rsltBasTypeNm = rsltBasTypeNm;
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
	public String getLogicOperNm() {
		return logicOperNm;
	}
	public void setLogicOperNm(String logicOperNm) {
		this.logicOperNm = logicOperNm;
	}
	public String getFrntBrktYn() {
		return frntBrktYn;
	}
	public void setFrntBrktYn(String frntBrktYn) {
		this.frntBrktYn = frntBrktYn;
	}
	public String getBackBrktYn() {
		return backBrktYn;
	}
	public void setBackBrktYn(String backBrktYn) {
		this.backBrktYn = backBrktYn;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	
}