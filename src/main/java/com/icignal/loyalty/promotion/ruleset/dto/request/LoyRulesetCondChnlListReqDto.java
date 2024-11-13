package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * 룰셋 > 조건-채널 (탭) 목록 조회 Request DTO
 *
 * @name : infavor.loyalty.ruleSet.dto.request.LOYRulesetCondChnlListRequestDTO
 * @date : 2018. 7. 16.
 * @author : jk.kim
 * @description :
 */
public class LoyRulesetCondChnlListReqDto extends CommonDataAuthReqDto {

    private String id;
    private String rulesetId;
    private String type;        	//제한 유형
    private String targetType;      //대상
    private String chnlNo;        	//채널 번호
    private String chnlNm;        	//채널 이름
    private String typeNm;        	//제한 유형
    private String targetTypeNm;    //대상
    private String rid;

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
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}


}
