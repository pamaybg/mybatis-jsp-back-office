package com.icignal.loyalty.promotion.ruleset.dto.response;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * RuleSet > 조건-기타 (탭) 목록 Response DTO
 *
 * @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetCondOtherResponseDTO
 * @date : 2018. 07. 16.
 * @author : jk.kim
 * @description :
 */
public class LoyRulesetCondOtherResDto extends MKTBaseReqDto {

    private String rid;              //RID
    private String createBy;         //생성자
    private String modifyBy;         //수정자
    private String createDate;       //생성일시
    private String modifyDate;       //수정일시
    private String rulesetId;        //룰셋헤더ID

    private String rulsetEtcCd;
    private String rulsetEtcCdNm;
    private String rulsetEtcVal;
    private String type;
    private String typeNm;



	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getRulesetId() {
		return rulesetId;
	}
	public void setRulesetId(String rulesetId) {
		this.rulesetId = rulesetId;
	}
	public String getRulsetEtcCd() {
		return rulsetEtcCd;
	}
	public void setRulsetEtcCd(String rulsetEtcCd) {
		this.rulsetEtcCd = rulsetEtcCd;
	}
	public String getRulsetEtcVal() {
		return rulsetEtcVal;
	}
	public void setRulsetEtcVal(String rulsetEtcVal) {
		this.rulsetEtcVal = rulsetEtcVal;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getRulsetEtcCdNm() {
		return rulsetEtcCdNm;
	}
	public void setRulsetEtcCdNm(String rulsetEtcCdNm) {
		this.rulsetEtcCdNm = rulsetEtcCdNm;
	}
	public String getTypeNm() {
		return typeNm;
	}
	public void setTypeNm(String typeNm) {
		this.typeNm = typeNm;
	}



}
