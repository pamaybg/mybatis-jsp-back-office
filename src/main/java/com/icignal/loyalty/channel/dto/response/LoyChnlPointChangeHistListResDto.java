package com.icignal.loyalty.channel.dto.response;

/*
 * 1. 클래스명	: LoyChnlPointChangeHistListResDto
 * 2. 파일명	: LoyChnlPointChangeHistListResDto.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: 이성원
 * 5. 작성일자	: 2017. 10. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
public class LoyChnlPointChangeHistListResDto {

	private String rid;
	private String startDd;
	private String endDd;
	private String acrlRuleCd;
	private String acrlRuleTypeCd;
	private String adjRuleCd;
	private String adjRuleTypeCd;
	private String createBy;
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getStartDd() {
		return startDd;
	}
	public void setStartDd(String startDd) {
		this.startDd = startDd;
	}
	public String getEndDd() {
		return endDd;
	}
	public void setEndDd(String endDd) {
		this.endDd = endDd;
	}
	public String getAcrlRuleCd() {
		return acrlRuleCd;
	}
	public void setAcrlRuleCd(String acrlRuleCd) {
		this.acrlRuleCd = acrlRuleCd;
	}
	public String getAcrlRuleTypeCd() {
		return acrlRuleTypeCd;
	}
	public void setAcrlRuleTypeCd(String acrlRuleTypeCd) {
		this.acrlRuleTypeCd = acrlRuleTypeCd;
	}
	public String getAdjRuleCd() {
		return adjRuleCd;
	}
	public void setAdjRuleCd(String adjRuleCd) {
		this.adjRuleCd = adjRuleCd;
	}
	public String getAdjRuleTypeCd() {
		return adjRuleTypeCd;
	}
	public void setAdjRuleTypeCd(String adjRuleTypeCd) {
		this.adjRuleTypeCd = adjRuleTypeCd;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	

	

}
