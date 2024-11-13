package com.icignal.kepler.segment.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : infavor.kepler.segment.dto.request
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 세그먼트 로지컬 컴포넌트 목록 RequestDTO
 */
public class KprLogicalComponentListReqDto extends CommonDataAuthReqDto {
	
    private String accountId;   //어카운트 아이디

    public String getAccountId() {
        return accountId;
    }

    public void setAccountId(String accountId) {
        this.accountId = accountId;
    }
	
}
