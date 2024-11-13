package com.icignal.kepler.segment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 목록 RequestDTO
 */
public class KprSegmentListReqDto extends CommonDataAuthReqDto {
	
    private String accountId;   //어카운트 아이디
    private String empId;
    private String authType;
    private String brandCd;

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }

    public String getEmpId() {return empId;}

    public void setEmpId(String empId) {this.empId = empId;}

    public String getAuthType() {return authType;}

    public void setAuthType(String authType) {this.authType = authType;}

    public String getBrandCd() {return brandCd;}

    public void setBrandCd(String brandCd) {this.brandCd = brandCd;}
	
}
