package com.icignal.marketing.common.checker.dto.response;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @name : infavor.marketing.common.checker.dto.response
 * @date : 2015. 11. 10.
 * @author : 류동균
 * @description : 
 */
public class MktCheckerResDto {
    
    private int successCount;    //성공 건수
    
    private int failCount;     //실패 건수
    
    private List<MktCheckerListResDto> memberList;    //회원 목록
    private List<String> successMember;
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public List<MktCheckerListResDto> getMemberList() {
        return memberList;
    }

    public void setMemberList(List<MktCheckerListResDto> memberList) {
        this.memberList = memberList;
    }

    public int getSuccessCount() {
        return successCount;
    }

    public void setSuccessCount(int successCount) {
        this.successCount = successCount;
    }

    public int getFailCount() {
        return failCount;
    }

    public void setFailCount(int failCount) {
        this.failCount = failCount;
    }

	public List<String> getSuccessMember() {
		return successMember;
	}

	public void setSuccessMember(List<String> successMember) {
		this.successMember = successMember;
	}

}
