package com.icignal.kepler.logicalComponent.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/*
 * 1. 클래스명	: KPRLogicalComponentJoinAccordionListResponseDTO
 * 2. 파일명	: KPRLogicalComponentJoinAccordionListResponseDTO.java
 * 3. 패키지명	: com.icignal.kepler.logicalComponent.dto.response
 * 4. 작성자명	: 예준호
 * 5. 작성일자	: 2016. 6. 30.
 */
/**
 * <PRE>
 * 1. 설명
 *		조인설정 > 왼쪽 어코디언 리스트 반응 DTO
 * </PRE>
 */ 
public class KprLogicalComponentJoinAccordionListResDto extends StatusResDto {

	private String id;
	private String text;
	private List<KprLogicalComponentJoinAccordionTreeNodeListResDto> treeList;
	
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
	public List<KprLogicalComponentJoinAccordionTreeNodeListResDto> getTreeList() {
		return treeList;
	}
	public void setTreeList(List<KprLogicalComponentJoinAccordionTreeNodeListResDto> treeList) {
		this.treeList = treeList;
	}
}