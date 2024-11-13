package com.icignal.onlineapproval.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MKTElapprovalDetailRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 전자 결제 상세 조회
 */
public class ApprovalDetailReqDto extends CommonDataAuthReqDto {
    
    private String id;     			   //아이디
    private String accntId;     	   //어카운트ID
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getAccntId() {
        return accntId;
    }
    
    public void setAccntId(String accntId) {
        this.accntId = accntId;
    }
    
}
