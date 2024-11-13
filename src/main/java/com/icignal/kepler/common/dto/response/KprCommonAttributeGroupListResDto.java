package com.icignal.kepler.common.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/*
 * 1. 클래스명	: KPRCommonAttributeGroupListResponseDTO
 * 2. 파일명	: KPRCommonAttributeGroupListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.response
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2016. 6. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *		속성그룹 목록 ResponseDTO
 * </PRE>
 */ 
public class KprCommonAttributeGroupListResDto extends GridPagingItemResDto{
	
    private String id;      //어트리뷰트그룹 아이디
    private String text;    //어트리뷰트그룹명;
    
    private List<KprCommonAttributeGroupColumnListResDto>  treeList;   //어트리뷰트그룹컬럼 목록
    
    public String getId() {
        return id;
    }
    
    public void setId(String id) {
        this.id = id;
    }
    
    public String getText() {
        return text;
    }
    
    public void setText(String text) {
        this.text = text;
    }

    public List<KprCommonAttributeGroupColumnListResDto> getTreeList() {
        return treeList;
    }

    public void setTreeList(List<KprCommonAttributeGroupColumnListResDto> treeList) {
        this.treeList = treeList;
    }
}
