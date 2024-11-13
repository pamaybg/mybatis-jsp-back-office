package com.icignal.marketing.campaign.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.marketing.campaign.dto.response
 * @date : 2016. 6. 10.
 * @author : 류동균
 * @description : et 컴포넌트 목록 ResDto
 */
public class MktETLogicalComponentListResDto extends GridPagingItemResDto {
	
    private String logicalCompId;   //로지컬 컴포넌트 아이디
    private String createByName;     //생성자
    private String createDate;     //생성일시
    private String logicalCompName; //로지컬 컴포넌트명
    private String logicalCompDesc; //로지컬 컴포넌트 설명
    private String logicalCompUseFlag;  //사욭가능 여부
	
	public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getLogicalCompId() {
        return logicalCompId;
    }

    public void setLogicalCompId(String logicalCompId) {
        this.logicalCompId = logicalCompId;
    }

    public String getCreateByName() {
        return createByName;
    }

    public void setCreateByName(String createByName) {
        this.createByName = createByName;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getLogicalCompName() {
        return logicalCompName;
    }

    public void setLogicalCompName(String logicalCompName) {
        this.logicalCompName = logicalCompName;
    }

    public String getLogicalCompDesc() {
        return logicalCompDesc;
    }

    public void setLogicalCompDesc(String logicalCompDesc) {
        this.logicalCompDesc = logicalCompDesc;
    }

    public String getLogicalCompUseFlag() {
        return logicalCompUseFlag;
    }

    public void setLogicalCompUseFlag(String logicalCompUseFlag) {
        this.logicalCompUseFlag = logicalCompUseFlag;
    }

}
