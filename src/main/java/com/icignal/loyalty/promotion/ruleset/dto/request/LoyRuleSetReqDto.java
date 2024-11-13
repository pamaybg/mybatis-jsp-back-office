package com.icignal.loyalty.promotion.ruleset.dto.request;

import java.util.List;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : LOYRuleSetMstRequestDTO.java
 * @date : 2016. 12. 12.
 * @author : dg.ryu
 * @description : ruleSet RequestDTO
 *
 * @변경이력 :
 *      2017. 6. 26. jh.kim. 대상상품 혜택 추가
 */
public class LoyRuleSetReqDto extends CommonDataAuthReqDto {

	private String ridMktCamMst;       	//RID_캠페인마스터
	private String ridMktOfferMst; 		//RID_오퍼마스터

    private LoyRulesetDtlReqDto rulesetDtl;                   // 정보
    private List<LoyRulesetPrvBnfDtlReqDto> rulesetPrvBnfList;// 혜택수량 목록
    private List<LoyRuleSetLimitReq> rulesetLimitPathList; // 구매채널 목록
    private LoyRulesetTranDtlReqDto rulesetTran;              // 거래정보
    private LoyRulesetMbrDtlReqDto rulesetMbr;                // 고객정보
    private LoyRulesetSdayDtlReqDto rulesetSday;              // 기념일

    private String type;               //RULESET 유형
    private String promType;           //프로모션유형
    private String promSubType;        //프로모션하위유형
    private String execType;           //적용방법

    private String ruleProdType;       //대상상품 혜택
    private String prodRId;
    private String newMemYn;		   //신규멤버십회원 여부
    private List<LoyRulesetPymntPolicyListReqDto> rulesetPymntPolicyList;// 지급정책
    private List<LoyRulesetCondProdListReqDto> rulesetCondProdList;// 조건 상품

    private List<LoyRulesetCondChnlListReqDto> rulesetCondChnlList;// 조건 채널

    private List<LoyRulesetCondAmtReqDto> rulesetCondAmtList;// 조건 금액

    private List<LoyRulesetCondOtherReqDto> rulesetCondOtherList;// 조건 기타


    private List<LoyRuleSetProdReqDto> ruleSetProdList;// 대상 상품

    private List<LoyRuleSetLimitReq> ruleSetLimitCardList;// 결제기준

    private List<LoyRuleSetLimitReq> ruleSetLimitPathList;// 대상경로

    private List<LoyRuleSetMstReqDto> ruleSetMstList;// 부여기준
    
    private List<LoyRulesetCondTimeListReqDto> rulesetCondTimeList; //거래시간
    
    private List<LoyRulesetPaymentStandardListReqDto> rulesetPymntStandardList; //결제수단
    
    private List<LoyRulesetSpecificDayListReqDto> rulesetSpecificDayList; //특정일

    private List<LoyRulesetPromProductListReqDto> rulesetPromProductList;//프로모션 상품 목록

    public List<LoyRuleSetLimitReq> getRulesetLimitPathList() {
        return rulesetLimitPathList;
    }

    public void setRulesetLimitPathList(List<LoyRuleSetLimitReq> rulesetLimitPathList) {
        this.rulesetLimitPathList = rulesetLimitPathList;
    }

    public String getRidMktCamMst() {
        return ridMktCamMst;
    }

    public void setRidMktCamMst(String ridMktCamMst) {
        this.ridMktCamMst = ridMktCamMst;
    }

    public LoyRulesetDtlReqDto getRulesetDtl() {
        return rulesetDtl;
    }

    public void setRulesetDtl(LoyRulesetDtlReqDto rulesetDtl) {
        this.rulesetDtl = rulesetDtl;
    }

    public List<LoyRulesetPrvBnfDtlReqDto> getRulesetPrvBnfList() {
        return rulesetPrvBnfList;
    }

    public void setRulesetPrvBnfList(List<LoyRulesetPrvBnfDtlReqDto> rulesetPrvBnfList) {
        this.rulesetPrvBnfList = rulesetPrvBnfList;
    }

    public LoyRulesetTranDtlReqDto getRulesetTran() {
        return rulesetTran;
    }

    public void setRulesetTran(LoyRulesetTranDtlReqDto rulesetTran) {
        this.rulesetTran = rulesetTran;
    }

    public LoyRulesetMbrDtlReqDto getRulesetMbr() {
        return rulesetMbr;
    }

    public void setRulesetMbr(LoyRulesetMbrDtlReqDto rulesetMbr) {
        this.rulesetMbr = rulesetMbr;
    }

    public LoyRulesetSdayDtlReqDto getRulesetSday() {
        return rulesetSday;
    }

