package com.icignal.systemmanagement.intact.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/*
 * 1. 클래스명	: SystemIntactListReqDto
 * 2. 파일명	: SystemIntactListReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.intact.dto.request
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		인터렉션 유형 목록 Request DTO
 * </PRE>
 */ 
public class SystemIntactListReqDto extends CommonDataAuthReqDto {

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
