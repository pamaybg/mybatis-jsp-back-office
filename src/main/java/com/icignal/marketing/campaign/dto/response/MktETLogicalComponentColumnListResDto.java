package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @name : infavor.marketing.campaign.dto.response
 * @date : 2016. 11. 16.
 * @author : dg.ryu
 * @description : et 로지컬컴포넌트 컬럼 목록 ResDto
 */
public class MktETLogicalComponentColumnListResDto {
	
	private String id;				 //id
    private String columnName;      //컬럼명
    private String displayName;     //표시명
    private String alias;
    
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getColumnName() {
        return columnName;
    }

    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}



}
