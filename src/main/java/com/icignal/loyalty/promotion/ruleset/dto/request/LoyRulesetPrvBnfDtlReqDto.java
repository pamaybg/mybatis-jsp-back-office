package com.icignal.loyalty.promotion.ruleset.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.common.util.ObjectUtil;

public class LoyRulesetPrvBnfDtlReqDto extends CommonDataAuthReqDto {
    
    private String rid;              //RID
    private String rulesetId;        //룰셋헤더ID
    private String minMat;           //최소금액
    private String maxAmt;           //최대금액
    private String acrlType;         //적립유형
    private String acrlAmt;          //적립금액
    
    private String dataStatus;
    
    public String getDataStatus() {
        return dataStatus;
    }
    public void setDataStatus(String dataStatus) {
        this.dataStatus = dataStatus;
    }
    public String getRid() {
        return rid;
    }
    public void setRid(String rid) {
        this.rid = rid;
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
    	String mat = minMat;
        if (ObjectUtil.isEmpty(minMat)) {
            mat = "0";
        }
        else {
            mat = minMat.replaceAll(",", "");
        }
        this.minMat = mat;
    }
    public String getMaxAmt() {
        return maxAmt;
    }
    public void setMaxAmt(String maxAmt) {
    	String amt = maxAmt;
        if (ObjectUtil.isEmpty(maxAmt)) {
            amt = "0";
        }
        else {
            amt = maxAmt.replaceAll(",", "");
        }
        this.maxAmt = amt;
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
    	String amt = acrlAmt;
        if (ObjectUtil.isEmpty(acrlAmt)) {
            amt = "0";
        }
        else {
            amt = acrlAmt.replaceAll(",", "");
        }
        this.acrlAmt = amt;
    }
    
}
