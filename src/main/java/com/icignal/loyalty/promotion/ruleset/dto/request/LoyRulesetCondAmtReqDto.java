package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 룰셋 > 조건-금액 (탭) 목록 조회 Request DTO
 *
 * @name : infavor.loyalty.ruleSet.dto.request.LOYRulesetCondAmtRequestDTO
 * @date : 2018. 7. 16.
 * @author : jk.kim
 * @description :
 */
public class LoyRulesetCondAmtReqDto extends CommonDataAuthReqDto {

    private String id;
    private String rulesetId;
    private String rid;

    private String type;        	//타입
    private String typeNm;        	//타입
    private String targetType;      //대상
    private String startAmt;        //시작금액
    private String endAmt;        	//죵료금액



    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getRulesetId() {
        return rulesetId;
    }
    public void setRulesetId(String rulesetId) {
        this.rulesetId = rulesetId;
    }
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
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
	public String getStartAmt() {
		return startAmt;
	}
	public void setStartAmt(String startAmt) {
		this.startAmt = startAmt;
	}
	public String getEndAmt() {
		return endAmt;
	}
	public void setEndAmt(String endAmt) {
		this.endAmt = endAmt;
	}
	public String getTypeNm() {
		return typeNm;
	}
	public void setTypeNm(String typeNm) {
		this.typeNm = typeNm;
	}



}
