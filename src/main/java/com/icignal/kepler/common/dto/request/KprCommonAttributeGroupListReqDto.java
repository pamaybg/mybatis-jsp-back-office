package com.icignal.kepler.common.dto.request;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: KPRCommonAttributeGroupListRequestDTO
 * 2. 파일명	: KPRCommonAttributeGroupListRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2016. 6. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *		속성그룹 목록 RequestDTO
 * </PRE>
 */ 
public class KprCommonAttributeGroupListReqDto extends MKTBaseReqDto {
	
	private String logicalCompId;  //로지컬컴포넌트 아이디
	private String atribGroupId;   //어트리뷰트 그룹 아이디

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

    public String getAtribGroupId() {
        return atribGroupId;
    }

    public void setAtribGroupId(String atribGroupId) {
        this.atribGroupId = atribGroupId;
    }
}
