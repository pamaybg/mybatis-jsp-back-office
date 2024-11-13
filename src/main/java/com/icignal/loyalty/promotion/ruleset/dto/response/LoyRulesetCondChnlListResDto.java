package com.icignal.loyalty.promotion.ruleset.dto.response;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * RuleSet > 조건-채널 (탭) 목록 Response DTO
 *
 * @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetCondChnlListResponseDTO
 * @date : 2018. 07. 16.
 * @author : jk.kim
 * @description :
 */
public class LoyRulesetCondChnlListResDto  extends MKTBaseReqDto{

    private String rid;              //RID
    private String createBy;         //생성자
    private String modifyBy;         //수정자
    private String createDate;       //생성일시
    private String modifyDate;       //수정일시
    private String rulesetId;        //룰셋헤더ID

    private String type;        	//제한 유형
    private String targetType;      //대상
    private String chnlNo;        	//채널 번호
    private String chnlNm;        	//채널 이름
    private String typeNm;        	//제한 유형
    private String targetTypeNm;    //대상


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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTargetType() {
		return targetType;
	}
	public void setTargetType(String targetType) {
		this.targetType = targetType;
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
	public String getTypeNm() {
		return typeNm;
	}
	public void setTypeNm(String typeNm) {
		this.typeNm = typeNm;
	}
	public String getTargetTypeNm() {
		return targetTypeNm;
	}
	public void setTargetTypeNm(String targetTypeNm) {
		this.targetTypeNm = targetTypeNm;
	}





}
