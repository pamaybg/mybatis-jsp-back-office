package com.icignal.systemmanagement.unstruc.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: LoyUnstrucListReqDto
 * 2. 파일명	: LoyUnstrucListReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.unstruc.dto.request
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *		이벤트 정형/비정형 목록 Request DTO
 * </PRE>
 */ 
public class SystemUnstrucListReqDto extends CommonDataAuthReqDto {

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
