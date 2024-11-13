package com.icignal.loyalty.promotion.ruleset.dto.response;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/**
 * RuleSet > 지급정책 (탭) 목록 Response DTO
 *
 * @name : infavor.loyalty.ruleSet.dto.response.LOYRulesetPymntPolicyListResponseDTO
 * @date : 2018. 07. 16.
 * @author : jk.kim
 * @description :
 */
public class LoyRulesetPymntPolicyListResDto extends MKTBaseReqDto {

    private String rid;              //RID
    private String createBy;         //생성자
    private String modifyBy;         //수정자
    private String createDate;       //생성일시
    private String modifyDate;       //수정일시
    private String rulesetId;        //룰셋헤더ID
    private String minMat;           //최소금액
    private String maxAmt;           //최대금액
    private String acrlType;         //적립유형
    private String acrlTypeNm;       //적립유형
    private String acrlAmt;          //적립금액
    private String tierNm;			 //등급
    private String custGradeCd;		 //등급 코드
    private String acrlName;		 //적립유형
    
    private String minCnt;			 //구매횟수
    private String minAmt;			 //구매금액
    private String mbrCnt;			 //인원
    private String tierRid;			 //등급 RID



    public String getAcrlTypeNm() {
        return acrlTypeNm;
    }
    public void setAcrlTypeNm(String acrlTypeNm) {
        this.acrlTypeNm = acrlTypeNm;
    }
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
    public String getMinMat() {
        return minMat;
    }
    public void setMinMat(String minMat) {
        this.minMat = minMat;
    }
    public String getMaxAmt() {
        return maxAmt;
    }
    public void setMaxAmt(String maxAmt) {
        this.maxAmt = maxAmt;
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
	public String getTierNm() {
		return tierNm;
	}
	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}
	public String getCustGradeCd() {
		return custGradeCd;
	}
	public void setCustGradeCd(String custGradeCd) {
		this.custGradeCd = custGradeCd;
	}
	public String getAcrlName() {
		return acrlName;
	}
	public void setAcrlName(String acrlName) {
		this.acrlName = acrlName;
	}
	public String getMinCnt() {
		return minCnt;
	}
	public void setMinCnt(String minCnt) {
		this.minCnt = minCnt;
	}
	public String getMinAmt() {
		return minAmt;
	}
	public void setMinAmt(String minAmt) {
		this.minAmt = minAmt;
	}
	public String getMbrCnt() {
		return mbrCnt;
	}
	public void setMbrCnt(String mbrCnt) {
		this.mbrCnt = mbrCnt;
	}
	public String getTierRid() {
		return tierRid;
	}
	public void setTierRid(String tierRid) {
		this.tierRid = tierRid;
	}



}
