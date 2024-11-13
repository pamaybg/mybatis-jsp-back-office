package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 18.
 * @author : 이원준
 * @description : 주제영역 목록 ResponseDTO
 */
public class KprSubjectAreaTreeResDto extends GridPagingItemResDto {
    
    private String id;    			//아이디
    private String text;    		//명
    private String parentId;    //부모아이디
    private Integer seq;   		 //순서
    
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
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
}
