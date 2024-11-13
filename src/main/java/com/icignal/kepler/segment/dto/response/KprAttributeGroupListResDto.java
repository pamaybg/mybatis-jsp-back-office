package com.icignal.kepler.segment.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.segment.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : 속성그룹 목록 ResponseDTO
 */
public class KprAttributeGroupListResDto extends GridPagingItemResDto {
	
    private String atribGroupId;     //아이디
    private String atribGroupName;     //생성자명
    private String id;
    private String text;
    
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

	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getAtribGroupId() {
        return atribGroupId;
    }

    public void setAtribGroupId(String atribGroupId) {
        this.atribGroupId = atribGroupId;
    }

    public String getAtribGroupName() {
        return atribGroupName;
    }

    public void setAtribGroupName(String atribGroupName) {
        this.atribGroupName = atribGroupName;
    }



}
