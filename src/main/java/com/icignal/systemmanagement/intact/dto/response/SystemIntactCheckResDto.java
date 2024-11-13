package com.icignal.systemmanagement.intact.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

/*
 * 1. 클래스명	: SystemIntactCheckResDto
 * 2. 파일명	: SystemIntactCheckResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.intact.dto.response
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		인터렉션 유형 체크 Response DTO
 * </PRE>
 */ 
public class SystemIntactCheckResDto {
    
    private Integer chkCount;         //체크 결과 개수
    
    public Integer getChkCount() {
        return chkCount;
    }

    public void setChkCount(Integer chkCount) {
        this.chkCount = chkCount;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