    public void setRulesetSday(LoyRulesetSdayDtlReqDto rulesetSday) {
        this.rulesetSday = rulesetSday;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getPromType() {
        return promType;
    }

    public void setPromType(String promType) {
        this.promType = promType;
    }

    public String getPromSubType() {
        return promSubType;
    }

    public void setPromSubType(String promSubType) {
        this.promSubType = promSubType;
    }

    public String getExecType() {
        return execType;
    }

    public void setExecType(String execType) {
        this.execType = execType;
    }

    public String getRuleProdType() {
        return ruleProdType;
    }

    public void setRuleProdType(String ruleProdType) {
        this.ruleProdType = ruleProdType;
    }

	public List<LoyRulesetPymntPolicyListReqDto> getRulesetPymntPolicyList() {
		return rulesetPymntPolicyList;
	}

	public void setRulesetPymntPolicyList(List<LoyRulesetPymntPolicyListReqDto> rulesetPymntPolicyList) {
		this.rulesetPymntPolicyList = rulesetPymntPolicyList;
	}

	public List<LoyRulesetCondProdListReqDto> getRulesetCondProdList() {
		return rulesetCondProdList;
	}

	public void setRulesetCondProdList(List<LoyRulesetCondProdListReqDto> rulesetCondProdList) {
		this.rulesetCondProdList = rulesetCondProdList;
	}

	public List<LoyRulesetCondChnlListReqDto> getRulesetCondChnlList() {
		return rulesetCondChnlList;
	}

	public void setRulesetCondChnlList(List<LoyRulesetCondChnlListReqDto> rulesetCondChnlList) {
		this.rulesetCondChnlList = rulesetCondChnlList;
	}

	public List<LoyRulesetCondAmtReqDto> getRulesetCondAmtList() {
		return rulesetCondAmtList;
	}

	public void setRulesetCondAmtList(List<LoyRulesetCondAmtReqDto> rulesetCondAmtList) {
		this.rulesetCondAmtList = rulesetCondAmtList;
	}

	public List<LoyRulesetCondOtherReqDto> getRulesetCondOtherList() {
		return rulesetCondOtherList;
	}

	public void setRulesetCondOtherList(List<LoyRulesetCondOtherReqDto> rulesetCondOtherList) {
		this.rulesetCondOtherList = rulesetCondOtherList;
	}

	public List<LoyRuleSetProdReqDto> getRuleSetProdList() {
		return ruleSetProdList;
	}

	public void setRuleSetProdList(List<LoyRuleSetProdReqDto> ruleSetProdList) {
		this.ruleSetProdList = ruleSetProdList;
	}

	public List<LoyRuleSetLimitReq> getRuleSetLimitCardList() {
		return ruleSetLimitCardList;
	}

	public void setRuleSetLimitCardList(List<LoyRuleSetLimitReq> ruleSetLimitCardList) {
		this.ruleSetLimitCardList = ruleSetLimitCardList;
	}

	public List<LoyRuleSetLimitReq> getRuleSetLimitPathList() {
		return ruleSetLimitPathList;
	}

	public void setRuleSetLimitPathList(List<LoyRuleSetLimitReq> ruleSetLimitPathList) {
		this.ruleSetLimitPathList = ruleSetLimitPathList;
	}

	public List<LoyRuleSetMstReqDto> getRuleSetMstList() {
		return ruleSetMstList;
	}

	public void setRuleSetMstList(List<LoyRuleSetMstReqDto> ruleSetMstList) {
		this.ruleSetMstList = ruleSetMstList;
	}

	public List<LoyRulesetCondTimeListReqDto> getRulesetCondTimeList() {
		return rulesetCondTimeList;
	}

	public void setRulesetCondTimeList(List<LoyRulesetCondTimeListReqDto> rulesetCondTimeList) {
		this.rulesetCondTimeList = rulesetCondTimeList;
	}

	public List<LoyRulesetPaymentStandardListReqDto> getRulesetPymntStandardList() {
		return rulesetPymntStandardList;
	}

	public void setRulesetPymntStandardList(List<LoyRulesetPaymentStandardListReqDto> rulesetPymntStandardList) {
		this.rulesetPymntStandardList = rulesetPymntStandardList;
	}

	public String getRidMktOfferMst() {
		return ridMktOfferMst;
	}

	public void setRidMktOfferMst(String ridMktOfferMst) {
		this.ridMktOfferMst = ridMktOfferMst;
	}

	public List<LoyRulesetSpecificDayListReqDto> getRulesetSpecificDayList() {
		return rulesetSpecificDayList;
	}

	public void setRulesetSpecificDayList(List<LoyRulesetSpecificDayListReqDto> rulesetSpecificDayList) {
		this.rulesetSpecificDayList = rulesetSpecificDayList;
	}

	public List<LoyRulesetPromProductListReqDto> getRulesetPromProductList() {
		return rulesetPromProductList;
	}

	public void setRulesetPromProductList(List<LoyRulesetPromProductListReqDto> rulesetPromProductList) {
		this.rulesetPromProductList = rulesetPromProductList;
	}

	public String getProdRId() {
		return prodRId;
	}

	public void setProdRId(String prodRId) {
		this.prodRId = prodRId;
	}

	public String getNewMemYn() {
		return newMemYn;
	}

	public void setNewMemYn(String newMemYn) {
		this.newMemYn = newMemYn;
	}





}
