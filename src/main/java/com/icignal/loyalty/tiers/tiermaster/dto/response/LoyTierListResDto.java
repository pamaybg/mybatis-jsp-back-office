package com.icignal.loyalty.tiers.tiermaster.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 그룹별로 등급 목록 Response DTO
 *
 * @name : infavor.loyalty.offer.dto.response.MKTTierListResponseDTO
 * @date : 2017. 11. 22.
 * @author : jh.kim
 * @description :
 */
@CommCode
public class LoyTierListResDto extends GridPagingItemResDto {

    private String ridTier;
    private String tierGrpNm;
    private String tierNm;
    private String tierCd;

    private String custGradeCd;
    private String acrlType;
    
    @MarkName(groupCode="LOY_ACRL_TYPE" , codeField="acrlType")
    private String acrlName;
    private String acrlAmt;
    private String ridRulesetMbr;


    public String getRidTier() {
        return ridTier;
    }
    public void setRidTier(String ridTier) {
        this.ridTier = ridTier;
    }
    public String getTierGrpNm() {
        return tierGrpNm;
    }
    public void setTierGrpNm(String tierGrpNm) {
        this.tierGrpNm = tierGrpNm;
    }
    public String getTierNm() {
        return tierNm;
    }
    public void setTierNm(String tierNm) {
        this.tierNm = tierNm;
    }
    public String getTierCd() {
        return tierCd;
    }
    public void setTierCd(String tierCd) {
        this.tierCd = tierCd;
    }
	public String getCustGradeCd() {
		return custGradeCd;
	}
	public void setCustGradeCd(String custGradeCd) {
		this.custGradeCd = custGradeCd;
	}
	public String getAcrlType() {
		return acrlType;
	}
	public void setAcrlType(String acrlType) {
		this.acrlType = acrlType;
	}
	public String getAcrlAmt() {
		return acrlAmt;
	}
	public void setAcrlAmt(String acrlAmt) {
		this.acrlAmt = acrlAmt;
	}
	public String getRidRulesetMbr() {
		return ridRulesetMbr;
	}
	public void setRidRulesetMbr(String ridRulesetMbr) {
		this.ridRulesetMbr = ridRulesetMbr;
	}


}
