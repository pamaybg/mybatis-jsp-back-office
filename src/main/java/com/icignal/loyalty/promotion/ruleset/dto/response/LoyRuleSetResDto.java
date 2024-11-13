package com.icignal.loyalty.promotion.ruleset.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/**
 * @name : LOYRuleSetMstRequestDTO.java
 * @date : 2016. 12. 12.
 * @author : dg.ryu
 * @description : ruleSet ResponseDTO
 */
public class LoyRuleSetResDto extends GridPagingItemResDto {

    private String ridMktCamMst;
    private LoyRulesetDtlResDto rulesetDtl;                    // 정보

    private List<LoyRulesetPymntPolicyListResDto> rulesetPymntPolicyList;		// 부여기준
    private List<LoyRulesetCondProdListResDto> rulesetCondProdList;			// 대상상품
    private List<LoyRulesetCondChnlListResDto> rulesetCondChnlList;			// 대상경로
    private List<LoyRulesetCondOtherResDto> rulesetCondOtherList;				// 결제기준
    private List<LoyRulesetCondTimeListResDto> rulesetCondTimeList; 			//거래시간

    private List<LoyRulesetPrvBnfListResDto> rulesetPrvBnfList;	// 혜택수량 목록
    private List<LoyRuleSetLimitResDto> rulesetLimitPathList;  	// 구매채널 목록
    private LoyRulesetTranResDto rulesetTran;                  	// 거래정보
    private LoyRulesetMbrResDto rulesetMbr;                    	// 고객정보
    private LoyRulesetSdayResDto rulesetSday;                  	// 기념일
    private List<LoyRuleSetProdResDto> ruleSetProdList;			// 대상 상품
    private List<LoyRulesetCondAmtResDto> rulesetCondAmtList;		// 조건-금액 목록
    private List<LoyRuleSetLimitResDto> ruleSetLimitPathList;		// 대상경로
    private List<LoyRuleSetLimitResDto> ruleSetLimitCardList;		// 대상경로
    private List<LoyRuleSetMstResDto> ruleSetMstList;				// 부여기준
    private List<LoyRulesetPaymentStandardListResDto> rulesetPymntStandardList; //결제수단
    private List<LoyRulesetSpecificDayListResDto> rulesetSpecificDayList; //특정일


    public List<LoyRuleSetLimitResDto> getRulesetLimitPathList() {
        return rulesetLimitPathList;
    }

    public void setRulesetLimitPathList(List<LoyRuleSetLimitResDto> rulesetLimitPathList) {
        this.rulesetLimitPathList = rulesetLimitPathList;
    }

    public String getRidMktCamMst() {
        return ridMktCamMst;
    }

    public void setRidMktCamMst(String ridMktCamMst) {
        this.ridMktCamMst = ridMktCamMst;
    }

    public LoyRulesetDtlResDto getRulesetDtl() {
        return rulesetDtl;
    }

    public void setRulesetDtl(LoyRulesetDtlResDto rulesetDtl) {
        this.rulesetDtl = rulesetDtl;
    }

    public List<LoyRulesetPrvBnfListResDto> getRulesetPrvBnfList() {
        return rulesetPrvBnfList;
    }

    public void setRulesetPrvBnfList(List<LoyRulesetPrvBnfListResDto> rulesetPrvBnfList) {
        this.rulesetPrvBnfList = rulesetPrvBnfList;
    }

    public LoyRulesetTranResDto getRulesetTran() {
        return rulesetTran;
    }

    public void setRulesetTran(LoyRulesetTranResDto rulesetTran) {
        this.rulesetTran = rulesetTran;
    }

    public LoyRulesetMbrResDto getRulesetMbr() {
        return rulesetMbr;
    }

    public void setRulesetMbr(LoyRulesetMbrResDto rulesetMbr) {
        this.rulesetMbr = rulesetMbr;
    }

    public LoyRulesetSdayResDto getRulesetSday() {
        return rulesetSday;
    }

