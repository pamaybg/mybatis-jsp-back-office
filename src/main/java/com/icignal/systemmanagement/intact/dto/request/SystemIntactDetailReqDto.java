package com.icignal.systemmanagement.intact.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: SystemIntactDetailReqDto
 * 2. 파일명	: SystemIntactDetailReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.intact.dto.request
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		인터렉션 유형 상세 Request DTO
 * </PRE>
 */ 
public class SystemIntactDetailReqDto extends MKTBaseReqDto {
    
    private String rid;           //RID
    private String intactType1Cd; //인터렉션 유형 1 코드
    private String intactType2Cd; //인터렉션 유형 2 코드
    private String saveTblNm;     //저장 테이블 명
    
    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getIntactType1Cd() {
        return intactType1Cd;
    }

    public void setIntactType1Cd(String intactType1Cd) {
        this.intactType1Cd = intactType1Cd;
    }

    public String getIntactType2Cd() {
        return intactType2Cd;
    }

    public void setIntactType2Cd(String intactType2Cd) {
        this.intactType2Cd = intactType2Cd;
    }

    public String getSaveTblNm() {
        return saveTblNm;
    }

    public void setSaveTblNm(String saveTblNm) {
        this.saveTblNm = saveTblNm;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
