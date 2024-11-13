package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 룰셋 > 조건-기타 목록 조회 Request DTO
 *
 * @name : infavor.loyalty.ruleSet.dto.request.LOYRulesetCondOtherRequestDTO
 * @date : 2018. 7. 16.
 * @author : jk.kim
 * @description :
 */
public class LoyRulesetCondOtherReqDto extends CommonDataAuthReqDto {

    private String id;
    private String rulesetId;
    private String rid;

    private String rulsetEtcCd;
    private String rulsetEtcVal;
    private String type;
    
    

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

	

}