    public void setRulesetSday(LoyRulesetSdayResDto rulesetSday) {
        this.rulesetSday = rulesetSday;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public List<LoyRulesetPymntPolicyListResDto> getRulesetPymntPolicyList() {
		return rulesetPymntPolicyList;
	}

	public void setRulesetPymntPolicyList(List<LoyRulesetPymntPolicyListResDto> rulesetPymntPolicyList) {
		this.rulesetPymntPolicyList = rulesetPymntPolicyList;
	}

	public List<LoyRulesetCondProdListResDto> getRulesetCondProdList() {
		return rulesetCondProdList;
	}

	public void setRulesetCondProdList(List<LoyRulesetCondProdListResDto> rulesetCondProdList) {
		this.rulesetCondProdList = rulesetCondProdList;
	}

	public List<LoyRulesetCondChnlListResDto> getRulesetCondChnlList() {
		return rulesetCondChnlList;
	}

	public void setRulesetCondChnlList(List<LoyRulesetCondChnlListResDto> rulesetCondChnlList) {
		this.rulesetCondChnlList = rulesetCondChnlList;
	}

	public List<LoyRulesetCondAmtResDto> getRulesetCondAmtList() {
		return rulesetCondAmtList;
	}

	public void setRulesetCondAmtList(List<LoyRulesetCondAmtResDto> rulesetCondAmtList) {
		this.rulesetCondAmtList = rulesetCondAmtList;
	}

	public List<LoyRulesetCondOtherResDto> getRulesetCondOtherList() {
		return rulesetCondOtherList;
	}

	public void setRulesetCondOtherList(List<LoyRulesetCondOtherResDto> rulesetCondOtherList) {
		this.rulesetCondOtherList = rulesetCondOtherList;
	}

	public List<LoyRuleSetProdResDto> getRuleSetProdList() {
		return ruleSetProdList;
	}

	public void setRuleSetProdList(List<LoyRuleSetProdResDto> ruleSetProdList) {
		this.ruleSetProdList = ruleSetProdList;
	}

	public List<LoyRuleSetLimitResDto> getRuleSetLimitPathList() {
		return ruleSetLimitPathList;
	}

	public void setRuleSetLimitPathList(List<LoyRuleSetLimitResDto> ruleSetLimitPathList) {
		this.ruleSetLimitPathList = ruleSetLimitPathList;
	}

	public List<LoyRuleSetLimitResDto> getRuleSetLimitCardList() {
		return ruleSetLimitCardList;
	}

	public void setRuleSetLimitCardList(List<LoyRuleSetLimitResDto> ruleSetLimitCardList) {
		this.ruleSetLimitCardList = ruleSetLimitCardList;
	}

	public List<LoyRuleSetMstResDto> getRuleSetMstList() {
		return ruleSetMstList;
	}

	public void setRuleSetMstList(List<LoyRuleSetMstResDto> ruleSetMstList) {
		this.ruleSetMstList = ruleSetMstList;
	}

	public List<LoyRulesetCondTimeListResDto> getRulesetCondTimeList() {
		return rulesetCondTimeList;
	}

	public void setRulesetCondTimeList(List<LoyRulesetCondTimeListResDto> rulesetCondTimeList) {
		this.rulesetCondTimeList = rulesetCondTimeList;
	}

	public List<LoyRulesetPaymentStandardListResDto> getRulesetPymntStandardList() {
		return rulesetPymntStandardList;
	}

	public void setRulesetPymntStandardList(List<LoyRulesetPaymentStandardListResDto> rulesetPymntStandardList) {
		this.rulesetPymntStandardList = rulesetPymntStandardList;
	}

	public List<LoyRulesetSpecificDayListResDto> getRulesetSpecificDayList() {
		return rulesetSpecificDayList;
	}

	public void setRulesetSpecificDayList(List<LoyRulesetSpecificDayListResDto> rulesetSpecificDayList) {
		this.rulesetSpecificDayList = rulesetSpecificDayList;
	}



}
